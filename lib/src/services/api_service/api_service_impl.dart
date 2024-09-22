import 'package:dio/dio.dart';
import 'package:lingoassessment/src/core/utils/utils.dart';
import 'package:lingoassessment/src/models/product_model.dart';
import 'package:lingoassessment/src/services/api_service/api_service.dart';

import '../../core/utils/service_result.dart';

class ApiServiceImpl implements ApiService {
  final Dio dio;

  ApiServiceImpl(this.dio);

  @override
  Future<ServiceResult<List<ProductModel>>> fetchProducts() async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        var response = await dio.request(
          'https://dummyjson.com/products',
          options: Options(
            method: 'GET',
          ),
        );

        if (response.statusCode == 200) {
          var listOfProducts =
              List<Map<String, dynamic>>.from(response.data['products']);
          List<ProductModel> products = listOfProducts.map((product) {
            return ProductModel.fromJson(product);
          }).toList();

          return products.isEmpty
              ? ServiceResult(StatusCode.success, "No data", products)
              : ServiceResult(StatusCode.success,
                  "Products fetched successfully", products);
        } else {
          return ServiceResult(
            StatusCode.failure,
            response.statusMessage ?? "Unknown error",
            [],
          );
        }
      } else {
        return ServiceResult(
          StatusCode.failure,
          'No Internet! Please check your connection.',
          [],
        );
      }
    } on DioException catch (dioError) {
      // Dio-specific error handling
      if (dioError.type == DioExceptionType.connectionTimeout) {
        return ServiceResult(
          StatusCode.error,
          "Connection timeout, please try again.",
          [],
        );
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        return ServiceResult(
          StatusCode.error,
          "Receive timeout, please try again.",
          [],
        );
      } else if (dioError.type == DioExceptionType.badResponse) {
        // Handle invalid status code
        return ServiceResult(
          StatusCode.error,
          "Bad Response!",
          [],
        );
      } else {
        return ServiceResult(
          StatusCode.error,
          dioError.message ?? "",
          [],
        );
      }
    } catch (e) {
      // Generic error handling
      return ServiceResult(StatusCode.error, e.toString(), []);
    }
  }
}
