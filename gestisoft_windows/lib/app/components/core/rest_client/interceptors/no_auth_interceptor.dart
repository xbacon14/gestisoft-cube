import 'package:dio/dio.dart';

class NoAuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Access-Control-Allow-Origin'] = "*";
    options.headers['Access-Control-Allow-Credentials'] = true;
    options.headers['Access-Control-Allow-Headers'] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    options.headers['Access-Control-Allow-Methods'] = "GET, PUT, POST, OPTIONS";

    handler.next(options);
  }
}
