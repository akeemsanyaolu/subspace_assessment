import 'package:flutter/material.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/presentation/pages/blog_detail/blog_detail.dart';
import 'package:subspace/features/blog/presentation/pages/home/blogs.dart';
import 'package:subspace/features/blog/presentation/pages/saved_blog/saved_blog.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const BlogsPage());

      case '/BlogDetails':
        return _materialRoute(
            BlogDetailsPage(blog: settings.arguments as BlogEntity));

      case '/SavedBlogs':
        return _materialRoute(const SavedBlogs());

      default:
        return _materialRoute(const BlogsPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
