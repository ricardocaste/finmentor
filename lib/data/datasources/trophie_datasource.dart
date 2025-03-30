import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmentor/domain/models/trophie.dart';

class TrophiesDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Trophie>> getTrophies(String userId) async {
    List<Trophie> trophies = [];
    try {
      final profileDoc = await _firestore.collection('profiles').doc(userId).get();

      if (!profileDoc.exists) {
        throw Exception('Perfil no encontrado');
      }

      trophies.add(Trophie(
        name: profileDoc.get('name') ?? '',
        email: profileDoc.get('email') ?? '',
        ranking: profileDoc.get('ranking') ?? '0%',
        studyStreak: profileDoc.get('studyStreak') ?? 0,
        challengesInProgress: profileDoc.get('challengesInProgress') ?? 0,

        achievements: (profileDoc.get('achievements') as List?)
            ?.map((achievementJson) => Achievement(
          name: achievementJson['name'],
          level: achievementJson['level'],
        ))
            .toList().cast<Achievement>() ?? [],
      ));
    } catch (e) {
      throw Exception('Error al obtener el perfil: $e');
    }
    return trophies;
  }

  Future<void> claimAchievement(String userId, String achievementId) async {
    try {
      final profileDocRef = _firestore.collection('profiles').doc(userId);
      await profileDocRef.update({
        'achievements': FieldValue.arrayUnion([
          {'name': achievementId, 'claimed': true}
        ])
      });
    } catch (e) {
      throw Exception('Error claiming achievement: $e');
    }
  }
}