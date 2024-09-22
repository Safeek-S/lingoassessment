import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lingoassessment/src/core/utils/utils.dart';
import 'package:lingoassessment/src/services/remote_config_service/remote_config_service.dart';

import '../../core/utils/service_result.dart';

class RemoteConfigServiceImpl implements RemoteConfigService {
  final FirebaseRemoteConfig firebaseRemoteConfig;

  RemoteConfigServiceImpl(this.firebaseRemoteConfig);
  // Default value in case the Remote Config fetch fails
  static const _defaultConfig = {
    'showDiscountedPrice': true, // Default to show original price
  };

  // Initialize and fetch the remote config
  @override
  Future<ServiceResult<bool>> initialize() async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        await firebaseRemoteConfig.setDefaults(_defaultConfig);

        // Fetch and activate the latest values from Remote Config
        await firebaseRemoteConfig.fetchAndActivate();

        return ServiceResult(StatusCode.success, 'Set the default Value', true);
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

  // Method to get the boolean value for showing discounted price
  @override
  bool get showDiscountedPrice {
    return firebaseRemoteConfig.getBool('showDiscountedPrice');
  }
}
