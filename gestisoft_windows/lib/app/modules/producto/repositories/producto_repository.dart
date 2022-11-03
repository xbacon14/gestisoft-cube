import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';

class ProductoRepository {
  final DioRestClient dioRestClient;

  ProductoRepository(DioRestClient restClient) : dioRestClient = restClient;

  Future<RestClientResponse> findAllProductos() async {
    final response = await dioRestClient.get("/producto/findAll");
    return response;
  }

  Future<RestClientResponse> save(Producto producto) async {
    return await dioRestClient.post('/producto/save', data: producto.toJson());
  }

  Future<RestClientResponse> eliminarProductoById(int idProducto) async {
    return await dioRestClient.delete('/producto/delete/$idProducto');
  }

  Future<RestClientResponse> findByNombreOCodigo(String condition) async {
    return await dioRestClient
        .get("/producto/findByNombreOCodigo", queryParameters: {
      "condition": condition,
    });
  }

  Future<String> geraRelatorio({
    String? filtroDesde,
    String? filtroHasta,
    String? orderBy,
    required bool verInactivos,
    required bool isPdf,
  }) async {
    final response =
        await dioRestClient.get("/producto/generaReporte", queryParameters: {
      "filtroDesde": filtroDesde,
      "filtroHasta": filtroHasta,
      "orderByCondition": orderBy,
      "verInactivos": verInactivos,
      "verPdf": isPdf,
    });
    return response.data['body'];
  }
}
