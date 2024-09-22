import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingoassessment/src/core/utils/utils.dart';
import 'package:lingoassessment/src/services/auth_service/auth_service.dart';

import '../../core/utils/service_result.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth firebaseAuth;
  AuthServiceImpl(this.firebaseAuth);
  @override
  Future<ServiceResult<String>> registerUserWithEmaiAndPassword(
      String email, String password) async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        var usercredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        return usercredential.user == null
            ? ServiceResult(StatusCode.failure, 'User is not available', '')
            : ServiceResult(StatusCode.success, 'User is available', usercredential.user!.uid);
      } else {
        return ServiceResult(StatusCode.failure,
            'No Internet!, Please check your connection', '');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return ServiceResult(StatusCode.error, e.code.toString(), '');
        case "invalid-email":
          return ServiceResult(StatusCode.error, e.code.toString(), '');
        case "operation-not-allowed":
          return ServiceResult(StatusCode.error, e.code.toString(), '');
        case "weak-password":
          return ServiceResult(StatusCode.error, e.code.toString(), '');
        default:
          return ServiceResult(
              StatusCode.error, 'unknown firebase error', '');
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), '');
    }
  }

  @override
  Future<ServiceResult<bool>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        var usercredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
          
        return usercredential.user == null
            ? ServiceResult(StatusCode.failure, 'User is not available', false)
            : ServiceResult(StatusCode.success, 'User is available', true);
      } else {
        return ServiceResult(StatusCode.failure,
            'No Internet!, Please check your connection', false);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return ServiceResult(StatusCode.error, e.code.toString(), false);
        case "invalid-email":
          return ServiceResult(StatusCode.error, e.code.toString(), false);
        case "user-disabled":
          return ServiceResult(StatusCode.error, e.code.toString(), false);
        case "user-not-found":
          return ServiceResult(StatusCode.error, e.code.toString(), false);
        default:
          return ServiceResult(
              StatusCode.error, e.message!, false);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), false);
    }
  }
}
