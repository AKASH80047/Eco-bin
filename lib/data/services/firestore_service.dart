import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../../models/user_model.dart';
import '../../models/waste_request_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _firestore
        .collection(AppConstants.users)
        .doc(user.userId)
        .set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    final snapshot = await _firestore
        .collection(AppConstants.users)
        .doc(userId)
        .get();
    if (!snapshot.exists) return null;
    return UserModel.fromJson(snapshot.data()!);
  }

  Future<void> createWasteRequest(WasteRequestModel request) async {
    await _firestore
        .collection(AppConstants.wasteRequests)
        .doc(request.requestId)
        .set(request.toJson());
  }

  Future<List<WasteRequestModel>> fetchPendingRequests() async {
    final query = await _firestore
        .collection(AppConstants.wasteRequests)
        .where('status', isEqualTo: AppConstants.statusPending)
        .get();
    return query.docs
        .map((doc) => WasteRequestModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> updateWasteRequestStatus(String requestId, String status) async {
    await _firestore
        .collection(AppConstants.wasteRequests)
        .doc(requestId)
        .update({'status': status});
  }
}
