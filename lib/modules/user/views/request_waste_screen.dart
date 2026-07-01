import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../modules/user/controllers/waste_controller.dart';
import '../../../modules/auth/controllers/auth_controller.dart';

class WasteRequestScreen extends StatefulWidget {
  const WasteRequestScreen({super.key});

  @override
  State<WasteRequestScreen> createState() => _WasteRequestScreenState();
}

class _WasteRequestScreenState extends State<WasteRequestScreen> {
  final _quantityController = TextEditingController();
  final controller = Get.put(WasteController());
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.detectLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Waste Pickup')),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(
              () => Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upload Waste Photo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      if (controller.selectedImage.value != null)
                        Image.file(
                          controller.selectedImage.value!,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      else
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(child: Text('No photo selected')),
                        ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Camera'),
                              onPressed: () =>
                                  controller.pickImage(ImageSource.camera),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Gallery'),
                              onPressed: () =>
                                  controller.pickImage(ImageSource.gallery),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Waste Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: controller.selectedType.value,
                        items: controller.wasteTypes
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => controller.selectedType.value =
                            value ?? controller.wasteTypes.first,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Quantity (KG)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter quantity in kg',
                        ),
                        onChanged: (value) =>
                            controller.quantityText.value = value,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Pickup Location',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(controller.locationText.value)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estimated charge',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text(
                        controller.price == 0
                            ? 'Custom price'
                            : '₹ ${controller.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: controller.isSubmitting.value
                    ? null
                    : () => controller.submitRequest(
                        authController.firebaseUser.value?.uid ?? '',
                      ),
                child: controller.isSubmitting.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
