import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_exception.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';

import '../../helpers/enviroments.dart';
import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/no_auth_interceptor.dart';
import 'interceptors/retry_on_connection_change_interceptor.dart';

class DioRestClient {
  late Dio _dio;

  final String name;
  // ignore: constant_identifier_names
  static const String NO_AUTH_TAG = "NO_AUTH_TAG";

  final BaseOptions _defaultBaseOptions = BaseOptions(
    baseUrl: Enviroments.param('base_url') ?? '',
    connectTimeout: int.parse(Enviroments.param('dio_connect_timeout') ?? '0'),
    receiveTimeout:
        int.parse(Enviroments.param('dio_receive_timeout') ?? '60000'),
  );

  DioRestClient({
    BaseOptions? options,
  }) : name = NO_AUTH_TAG {
    _dio = Dio(options ?? _defaultBaseOptions);
    _dio.interceptors.addAll([
      LogInterceptor(),
      NoAuthInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: ConnectivityInterceptor(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
  }

  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
          e.response?.statusMessage,
          e.response?.statusCode,
          e.error,
          _dioErrorResponseConverter(e.response));
    }
  }

  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
          e.response?.statusMessage,
          e.response?.statusCode,
          e.error,
          _dioErrorResponseConverter(e.response));
    }
  }

  Future<RestClientResponse<T>> patch<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
          e.response?.statusMessage,
          e.response?.statusCode,
          e.error,
          _dioErrorResponseConverter(e.response));
    }
  }

  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
          e.response?.statusMessage,
          e.response?.statusCode,
          e.error,
          _dioErrorResponseConverter(e.response));
    }
  }

  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
          e.response?.statusMessage,
          e.response?.statusCode,
          e.error,
          _dioErrorResponseConverter(e.response));
    }
  }

  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
          e.response?.statusMessage,
          e.response?.statusCode,
          e.error,
          _dioErrorResponseConverter(e.response));
    }
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response response) {
    return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }

  RestClientResponse? _dioErrorResponseConverter(Response? response) {
    return RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage);
  }
}
