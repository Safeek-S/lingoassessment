import 'package:flutter/material.dart';
import 'package:lingoassessment/src/services/auth_service/auth_service.dart';
import 'package:lingoassessment/src/services/remote_storage_service/remote_storage_service.dart';
import '../../core/utils/service_result.dart';
import '../../core/utils/validations.dart';
import '../widgets/snackbar.dart';

class SignUpScreenViewModel extends ChangeNotifier {
  final AuthService authService;
  final RemoteStorageService remoteStorageService;
  bool isLoading = false;

  SignUpScreenViewModel(this.authService, this.remoteStorageService);

  void validateUserFields(
      String email, String password, String userName, context) async {
    isLoading = true;

    String? emailError = Validation.emailValidator(email);
    String? passwordError = Validation.emptyFieldValidator(password);
    String? userNameError = Validation.emptyFieldValidator(userName);

    if (emailError == null && passwordError == null && userNameError == null) {
      await signUpUser(email, password, userName, context);
    } else {
      // Show error messages
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> signUpUser(
      String email, String password, String userName, context) async {
    try {
      var result = await authService.registerUserWithEmaiAndPassword(
        email,
        password,
      );
      if (result.statusCode == StatusCode.error) {
        showSnackbar(context, result.message);
        isLoading = false;
      } else if (result.statusCode == StatusCode.failure) {
        showSnackbar(context, result.message);
        isLoading = false;
      } else if (result.statusCode == StatusCode.success) {
        await storeUserInfoInRemoteStorage(
            userName, email, password, result.data, context);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  Future<void> storeUserInfoInRemoteStorage(String userName, String email,
      String password, String userId, context) async {
    try {
      var info = {'username': userName, 'email': email, 'password': password};
      var result = await remoteStorageService.storeUserInfo(info, userId);

      if (result.statusCode == StatusCode.error) {
        showSnackbar(context, result.message);
        isLoading = false;
      } else if (result.statusCode == StatusCode.failure) {
        showSnackbar(context, result.message);
        isLoading = false;
      } else if (result.statusCode == StatusCode.success) {
        isLoading = false;

        navigateToLoginScreen(context);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  String? validateField(String? value, String field) {
    switch (field) {
      case 'Email':
        return Validation.emailValidator(value!);
      case 'Password':
        return Validation.emptyFieldValidator(value!);
      case 'Name':
        return Validation.emptyFieldValidator(value!);
      default:
        return null;
    }
  }
}
