import 'package:finmentor/infrastructure/services/branch_service.dart';
import 'package:finmentor/infrastructure/services/ganalytics_service.dart';
import 'package:finmentor/presentation/bloc/home/home_cubit.dart';
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

    // Analytics
  getIt.registerSingletonAsync<AnalyticsService>(() async {
    final service = AnalyticsService();
    await service.init();
    return service;
  });
  getIt.registerLazySingleton<BranchService>(() => BranchService());

  // Blocs / Cubits
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerFactory<TrophiesCubit>(() => TrophiesCubit(getIt(), getIt()));
  getIt.registerFactory<AuthenticationCubit>(() => AuthenticationCubit(getIt(), getIt()));
  getIt.registerFactory<UserCubit>(() => UserCubit(getIt()));
  getIt.registerFactory<CoursesCubit>(() => CoursesCubit(
      coursesRepository: getIt<CoursesRepository>(),
    ),
  );
  getIt.registerLazySingleton(() => TermsCubit());

  // Data sources
  getIt.registerLazySingleton<CoursesDataSource>(() => CoursesDataSource());
  getIt.registerLazySingleton<CoursesRepository>(() => CoursesRepositoryImpl(
    coursesDataSource: getIt<CoursesDataSource>()
  ));
  getIt.registerLazySingleton<TrophiesDataSource>(() => TrophiesDataSource());

  // Providers
  getIt.registerLazySingleton<FirestoreProvider>(() => FirestoreProvider());
  
  // Repositories
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<TrophiesRepository>(() => TrophiesRepositoryImpl(getIt<TrophiesDataSource>()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt()));
  
}