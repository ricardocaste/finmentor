import 'package:flutter/foundation.dart';
import 'package:finmentor/domain/models/course.dart';

class CoursesDataSource {

  CoursesDataSource();

  Future<List<Course>> loadCourses() async {
    try {
      return [];
      } catch (e) {
      if (kDebugMode) {
        print('Error loading courses from JSON: $e');
      }
      return [];
    }
  }

  
}
