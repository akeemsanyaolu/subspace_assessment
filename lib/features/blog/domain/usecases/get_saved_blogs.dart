import 'package:subspace/core/resources/data_state.dart';
import 'package:subspace/core/usecase/usecase.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/domain/repository/blog_repository.dart';

class GetSavedBlogsUsecase implements UseCase<List<BlogEntity>, void> {
  final BlogRepository _blogRepository;
  GetSavedBlogsUsecase(this._blogRepository);

  @override
  Future<List<BlogEntity>> call({void params}) {
    return _blogRepository.getSavedBlogs();
  }
}
