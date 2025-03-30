import 'package:get_it/get_it.dart';
import 'package:finmentor/data/datasources/trophie_datasource.dart';
import 'package:finmentor/data/datasources/courses_data_source.dart';
import 'package:finmentor/data/repositories/authentication_repository_impl.dart';
import 'package:finmentor/data/repositories/trophie_repository_impl.dart';
import 'package:finmentor/data/repositories/user_repository_impl.dart';
import 'package:finmentor/data/repositories/courses_repository_impl.dart';
import 'package:finmentor/data/providers/firestore_provider.dart';
import 'package:finmentor/domain/repositories/authentication_repository.dart';
import 'package:finmentor/domain/repositories/trophie_repository.dart';
import 'package:finmentor/domain/repositories/user_repository.dart';
import 'package:finmentor/domain/repositories/courses_repository.dart';
import 'package:finmentor/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:finmentor/presentation/bloc/courses/courses_cubit.dart';
import 'package:finmentor/presentation/bloc/user/user_cubit.dart';
import 'package:finmentor/presentation/bloc/trophies/trophies_cubit.dart';
import 'package:finmentor/presentation/bloc/terms/terms_cubit.dart';

final getIt = GetIt.instance;
Future<void> init() async {

  getIt.registerLazySingleton<CoursesDataSource>(() => CoursesDataSource());
  getIt.registerLazySingleton<CoursesRepository>(() => CoursesRepositoryImpl(
    coursesDataSource: getIt<CoursesDataSource>()
  ));
  getIt.registerLazySingleton<FirestoreProvider>(() => FirestoreProvider());
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<TrophiesDataSource>(() => TrophiesDataSource());
  getIt.registerLazySingleton<TrophiesRepository>(() => TrophiesRepositoryImpl(getIt<TrophiesDataSource>()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt()));
  getIt.registerFactory<TrophiesCubit>(() => TrophiesCubit(getIt(), getIt()));
  getIt.registerFactory<AuthenticationCubit>(() => AuthenticationCubit(getIt(), getIt()));
  getIt.registerFactory<UserCubit>(() => UserCubit(getIt()));
  getIt.registerFactory<CoursesCubit>(() => CoursesCubit(
      coursesRepository: getIt<CoursesRepository>(),
    ),
  );
  getIt.registerLazySingleton(() => TermsCubit());
}