import 'package:flutter/material.dart';
import 'package:lingoassessment/src/core/utils/service_result.dart';
import 'package:lingoassessment/src/models/product_model.dart';
import 'package:lingoassessment/src/services/api_service/api_service.dart';
import 'package:lingoassessment/src/services/remote_config_service/remote_config_service.dart';

import '../widgets/snackbar.dart';

class ProductsDisplayScreenViewModel extends ChangeNotifier {
  final ApiService apiService;
  final RemoteConfigService remoteConfigService;
  bool isLoading = false;

  ProductsDisplayScreenViewModel(this.apiService, this.remoteConfigService);

  bool showDiscountedPrice = false;
  List<ProductModel> products = [];

  Future<void> fetchShowDiscountedPrice() async {
    isLoading = true;
    showDiscountedPrice = remoteConfigService.showDiscountedPrice;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProductsFromApi(context) async {
    isLoading = true;
    notifyListeners();

    try {
      var result = await apiService.fetchProducts();
       if (result.statusCode == StatusCode.error) {
        print(result.message);
        showSnackbar(context, result.message);
      } else if (result.statusCode == StatusCode.failure) {
         showSnackbar(context, result.message);
      } else if (result.statusCode == StatusCode.success) {
        products = result.data;
      }
      // Handle error or failure statuses appropriately
    } catch (e) {
      print(e.toString());
      // Handle the error, for example by showing a snackbar or a message in the UI
    }

    isLoading = false;
    notifyListeners();
  }
}
