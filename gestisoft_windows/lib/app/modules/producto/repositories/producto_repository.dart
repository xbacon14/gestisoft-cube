import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';

class ProductoRepository {
  final DioRestClient dioRestClient;

  ProductoRepository(DioRestClient restClient) : dioRestClient = restClient;

  Future<RestClientResponse> findAllProductos() async {
    final response = await dioRestClient.get("/producto/findAll");
    return response;
  }
}
