import 'package:finmentor/data/datasources/terms_data_source.dart';
import 'package:finmentor/domain/models/term.dart';
import 'package:finmentor/domain/repositories/terms_repository.dart';

class TermsRepositoryImpl implements TermsRepository {
  final TermsDataSource termsDataSource;

  TermsRepositoryImpl({required this.termsDataSource});

  @override
  Future<List<Term>> getTerms() async {
    return await termsDataSource.loadTerms();
  }
}
