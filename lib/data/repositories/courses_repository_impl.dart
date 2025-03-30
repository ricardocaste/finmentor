import 'package:finmentor/data/datasources/courses_data_source.dart';
import 'package:finmentor/domain/models/course.dart';
import 'package:finmentor/domain/repositories/courses_repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesDataSource coursesDataSource;

  CoursesRepositoryImpl({required this.coursesDataSource});

  @override
  Future<List<Course>> getCourses() async {
    return await coursesDataSource.loadCourses();
  }
}
