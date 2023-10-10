import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:subspace/features/blog/data/data_sources/local/app_database.dart';
import 'package:subspace/features/blog/data/data_sources/remote/blogs_api_service.dart';
import 'package:subspace/features/blog/data/repository/blog_repository_implementation.dart';
import 'package:subspace/features/blog/domain/repository/blog_repository.dart';
import 'package:subspace/features/blog/domain/usecases/get_blogs.dart';
import 'package:subspace/features/blog/domain/usecases/get_saved_blogs.dart';
import 'package:subspace/features/blog/domain/usecases/remove_blog.dart';
import 'package:subspace/features/blog/domain/usecases/save_blog.dart';
import 'package:subspace/features/blog/presentation/bloc/blog/local/local_blog_bloc.dart';
import 'package:subspace/features/blog/presentation/bloc/blog/remote/bloc/remote_blog_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependecies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);

  //Dio
  getIt.registerSingleton<Dio>(Dio());

  //Dependencies
  getIt.registerSingleton<BlogsApiService>(BlogsApiService(getIt()));

  getIt.registerSingleton<BlogRepository>(BlogRepositoryImpl(getIt(), getIt()));

  //Usecases
  getIt.registerSingleton<GetBlogsUsecase>(GetBlogsUsecase(getIt()));

  getIt.registerSingleton<GetSavedBlogsUsecase>(GetSavedBlogsUsecase(getIt()));

  getIt.registerSingleton<SaveBlogUsecase>(SaveBlogUsecase(getIt()));

  getIt.registerSingleton<RemoveBlogUsecase>(RemoveBlogUsecase(getIt()));

  //Blocs
  getIt.registerFactory<RemoteBlogsBloc>(() => RemoteBlogsBloc(getIt()));

  getIt.registerFactory<LocalBlogBloc>(
      () => LocalBlogBloc(getIt(), getIt(), getIt()));
}
