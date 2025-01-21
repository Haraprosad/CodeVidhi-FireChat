import 'package:codevidhi_firechat/core/network/models/api_result.dart';
import 'package:codevidhi_firechat/core/network/repository/base_api_repository.dart';
import 'package:codevidhi_firechat/features/chats/data/datasources/chats_remote_datasource.dart';
import 'package:codevidhi_firechat/features/chats/domain/entities/chats_entity.dart';
import 'package:codevidhi_firechat/features/chats/domain/repositories/chats_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatsRepository)
class ChatsRepositoryImpl extends BaseApiRepository implements ChatsRepository {
  final ChatsRemoteDataSource _remoteDataSource;
  ChatsRepositoryImpl(
    super.errorHandler,
    this._remoteDataSource,
  );

  @override
  Future<ApiResult<List<ChatsEntity>>> getChats(
      {int start = 0, int limit = 10}) async {
    return safeApiCall(() async {
      final chatModels = await _remoteDataSource.getChats(
        start: start,
        limit: limit,
      );
      return chatModels.map((model) => model.toEntity()).toList();
    });
  }
}
