import 'package:subspace/core/resources/data_state.dart';
import 'package:subspace/core/usecase/usecase.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/domain/repository/blog_repository.dart';

class RemoveBlogUsecase implements UseCase<void, BlogEntity> {
  final BlogRepository _blogRepository;
  RemoveBlogUsecase(this._blogRepository);

  @override
  Future<void> call({BlogEntity? params}) {
    return _blogRepository.removeBlog(params!);
  }
}
