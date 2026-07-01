import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/services/firestore_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../models/waste_request_model.dart';

class WasteController extends GetxController {
  final selectedImage = Rxn<File>();
  final selectedType = 'Plastic Waste'.obs;
  final quantityText = ''.obs;
  final locationText = 'Fetching current location...'.obs;
  final isSubmitting = false.obs;

  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();

  final _picker = ImagePicker();

  List<String> get wasteTypes => [
    'Plastic Waste',
    'Dry Waste',
    'Wet Waste',
    'Electronic Waste',
    'Metal Waste',
    'Construction Waste',
  ];

  int get price {
    final quantity = double.tryParse(quantityText.value) ?? 0;
    if (quantity > 0 && quantity <= 5) return 50;
    if (quantity <= 10) return 100;
    if (quantity <= 20) return 200;
    return 0;
  }

  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 80);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<void> detectLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    locationText.value = '37.4219, -122.0840 — Green City Sector';
  }

  Future<void> submitRequest(String userId) async {
    if (selectedImage.value == null) {
      Get.snackbar('Error', 'Please add a waste photo before submitting.');
      return;
    }
    if (quantityText.value.isEmpty ||
        double.tryParse(quantityText.value) == null) {
      Get.snackbar('Error', 'Enter a valid quantity in KG.');
      return;
    }
    isSubmitting.value = true;
    try {
      final requestId = const Uuid().v4();
      final imageUrl = await _storageService.uploadImage(
        selectedImage.value!,
        'waste_requests/$requestId.jpg',
      );
      final locationParts = locationText.value.split(' — ').first.split(',');
      final latitude = double.tryParse(locationParts[0]) ?? 0;
      final longitude = double.tryParse(locationParts[1]) ?? 0;
      final request = WasteRequestModel(
        requestId: requestId,
        userId: userId,
        imageUrl: imageUrl,
        wasteType: selectedType.value,
        quantity: double.parse(quantityText.value),
        amount: price == 0 ? 0 : price,
        latitude: latitude,
        longitude: longitude,
        status: AppConstants.statusPending,
        paymentStatus: AppConstants.statusPending,
        workerId: '',
        createdAt: DateTime.now(),
      );
      await _firestoreService.createWasteRequest(request);
      Get.snackbar('Success', 'Waste request submitted successfully.');
      selectedImage.value = null;
      quantityText.value = '';
      selectedType.value = wasteTypes.first;
    } catch (error) {
      Get.snackbar('Submission failed', error.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
