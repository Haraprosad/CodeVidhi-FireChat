import 'package:codevidhi_firechat/core/network/models/api_result.dart';
import 'package:codevidhi_firechat/core/network/repository/base_api_repository.dart';
import 'package:codevidhi_firechat/dlt_common_actions/infinite_scrolling/data/datasources/posts_remote_datasource.dart';
import 'package:codevidhi_firechat/dlt_common_actions/infinite_scrolling/domain/entities/post.dart';
import 'package:codevidhi_firechat/dlt_common_actions/infinite_scrolling/domain/repository/posts_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostsRepository)
class PostsRepositoryImpl extends BaseApiRepository implements PostsRepository {
  final PostsRemoteDataSource _remoteDataSource;
  PostsRepositoryImpl(
    super.errorHandler,
    this._remoteDataSource,
  );

  @override
  Future<ApiResult<List<Post>>> getPosts(
      {int start = 0, int limit = 10}) async {
    return safeApiCall(() async {
      final postModels = await _remoteDataSource.getPosts(
        start: start,
        limit: limit,
      );
      return postModels.map((model) => model.toEntity()).toList();
    });
  }
}
