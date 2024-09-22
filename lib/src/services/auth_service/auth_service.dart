
import 'package:lingoassessment/src/core/utils/service_result.dart';

abstract class AuthService {
  Future<ServiceResult<String>> registerUserWithEmaiAndPassword(String email, String password);
  Future<ServiceResult<bool>> signInWithEmailAndPassword(String email, String password);
}
