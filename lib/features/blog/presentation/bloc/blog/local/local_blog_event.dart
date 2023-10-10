part of 'local_blog_bloc.dart';

abstract class LocalBlogsEvent extends Equatable {
  final BlogEntity? blog;

  const LocalBlogsEvent({this.blog});

  @override
  List<Object> get props => [blog!];
}

class GetSavedBlogs extends LocalBlogsEvent {
  const GetSavedBlogs();
}

class RemoveBlog extends LocalBlogsEvent {
  const RemoveBlog(BlogEntity blog) : super(blog: blog);
}

class SaveBlog extends LocalBlogsEvent {
  const SaveBlog(BlogEntity blog) : super(blog: blog);
}
