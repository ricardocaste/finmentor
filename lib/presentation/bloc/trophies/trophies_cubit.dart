import 'package:finmentor/domain/models/trophie.dart';
import 'package:finmentor/domain/repositories/trophie_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:finmentor/domain/repositories/user_repository.dart';

part 'trophies_state.dart';

class TrophiesCubit extends  HydratedCubit<TrophiesState> {
  TrophiesCubit(this.trophiesRepository, this.userRepository) : super(TrophiesState());

  final TrophiesRepository trophiesRepository;
  final UserRepository userRepository;

  Future<void> loadCourses() async {
    emit(TrophiesLoading());
    try {
      final trophies = await trophiesRepository.getTrophies();
      emit(TrophiesLoaded(trophies));
    } catch (e) {
      emit(TrophiesError());
    }
  }



 

  int getTrophiesLearned() {
    if (state is TrophiesLoaded) {
      final loadedState = state as TrophiesLoaded;
      return loadedState.trophies.length;
    }
    return 0;
  }

  @override
  TrophiesState? fromJson(Map<String, dynamic> json) {
    final stateType = json['type'];

    if (stateType == 'TrophiesLoaded') {
      final trophieJson = json['trophie'] as List;
      final trophie = trophieJson.map((trophieJson) => Trophie.fromJson(trophieJson)).toList();
      return TrophiesLoaded(trophie);
    }  else if(stateType == "TrophiesError"){
      return TrophiesError();
    }
    return TrophiesInitial();
  }

  @override
  Map<String, dynamic>? toJson(TrophiesState state) {
    if (state is TrophiesLoaded) {
      return {
        'type': 'TrophiesLoaded',
        'trophies': state.trophies.map((trophie) => trophie.toJson()).toList(),
      };
    } else if (state is TrophiesError) {
      return {
        'type': 'TrophiesError',
      };
    }
    return null; // O maneja otros estados
  }
}