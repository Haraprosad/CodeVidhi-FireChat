import 'package:dio/dio.dart';
import 'package:codevidhi_firechat/core/network/config/dio_client.dart';
import 'package:codevidhi_firechat/core/network/enums/custom_error_type.dart';
import 'package:codevidhi_firechat/core/network/error_handling/models/custom_exception.dart';
import 'package:codevidhi_firechat/features/chats/data/models/chats_model.dart';
import 'package:injectable/injectable.dart';

abstract class ChatsRemoteDataSource {
  Future<List<ChatsModel>> getChats({int start = 0, int limit = 0});
}

@Injectable(as: ChatsRemoteDataSource)
class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final DioClient _dioClient;
  ChatsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ChatsModel>> getChats({int start = 0, int limit = 0}) async {
    try {
      final response = await _dioClient.client.get('/chats', queryParameters: {
        '_start': start,
        '_limit': limit,
      });

      return (response.data as List)
          .map((json) => ChatsModel.fromJson(json))
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw CustomException(
        type: CustomErrorType.parsingError,
        originalError: e,
      );
    }
  }
}
