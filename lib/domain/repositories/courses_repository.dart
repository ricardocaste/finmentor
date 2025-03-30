import 'package:finmentor/domain/models/course.dart';

abstract class CoursesRepository {
  Future<List<Course>> getCourses();
}