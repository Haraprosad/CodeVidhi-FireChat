// lib/features/posts/domain/repositories/posts_repository.dart
import 'package:codevidhi_firechat/core/network/models/api_result.dart';
import 'package:codevidhi_firechat/features/chats/domain/entities/chats_entity.dart';

abstract class ChatsRepository {
  Future<ApiResult<List<ChatsEntity>>> getChats({int start = 0, int limit = 10});
}
