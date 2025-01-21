import 'package:codevidhi_firechat/core/network/models/api_result.dart';
import 'package:codevidhi_firechat/features/chats/domain/entities/chats_entity.dart';
import 'package:codevidhi_firechat/features/chats/domain/repositories/chats_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChatsUseCase {
  final ChatsRepository _repository;

  GetChatsUseCase(this._repository);

  Future<ApiResult<List<ChatsEntity>>> call({int start = 0, int limit = 10}) {
    return _repository.getChats(start: start, limit: limit);
  }
}
