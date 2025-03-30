import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:finmentor/di/di.dart';
import 'package:finmentor/data/providers/firestore_provider.dart';
import 'package:finmentor/domain/repositories/authentication_repository.dart';
import 'package:finmentor/domain/models/user.dart' as mem;
import 'package:finmentor/presentation/bloc/user/user_cubit.dart';


part 'authentication_state.dart';
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.authenticationRepository, this.firestoreProvider) : super(AuthenticationInitial());

  final AuthenticationRepository authenticationRepository;
  final FirestoreProvider firestoreProvider;


  Future<void> ghostLogin() async {
    var authUser = authenticationRepository.getCurrentUser();

    if(authUser == null) return;

    final userCubit = getIt<UserCubit>();
    final mem.User? updatedUser = await userCubit.getUser(authUser.uid);

    if (updatedUser != null) {
      Get.put(updatedUser, tag: 'user');
      emit(AuthenticationSuccess(updatedUser));
    }
  }


  Future<void> logInWithEmailAndPassword(String email, String password) async {
    final userExists = await firestoreProvider.existUserWithEmail(email);
    if(userExists) {
      logIn(email, password);
    } else {
      signUp(email, password);
    }
  }

  Future<void> logIn(String email, String password) async =>
      await _authenticate(() => authenticationRepository.signInWithEmailAndPassword(email:email, password: password));


  Future<void> signUp(String email, String password) async =>
      await _authenticate(() => authenticationRepository.createUserWithEmailAndPassword(email:email, password: password));


  Future<void> _authenticate(Future<UserCredential?> Function() authMethod) async {
    try {
      emit(AuthenticationLoading());
      final userCredential = await authMethod();

      if (userCredential != null) {
        final firebaseUser = userCredential.user!;
        bool userExists = false; 
        if (firebaseUser.email == null) {
          userExists = false;
        } else {
          userExists = await firestoreProvider.existUserWithEmail(firebaseUser.email!);
        }

        if (!userExists) {
          final user = mem.User(
            uid: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName ?? '',
            hasPurchased: false,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          );
          

          await firestoreProvider.createUser(user);
        }
        final userCubit = getIt<UserCubit>();
        final mem.User? updatedUser = await userCubit.getUser(firebaseUser.uid);

        if (updatedUser != null) {
          Get.put(updatedUser, tag: 'user');
          emit(AuthenticationSuccess(updatedUser));
        } else {
          emit(AuthenticationFailure('authentication-failed'));
        }

      } else {
        emit(AuthenticationFailure('authentication-failed')); // Error de autenticación genérico
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(e.code));  // Emite el código de error de Firebase
    } catch (e) {
      emit(AuthenticationFailure('$e')); // Error genérico
    }
  }

  Future<void> logOut() async {
    try {
      await authenticationRepository.signOut();
      // Borrar palabras aprendidas
      Get.delete<User>(tag: 'user'); // Elimina el usuario de Get
      emit(AuthenticationSignedOut());
    } catch (e) {
      emit(AuthenticationFailure('sign-out-error'));
    }
  }
}