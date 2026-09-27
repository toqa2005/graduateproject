import '../../data/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final MovieModel movieModel;

  HomeSuccess(this.movieModel);
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}