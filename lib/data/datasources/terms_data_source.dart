import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmentor/domain/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:finmentor/domain/models/term.dart';

class TermsDataSource {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  TermsDataSource();

  Future<List<Term>> loadTerms() async {
    User? user = User(uid: 'aV1fj5ACc7IT7DBA1wpF', email: 'ricardo@gmail.com', name: 'Ricardo', hasPurchased: false, createdAt: Timestamp.now(), updatedAt: Timestamp.now()); // Utils.getUser();
    List<Term> terms = [];
    try {

      // Primero verificamos si el documento del usuario existe
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      print('¿Existe el documento del usuario?: ${userDoc.exists}');


      final termsRef = _firestore.collection('users').doc(user.uid).collection('terms');
      print('Referencia de la colección: ${termsRef.path}'); // Log 2

      final termsDoc = await termsRef.get();
      
      print('Documentos encontrados: ${termsDoc.docs.length}'); // Log 3

      if (termsDoc.docs.isNotEmpty) {
        for (var doc in termsDoc.docs) {
          terms.add(Term.fromJson(doc.data()));
        }
      }
      return terms;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading terms from JSON: $e');
      }
      return [];
    }
  }
}