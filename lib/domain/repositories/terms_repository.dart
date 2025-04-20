import 'package:finmentor/domain/models/term.dart';

abstract class TermsRepository {
  Future<List<Term>> getTerms();
}