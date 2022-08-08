import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';

class ConfiguracionRepository {
  final DioRestClient dioRestClient;
  ConfiguracionRepository(this.dioRestClient);

  Future<bool> verificarConexion() async {
    var conexao = false;
    await dioRestClient
        .get('/configuracion/verificar_conexion')
        .then((response) {
      if (response.statusCode == 200) {
        conexao = true;
      } else {
        conexao = false;
      }
    });

    return conexao;
  }
}
