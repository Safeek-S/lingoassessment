import 'package:lingoassessment/src/core/utils/service_result.dart';
import 'package:lingoassessment/src/models/product_model.dart';

abstract class ApiService{
  Future<ServiceResult<List<ProductModel>>> fetchProducts();
}