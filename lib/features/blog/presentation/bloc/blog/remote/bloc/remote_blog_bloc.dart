import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:subspace/core/resources/data_state.dart';
import '../../../../../domain/entitties/blog.dart';
import '../../../../../domain/usecases/get_blogs.dart';

part 'remote_blog_event.dart';
part 'remote_blog_state.dart';

class RemoteBlogsBloc extends Bloc<RemoteBlogsEvent, RemoteBlogsState> {
  final GetBlogsUsecase _getBlogsUsecase;
  RemoteBlogsBloc(this._getBlogsUsecase) : super(const RemoteBlogsLoading()) {
    on<GetBlogs>(onGetBlogs);
  }

  void onGetBlogs(GetBlogs event, Emitter<RemoteBlogsState> emit) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('Yayyyy');
    }
    final dataState = await _getBlogsUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteBlogsDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteBlogsError(dataState.error!));
    }
  }
}
