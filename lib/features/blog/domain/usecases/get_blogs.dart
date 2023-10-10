import 'package:subspace/core/resources/data_state.dart';
import 'package:subspace/core/usecase/usecase.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/domain/repository/blog_repository.dart';

class GetBlogsUsecase implements UseCase<DataState<List<BlogEntity>>, void> {
  final BlogRepository _blogRepository;
  GetBlogsUsecase(this._blogRepository);

  @override
  Future<DataState<List<BlogEntity>>> call({void params}) {
    return _blogRepository.getBlogs();
  }
}
