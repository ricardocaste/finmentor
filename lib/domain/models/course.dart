import 'dart:convert';


class Course {
  final String title;
  final String description;
  late bool learned;

  Course({
    required this.title,
    required this.description,
    this.learned = false
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      learned: json['learned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'description': description,
        'learned': learned,
      };

  factory Course.fromString(String jsonString) =>
      Course.fromJson(json.decode(jsonString));

  String toStringJson() => json.encode(toJson());

  Course copyWith({
    String? title,
    String? description,
    bool? learned,

  }) {
    return Course(
      title: title ?? this.title,
      description: description ?? this.description,
      learned: learned ?? this.learned,
    );
  }
}