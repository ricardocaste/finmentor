import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:finmentor/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  late final FirebaseAuth _firebaseAuth;

  AuthenticationRepositoryImpl() {
    try {
      final app = Firebase.app("finmentor");
      _firebaseAuth = FirebaseAuth.instanceFor(app: app);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Firebase Auth instance: $e');
      }
      // Fallback a la instancia por defecto si hay error
      _firebaseAuth = FirebaseAuth.instance;
    }
  }

  @override
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  @override
  Future<UserCredential?> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  @override
  Future<UserCredential?> signInWithEmailAndPassword({required String email, required String password})  async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {

      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('Error signing in with email and password: $e');
    }
  }



  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}