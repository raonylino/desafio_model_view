part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {
  final String? message;
  HomeInitial({this.message});
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {}

final class HomeSuccess extends HomeState {}
