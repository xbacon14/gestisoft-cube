import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';

import '../../../helpers/enviroments.dart';

class QueInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.headers.containsKey('AUTHORIZATION')) {
      String baseUrl = Enviroments.param('base_url')!;
      DioRestClient().post('${baseUrl}auth/authenticate', data: {
        'username': options.data['username'],
        'password': options.data['password'],
      }).then((value) {
        String token = value.data['token'];
        options.headers['Authorization'] = 'Bearer $token';
        debugPrint('requested token succesfully');
        handler.next(options);
      }).catchError((error, stackTrace) {
        debugPrint(error);
        handler.reject(error, true);
      });
    }
    super.onRequest(options, handler);
  }
}
