import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/presentation/bloc/blog/remote/bloc/remote_blog_bloc.dart';
import 'package:subspace/features/blog/presentation/widgets/blog_tile.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteBlogsBloc, RemoteBlogsState>(builder: (_, state) {
      if (state is RemoteBlogsLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is RemoteBlogsError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteBlogsDone) {
        return ListView.builder(
          itemBuilder: ((context, index) {
            return BlogWidget(
              blog: state.blogs![index],
              onBlogPressed: (blog) => _onBlogPressed(context, blog),
            );
          }),
          itemCount: 10,
        );
      }
      return const SizedBox();
    });
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Blogs and Articles',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.favorite, color: Colors.black),
          ),
        ),
      ],
    );
  }

  void _onBlogPressed(BuildContext context, BlogEntity blog) {
    Navigator.pushNamed(context, '/BlogDetails', arguments: blog);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedBlogs');
  }
}
