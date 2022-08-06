import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';

class ConnectivityInterceptor {
  final Dio dio;
  final Connectivity connectivity;

  final HomeController homeController = HomeController();

  ConnectivityInterceptor({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      onError: (error) {
        streamSubscription?.cancel();
        responseCompleter.completeError(error);
        homeController.online = false;
      },
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription?.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: requestOptions.data as Options,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
