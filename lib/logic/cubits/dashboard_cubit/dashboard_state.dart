part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardLoadedState extends DashboardState {
  final List<DashboardModel> posts;
  DashboardLoadedState(this.posts);
}

class DashboardErrorState extends DashboardState {
  final String error;
  DashboardErrorState(this.error);
}
