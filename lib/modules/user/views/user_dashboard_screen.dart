import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../modules/auth/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  Widget _buildCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withAlpha((0.18 * 255).round()),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoBin User'),
        actions: [
          IconButton(
            onPressed: authController.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Report waste, track requests, and manage payments from one place.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            _buildCard(
              'Active Requests',
              '4',
              Icons.handshake,
              AppColors.secondary,
            ),
            _buildCard(
              'Total Waste',
              '12.5 kg',
              Icons.recycling,
              AppColors.primary,
            ),
            _buildCard(
              'Pending Payments',
              '₹ 220',
              Icons.payment,
              AppColors.accent,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
              onPressed: () => Get.toNamed(Routes.wasteRequest),
              child: const Text('Create Collection Request'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: AppColors.secondary,
              ),
              onPressed: () => Get.toNamed('/payment'),
              child: const Text('Pay Outstanding Charges'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildRequestItem(
              'Dry Waste Pickup',
              'Pending approval',
              Colors.orange,
            ),
            _buildRequestItem(
              'Plastic Waste',
              'Worker assigned',
              AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestItem(String title, String status, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha((0.12 * 255).round()),
          child: Icon(Icons.circle, color: color, size: 18),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
