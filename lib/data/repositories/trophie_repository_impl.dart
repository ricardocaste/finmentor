import 'package:firebase_auth/firebase_auth.dart';
import 'package:finmentor/data/datasources/trophie_datasource.dart';
import 'package:finmentor/domain/models/trophie.dart';
import 'package:finmentor/domain/repositories/trophie_repository.dart';

class TrophiesRepositoryImpl implements TrophiesRepository {
  final TrophiesDataSource _remoteDataSource;

  TrophiesRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Trophie> > getTrophies() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    return _remoteDataSource.getTrophies(user.uid);
  }


  @override
  Future<void> claimAchievement(String achievementId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    await _remoteDataSource.claimAchievement(user.uid, achievementId);
  }
}