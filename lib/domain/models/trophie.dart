import 'package:equatable/equatable.dart';

class Trophie extends Equatable {
  final String name;
  final String email;
  final String ranking;
  final int studyStreak;
  final int challengesInProgress;
  final List<Achievement> achievements;

  const Trophie({
    required this.name,
    required this.email,
    required this.ranking,
    required this.studyStreak,
    required this.challengesInProgress,
    required this.achievements,
  });

  factory Trophie.fromJson(Map<String, dynamic> json) {
    return Trophie(
      name: json['name'],
      email: json['email'],
      ranking: json['ranking'],
      studyStreak: json['studyStreak'],
      challengesInProgress: json['challengesInProgress'],
      achievements: json['achievements'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'ranking': ranking,
      'studyStreak': studyStreak,
      'challengesInProgress': challengesInProgress, 
      'achievements': achievements.toList(),
    };
  }

  @override
  List<Object?> get props => [
    name,
    email,
    ranking,
    studyStreak,
    challengesInProgress,
    achievements,
  ];
}


class Achievement extends Equatable {
  final String name;
  final int level;

  const Achievement({
    required this.name,
    required this.level,
  });

  @override
  List<Object?> get props => [name, level];
}