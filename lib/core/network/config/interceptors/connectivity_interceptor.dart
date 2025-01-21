// connectivity_interceptor.dart

import 'package:dio/dio.dart';
import 'package:codevidhi_firechat/core/network/services/connection_manager.dart';
import 'package:codevidhi_firechat/core/network/enums/custom_error_type.dart';

/// Interceptor that checks for network connectivity before making requests.
class ConnectivityInterceptor extends Interceptor {
  final ConnectionManager connectionManager;

  ConnectivityInterceptor(this.connectionManager);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Check internet connectivity
    final isConnected = await connectionManager.checkInternetConnection();
    if (!isConnected) {
      // Reject request if no internet connection
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: CustomErrorType.noInternet,
        ),
      );
    }
    handler.next(options);
  }
}
