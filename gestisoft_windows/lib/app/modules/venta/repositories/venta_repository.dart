import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';

import '../models/venta.dart';

class VentaRepository {
  final DioRestClient dioRestClient;

  VentaRepository(this.dioRestClient);

  Future<RestClientResponse> getProximoId() async {
    return await dioRestClient.get('/venta/getProximoId');
  }

  Future<RestClientResponse> saveVenta({required Venta venta}) async {
    return await dioRestClient.post("/venta/save", data: venta.toJson());
  }

  Future<RestClientResponse> findAll() async {
    return await dioRestClient.get("/venta/findAll");
  }

  Future<RestClientResponse> findVentasPorNombreCliente(
      String condition) async {
    return await dioRestClient
        .get("/venta/findByNombre", queryParameters: {"condition": condition});
  }

  Future<RestClientResponse> cancelaVentaById(int id) async {
    return await dioRestClient
        .put("/venta/cancelar", queryParameters: {"venta": id});
  }
}
