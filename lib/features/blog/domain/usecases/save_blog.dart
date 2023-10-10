import 'package:subspace/core/resources/data_state.dart';
import 'package:subspace/core/usecase/usecase.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/domain/repository/blog_repository.dart';

class SaveBlogUsecase implements UseCase<void, BlogEntity> {
  final BlogRepository _blogRepository;
  SaveBlogUsecase(this._blogRepository);

  @override
  Future<void> call({BlogEntity? params}) {
    return _blogRepository.saveBlog(params!);
  }
}
