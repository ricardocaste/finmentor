import 'package:finmentor/domain/models/trophie.dart';

abstract class TrophiesRepository {
  Future<List<Trophie>> getTrophies();
  Future<void> claimAchievement(String achievementId);
}