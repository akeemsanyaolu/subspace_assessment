part of 'remote_blog_bloc.dart';

abstract class RemoteBlogsEvent {
  const RemoteBlogsEvent();
}

class GetBlogs extends RemoteBlogsEvent {
  const GetBlogs();
}
