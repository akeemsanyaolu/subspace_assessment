import 'package:floor/floor.dart';
import 'package:subspace/features/blog/data/models/blog.dart';

@dao
abstract class BlogDao {
  @Insert()
  Future<void> insertBlog(BlogModel blog);

  @delete
  Future<void> deleteBlog(BlogModel blogModel);

  @Query('SELECT * FROM blog')
  Future<List<BlogModel>> getBlogs();
}
