import './supplier_repository.dart';
import '../../core/exceptions/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/supplier_category_model.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  
  final RestClient _restClient;
  final AppLogger _logger;

  SupplierRepositoryImpl({
    required RestClient restClient,
    required AppLogger logger,
  })  : _restClient = restClient,
        _logger = logger;

  
 @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final response =
          await _restClient.auth().get<Map<String, dynamic>>('/categories/');

      final data = response.data!['categories'] as List<dynamic>;

      return data
          .cast<Map<String, dynamic>>()
          .map(SupplierCategoryModel.fromJson)
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Error getting categories';
      _logger.error(message, e);

      Error.throwWithStackTrace(const Failure(message: message), s);
    }
  }

}
