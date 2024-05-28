import 'package:cash_track/auth/sign_up_page/sign_up_view.dart';
import 'package:cash_track/pages/others/home_page/home_view.dart';
import 'package:cash_track/pages/tabs/main_layout_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String homePage = '/homePage';
  static const String registrationPage = '/';
  static const String mainLayoutPage = '/mainLayoutPage';

  // static const String splashScreenPage = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Map<String, WidgetBuilder> routes = {
      homePage: (context) => HomeView(),
      registrationPage: (context) => SignUpView(),
      // forgotPasswordPage: (context) => ForgetPasswordView(),
      // registrationPage: (context) => RegistrationView(),
      // resetPasswordSuccessPage: (context) => PasswordResetSuccessView(),
      // chatSession: (context) => const MainChatView(),
      // splashScreenPage: (context) => SplashScreenView(),
      mainLayoutPage: (context) => const MainLayoutView(),
      // onboardingPage: (context) => const OnboardingView(),
      // editProfilePage: (context) => const ProfileEditTabView(),
    };

    return MaterialPageRoute(
      builder: routes[settings.name] ??
          (context) => throw const FormatException('No Routes Found'),
    );
  }
}
