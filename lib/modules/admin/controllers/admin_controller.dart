import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/services/firestore_service.dart';
import '../../../models/waste_request_model.dart';

class AdminController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final pendingRequests = <WasteRequestModel>[].obs;
  final isLoading = false.obs;

  Future<void> loadPendingRequests() async {
    isLoading.value = true;
    pendingRequests.value = await _firestoreService.fetchPendingRequests();
    isLoading.value = false;
  }

  Future<void> approveRequest(String requestId) async {
    await _firestoreService.updateWasteRequestStatus(
      requestId,
      AppConstants.statusApproved,
    );
    await loadPendingRequests();
  }

  Future<void> rejectRequest(String requestId) async {
    await _firestoreService.updateWasteRequestStatus(
      requestId,
      AppConstants.statusRejected,
    );
    await loadPendingRequests();
  }
}
