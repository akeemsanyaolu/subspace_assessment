import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:subspace/features/blog/domain/entitties/blog.dart';
import 'package:subspace/features/blog/domain/usecases/get_saved_blogs.dart';
import 'package:subspace/features/blog/domain/usecases/remove_blog.dart';
import 'package:subspace/features/blog/domain/usecases/save_blog.dart';

part 'local_blog_event.dart';
part 'local_blog_state.dart';

class LocalBlogBloc extends Bloc<LocalBlogsEvent, LocalBlogsState> {
  final GetSavedBlogsUsecase _getSavedBlogsUsecase;
  final SaveBlogUsecase _saveBlogUsecase;
  final RemoveBlogUsecase _removeBlogUsecase;

  LocalBlogBloc(this._getSavedBlogsUsecase, this._saveBlogUsecase,
      this._removeBlogUsecase)
      : super(const LocalBlogsLoading()) {
    on<GetSavedBlogs>(onGetSavedBlogs);
    on<RemoveBlog>(onRemoveBlog);
    on<SaveBlog>(onSaveBlog);
  }

  void onGetSavedBlogs(
      GetSavedBlogs event, Emitter<LocalBlogsState> emit) async {
    final blogs = await _getSavedBlogsUsecase();
    emit(LocalBlogsDone(blogs));
  }

  void onRemoveBlog(RemoveBlog event, Emitter<LocalBlogsState> emit) async {
    await _removeBlogUsecase(params: event.blog);
    final blogs = await _getSavedBlogsUsecase();
    emit(LocalBlogsDone(blogs));
  }

  void onSaveBlog(SaveBlog event, Emitter<LocalBlogsState> emit) async {
    await _saveBlogUsecase();
    final blogs = await _getSavedBlogsUsecase(params: event.blog);
    emit(LocalBlogsDone(blogs));
  }
}
