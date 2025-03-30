import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:finmentor/di/di.dart';
import 'package:finmentor/domain/models/course.dart';
import 'package:finmentor/domain/repositories/courses_repository.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {

  StreamSubscription? _coursesSubscription;
  final CoursesRepository coursesRepository;

  CoursesCubit({required this.coursesRepository}) : super(CoursesInitial()) {
    _coursesSubscription = getIt<CoursesCubit>().stream.listen((coursesState) {
      if (coursesState is CoursesLoaded) {
        loadCourses();
      }
    });
  }

  @override
  Future<void> close() {
    _coursesSubscription?.cancel();
    return super.close();
  }

  Future<void> loadCourses() async {
    emit(CoursesLoading());
    try {

    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }
}