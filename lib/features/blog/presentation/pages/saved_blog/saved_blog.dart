import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/presentation/bloc/blog/local/local_blog_bloc.dart';
import 'package:subspace/features/blog/presentation/widgets/blog_tile.dart';
import 'package:subspace/injection_container.dart';

class SavedBlogs extends HookWidget {
  const SavedBlogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocalBlogBloc>()..add(const GetSavedBlogs()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title: const Text('Saved Blogs', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalBlogBloc, LocalBlogsState>(
      builder: (context, state) {
        if (state is LocalBlogsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalBlogsDone) {
          return _buildArticlesList(state.blogs!);
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(List<BlogEntity> blogs) {
    if (blogs.isEmpty) {
      return const Center(
          child: Text(
        'NO SAVED BLOGS!',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        return BlogWidget(
          blog: blogs[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(context, article),
          onBlogPressed: (article) => _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveArticle(BuildContext context, BlogEntity article) {
    BlocProvider.of<LocalBlogBloc>(context).add(RemoveBlog(article));
  }

  void _onArticlePressed(BuildContext context, BlogEntity article) {
    Navigator.pushNamed(context, '/BlogDetails', arguments: article);
  }
}
