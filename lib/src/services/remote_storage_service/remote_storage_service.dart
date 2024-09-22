import 'package:lingoassessment/src/core/utils/service_result.dart';

abstract class RemoteStorageService{
  Future<ServiceResult<bool>> storeUserInfo(Map<String,String> info, String docId);
}