import 'package:dio/dio.dart';

import 'connectivity_interceptor.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectivityInterceptor requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        DioError error = DioError(error: e, requestOptions: err.requestOptions);
        handler.next(error);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioError err) {
    // if (kIsWeb) {
    if (err.type == DioErrorType.other && err.error != null) {
      return true;
    } else {
      return false;
    }
    // } else {
    //   return err.type == DioErrorType.other &&
    //       err.error != null &&
    //       err.error is SocketException;
    // }
  }
}
