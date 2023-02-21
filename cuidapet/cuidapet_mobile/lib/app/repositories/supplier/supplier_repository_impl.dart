// ignore_for_file: unnecessary_lambdas

import './supplier_repository.dart';
import '../../core/exceptions/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/supplier_category_model.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final RestClient _restClient;
  final AppLogger _log;

  SupplierRepositoryImpl({
    required RestClient restClient,
    required AppLogger logger,
  })  : _restClient = restClient,
        _log = logger;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final response = await _restClient.auth().get('/categories/');

      return response.data
          ?.map<SupplierCategoryModel>(
            (categorieResponse) =>
                SupplierCategoryModel.fromMap(categorieResponse),
          )
          .toList();
          
    } on RestClientException catch (e, s) {
      const message = 'Error getting categories';
      _log.error(message, e);

      Error.throwWithStackTrace(const Failure(message: message), s);
    }
  }
}
