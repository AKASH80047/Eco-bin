import 'package:get/get.dart';
import '../data/services/firebase_service.dart';
import '../modules/auth/controllers/auth_controller.dart';

class InitialBinding {
  Future<void> initServices() async {
    await Get.putAsync<FirebaseService>(() async => FirebaseService().init());
    Get.put(AuthController());
  }
}
