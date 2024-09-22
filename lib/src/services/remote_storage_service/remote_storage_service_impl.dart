import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingoassessment/src/core/utils/service_result.dart';
import 'package:lingoassessment/src/core/utils/utils.dart';
import 'package:lingoassessment/src/services/remote_storage_service/remote_storage_service.dart';

class RemoteStorageServiceImpl implements RemoteStorageService {
  final FirebaseFirestore firestore;
  RemoteStorageServiceImpl(this.firestore);
  @override
  Future<ServiceResult<bool>> storeUserInfo(
      Map<String, String> info, String docId) async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        await firestore.collection('Users').doc(docId).set(info);
        return ServiceResult(
            StatusCode.success, 'Successfully added user', true);
      } else {
        return ServiceResult(StatusCode.failure,
            'No Internet!, Please check your connection', false);
      }
    } on FirebaseException catch (e) {
      return ServiceResult(StatusCode.error, e.code, false);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), false);
    }
  }
}
