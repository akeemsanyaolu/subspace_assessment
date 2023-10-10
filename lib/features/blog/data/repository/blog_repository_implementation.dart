import 'package:dio/dio.dart';
import 'package:subspace/features/blog/data/data_sources/local/app_database.dart';
import 'package:subspace/features/blog/data/data_sources/remote/blogs_api_service.dart';
import 'package:subspace/features/blog/data/models/blog.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/domain/repository/blog_repository.dart';

import '../../../../core/resources/data_state.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogsApiService _blogsApiService;
  final AppDatabase _appDatabase;
  BlogRepositoryImpl(this._blogsApiService, this._appDatabase);

  @override
  Future<DataState<List<BlogModel>>> getBlogs() async {
    try {
      final httpResponse = await _blogsApiService.getBlogs();
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.unknown,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<BlogModel>> getSavedBlogs() {
    return _appDatabase.blogDao.getBlogs();
  }

  @override
  Future<void> removeBlog(BlogEntity blog) {
    return _appDatabase.blogDao.deleteBlog(BlogModel.fromEntity(blog));
  }

  @override
  Future<void> saveBlog(BlogEntity blog) {
    return _appDatabase.blogDao.insertBlog(BlogModel.fromEntity(blog));
  }
}
