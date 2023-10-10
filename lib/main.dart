import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/features/blog/presentation/bloc/blog/remote/bloc/remote_blog_bloc.dart';
import 'package:subspace/features/blog/presentation/pages/home/blogs.dart';
import 'package:subspace/injection_container.dart';

import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteBlogsBloc>(
      create: (context) => getIt()..add(const GetBlogs()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const BlogsPage(),
      ),
    );
  }
}
