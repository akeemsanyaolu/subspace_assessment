import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:subspace/core/constants/constants.dart';
import 'package:subspace/features/blog/data/models/blog.dart';

part 'blogs_api_service.g.dart';

@RestApi(baseUrl: blogsAPIBaseURL)
abstract class BlogsApiService {
  factory BlogsApiService(Dio dio) = _BlogsApiService;

  @GET('/')
  @Headers({'x-hasura-admin-secret': adminSecret})
  Future<HttpResponse<List<BlogModel>>> getBlogs();
}
