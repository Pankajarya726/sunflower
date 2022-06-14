import 'package:equatable/equatable.dart';
import 'package:practice/home/model/content_response.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitState extends HomeState {}

class GetGroupState extends HomeState {
  final List<Content> groups;

  GetGroupState({required this.groups});

  @override
  List<Object?> get props => [groups];
}

class GetTeamState extends HomeState {
  final List<Content> teams;

  GetTeamState({required this.teams});

  @override
  List<Object?> get props => [teams];
}
