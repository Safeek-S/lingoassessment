import 'package:lingoassessment/src/core/utils/service_result.dart';

abstract class RemoteConfigService{
/// Method to initialize and fetch remote config values
  Future<ServiceResult<bool>> initialize();

  /// Property or method to check whether to show discounted price
  bool get showDiscountedPrice;
}


