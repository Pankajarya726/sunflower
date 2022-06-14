import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/home/bloc/home_event.dart';
import 'package:practice/home/bloc/home_state.dart';
import 'package:practice/home/bloc/repository.dart';
import 'package:practice/home/model/content_response.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository repository = Repository();

  HomeBloc() : super(HomeInitState()) {
    on<GetTeamEvent>(getTeam);
    on<GetGroupEvent>(getGroup);
  }

  getTeam(GetTeamEvent event, Emitter<HomeState> emit) async {
    List<Content> teams = await repository.getTeams();

    emit(GetTeamState(teams: teams));
  }

  getGroup(GetGroupEvent event, Emitter<HomeState> emit) async {
    List<Content> groups = await repository.getGroups();

    emit(GetGroupState(groups: groups));
  }
}
