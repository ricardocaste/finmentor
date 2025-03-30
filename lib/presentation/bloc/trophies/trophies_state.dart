part of 'trophies_cubit.dart';

class TrophiesState {}
class TrophiesInitial extends TrophiesState {}
class TrophiesLoading extends TrophiesState {}
class TrophiesLoaded extends TrophiesState {
  final List<Trophie> trophies;
  TrophiesLoaded(this.trophies);
}
class TrophiesError extends TrophiesState {}

class TrophiesLearned extends TrophiesState {
  final List<Trophie> trophies;
  TrophiesLearned(this.trophies);
}

class NeedToPurchase extends TrophiesState {}