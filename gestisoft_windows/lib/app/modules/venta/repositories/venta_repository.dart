import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';

class VentaRepository {
  final DioRestClient dioRestClient;

  VentaRepository(this.dioRestClient);

  Future<RestClientResponse> getProximoId() async {
    return await dioRestClient.get('/venta/getProximoId');
  }
}
