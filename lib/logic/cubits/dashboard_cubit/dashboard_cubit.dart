import 'package:bloc_demo/data/models/dashboard_model.dart';
import 'package:bloc_demo/data/repositories/dashboard_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardLoadingState()){
    fetchPosts();
  }

  DashboardRepository postRepository = DashboardRepository();

  void fetchPosts() async {
    try {
      List<DashboardModel> posts = await postRepository.fetchPosts();
      emit(DashboardLoadedState(posts));
    }
    on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        emit(DashboardErrorState("Connection timeout. Please try again."));
      } else if (ex.type == DioExceptionType.badResponse) {
        emit(DashboardErrorState("Failed to load posts. Status code: ${ex.response?.statusCode}"));
      } else if (ex.type == DioExceptionType.cancel) {
        emit(DashboardErrorState("Request cancelled."));
      } else if (ex.type == DioExceptionType.connectionError) {
        emit(DashboardErrorState("Check Your Internet Connection"));
      }else{
        emit(DashboardErrorState("Error: ${ex.type.toString()}"));
      }
    }

    /*on DioException catch(ex) {
      if(ex.type == DioExceptionType.connectionError) {
        emit( DashboardErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        print(ex.type.toString());
        emit( DashboardErrorState(ex.type.toString()) );
      }
    }*/
  }
}
