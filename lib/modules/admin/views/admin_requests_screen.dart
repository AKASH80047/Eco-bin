import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';
import '../../../models/waste_request_model.dart';

class AdminRequestsScreen extends StatelessWidget {
  const AdminRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    controller.loadPendingRequests();

    return Scaffold(
      appBar: AppBar(title: const Text('Waste Requests')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.pendingRequests.isEmpty) {
          return const Center(
            child: Text('No pending requests at the moment.'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.pendingRequests.length,
          itemBuilder: (context, index) {
            final request = controller.pendingRequests[index];
            return _buildRequestCard(request, controller);
          },
        );
      }),
    );
  }

  Widget _buildRequestCard(
    WasteRequestModel request,
    AdminController controller,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.wasteType,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Quantity: ${request.quantity} kg'),
            Text('Amount: ₹${request.amount}'),
            Text('Status: ${request.status}'),
            const SizedBox(height: 10),
            if (request.imageUrl.isNotEmpty)
              Image.network(
                request.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.approveRequest(request.requestId),
                    child: const Text('Approve'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        controller.rejectRequest(request.requestId),
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
