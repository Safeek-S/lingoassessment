import 'package:lingoassessment/src/core/app_constants.dart';

class Validation {
  static String? emptyFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.emptyTextWarning;
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.emptyEmailWarning;
    } else if (!AppConstants.emailRegEx.hasMatch(value)) {
      return AppConstants.incorrectEmailWarning;
    } else {
      return null;
    }
  }
}
