import 'package:get/get.dart';
import '../modules/auth/views/forgot_password_screen.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/otp_screen.dart';
import '../modules/auth/views/onboarding_screen.dart';
import '../modules/auth/views/signup_screen.dart';
import '../modules/auth/views/splash_screen.dart';
import '../modules/admin/views/admin_dashboard_screen.dart';
import '../modules/admin/views/admin_requests_screen.dart';
import '../modules/payment/views/payment_screen.dart';
import '../modules/user/views/request_waste_screen.dart';
import '../modules/user/views/user_dashboard_screen.dart';
import '../modules/worker/views/worker_dashboard_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.signup, page: () => const SignupScreen()),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(name: Routes.otp, page: () => const OtpScreen()),
    GetPage(
      name: Routes.userDashboard,
      page: () => const UserDashboardScreen(),
    ),
    GetPage(name: Routes.wasteRequest, page: () => const WasteRequestScreen()),
    GetPage(
      name: Routes.adminDashboard,
      page: () => const AdminDashboardScreen(),
    ),
    GetPage(
      name: Routes.adminRequests,
      page: () => const AdminRequestsScreen(),
    ),
    GetPage(name: Routes.payment, page: () => const PaymentScreen()),
    GetPage(
      name: Routes.workerDashboard,
      page: () => const WorkerDashboardScreen(),
    ),
  ];
}
