part of 'remote_blog_bloc.dart';

abstract class RemoteBlogsState extends Equatable {
  final List<BlogEntity>? blogs;
  final DioException? error;

  const RemoteBlogsState({this.blogs, this.error});

  @override
  List<Object> get props => [blogs!, error!];
}

class RemoteBlogsLoading extends RemoteBlogsState {
  const RemoteBlogsLoading();
}

class RemoteBlogsDone extends RemoteBlogsState {
  const RemoteBlogsDone(List<BlogEntity> blog) : super(blogs: blog);
}

class RemoteBlogsError extends RemoteBlogsState {
  const RemoteBlogsError(DioException error) : super(error: error);
}

class BlogInitial extends RemoteBlogsState {}
