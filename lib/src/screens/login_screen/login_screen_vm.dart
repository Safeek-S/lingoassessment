import 'package:flutter/material.dart';
import 'package:lingoassessment/src/services/auth_service/auth_service.dart';
import 'package:lingoassessment/src/services/remote_config_service/remote_config_service.dart';
import '../../core/utils/service_result.dart';
import '../../core/utils/validations.dart';
import '../widgets/snackbar.dart';

class LoginScreenViewModel extends ChangeNotifier {
  final RemoteConfigService remoteConfigService;
  final AuthService authService;
  bool isLoading = false;

  LoginScreenViewModel(this.authService, this.remoteConfigService);

  Future<void> setRemoteConfig() async {
    try {
      var result = await remoteConfigService.initialize();
      if (result.statusCode == StatusCode.error) {
      } else if (result.statusCode == StatusCode.failure) {
      } else if (result.statusCode == StatusCode.success) {}
    } catch (e) {
      print(e.toString());
    }
  }

  void validateUserFields(String email, String password, context) async {
    isLoading = true;
    notifyListeners();

    String? emailError = Validation.emailValidator(email);
    String? passwordError = Validation.emptyFieldValidator(password);

    if (emailError == null && passwordError == null) {
      await loginUser(email, password, context);
    } else {
      // Show error messages
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> loginUser(String email, String password, context) async {
    try {
      var result =
          await authService.signInWithEmailAndPassword(email, password);
      if (result.statusCode == StatusCode.error) {
        showSnackbar(context, result.message);
        isLoading = false;
      } else if (result.statusCode == StatusCode.failure) {
        showSnackbar(context, result.message);
        isLoading = false;
      } else if (result.statusCode == StatusCode.success) {
        isLoading = false;

        // Navigate to home after successful login
        navigateToProductsScreen(context);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  void navigateToProductsScreen(BuildContext context) {
    // Implement navigation logic
    Navigator.pushNamed(context, '/productsDisplayScreen');
  }

  void navigateToSignUpScreen(BuildContext context) {
    // Implement signup navigation
    Navigator.pushNamed(context, '/signupScreen');
  }

  String? validateField(String? value, String field) {
    switch (field) {
      case 'Email':
        return Validation.emailValidator(value!);
      case 'Password':
        return Validation.emptyFieldValidator(value!);
      default:
        return null;
    }
  }
}
