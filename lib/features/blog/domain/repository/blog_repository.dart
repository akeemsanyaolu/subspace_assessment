import 'package:subspace/core/resources/data_state.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';

abstract class BlogRepository {
  Future<DataState<List<BlogEntity>>> getBlogs();

  Future<List<BlogEntity>> getSavedBlogs();

  Future<void> saveBlog(BlogEntity blog);

  Future<void> removeBlog(BlogEntity blog);
}
