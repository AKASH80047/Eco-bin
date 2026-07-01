import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/services/firestore_service.dart';
import '../../../models/user_model.dart';

enum AppRole { user, admin, worker }

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final Rxn<User> firebaseUser = Rxn<User>();
  final role = AppRole.user.obs;
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, (User? user) {
      isLoggedIn.value = user != null;
      if (user != null) {
        _loadUserRole(user.uid);
      }
    });
  }

  Future<void> _loadUserRole(String userId) async {
    final userModel = await _firestoreService.getUser(userId);
    if (userModel != null) {
      role.value = userModel.role == 'admin'
          ? AppRole.admin
          : userModel.role == 'worker'
          ? AppRole.worker
          : AppRole.user;
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(
      userId: credentials.user!.uid,
      name: name,
      email: email,
      role: 'user',
      createdAt: DateTime.now(),
    );
    await _firestoreService.createUser(user);
    role.value = AppRole.user;
    Get.offAllNamed('/user-dashboard');
  }

  Future<void> login({required String email, required String password}) async {
    final credentials = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userModel = await _firestoreService.getUser(credentials.user!.uid);
    if (userModel != null) {
      role.value = userModel.role == 'admin'
          ? AppRole.admin
          : userModel.role == 'worker'
          ? AppRole.worker
          : AppRole.user;
    }
    final route = role.value == AppRole.admin
        ? '/admin-dashboard'
        : role.value == AppRole.worker
        ? '/worker-dashboard'
        : '/user-dashboard';
    Get.offAllNamed(route);
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
