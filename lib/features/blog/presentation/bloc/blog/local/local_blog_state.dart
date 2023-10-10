part of 'local_blog_bloc.dart';

abstract class LocalBlogsState extends Equatable {
  final List<BlogEntity>? blogs;

  const LocalBlogsState({this.blogs});

  @override
  List<Object> get props => [blogs!];
}

class LocalBlogsLoading extends LocalBlogsState {
  const LocalBlogsLoading();
}

class LocalBlogsDone extends LocalBlogsState {
  const LocalBlogsDone(List<BlogEntity> blogs) : super(blogs: blogs);
}
