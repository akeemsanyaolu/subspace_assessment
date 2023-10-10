import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/injection_container.dart';

import '../../bloc/blog/local/local_blog_bloc.dart';

class BlogDetailsPage extends HookWidget {
  final BlogEntity? blog;

  const BlogDetailsPage({Key? key, this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocalBlogBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
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
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            blog!.title!,
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(blog!.imageUrl!, fit: BoxFit.cover),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        description,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalBlogBloc>(context).add(SaveBlog(blog!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }

  final String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ut urna ultricies, fringilla purus eget, pretium purus. Maecenas fermentum massa dolor, quis finibus risus volutpat vitae. Quisque non ante sit amet metus mollis scelerisque. Curabitur hendrerit ante ac neque volutpat posuere. In laoreet erat id urna vulputate, ut molestie justo aliquet. Pellentesque eu pulvinar nisl, non pellentesque lorem. Etiam tincidunt sem at aliquam suscipit. Pellentesque sodales eros ac eros sollicitudin lacinia. Cras facilisis porta scelerisque. Nam id rhoncus risus. Nam vitae leo non nisi imperdiet cursus. Sed iaculis sollicitudin dolor, vel luctus nulla posuere euismod.';
}
