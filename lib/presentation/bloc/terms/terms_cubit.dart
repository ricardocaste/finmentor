import 'package:finmentor/domain/models/term.dart';
import 'package:finmentor/domain/repositories/terms_repository.dart';
import 'package:finmentor/presentation/bloc/terms/terms_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsCubit extends Cubit<TermsState> {

  final TermsRepository termsRepository;

  TermsCubit({required this.termsRepository}) : super(TermsState()) {
    _loadTermsLearned();
  }

  Future<List<Term>> getTerms() async {
    final terms = await termsRepository.getTerms();
    emit(TermsState());
    return terms;
  }

  Future<Term> getLastTerm() async {
    final terms = await getTerms();
    return terms.last;
  }

  Future<void> _loadTermsLearned() async {
    final prefs = await SharedPreferences.getInstance();
    final termsLearned = prefs.getInt('terms_learned') ?? 0;
    final claimedTermsList = prefs.getStringList('claimed_terms') ?? [];
    emit(TermsState(
      // termsLearned: termsLearned,
      // claimedTerms: Set<String>.from(claimedTermsList),
    ));
  }

  Future<void> incrementTermsLearned(String termTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final newCount = state.termsLearned! + 1;
    final newClaimedTerms = Set<String>.from(state.claimedTerms!)..add(termTitle);
    
    await prefs.setInt('terms_learned', newCount);
    await prefs.setStringList('claimed_terms', newClaimedTerms.toList());
    
    emit(TermsState(
      // termsLearned: newCount,
      // claimedTerms: newClaimedTerms,
    ));
  }

  bool isTermClaimed(String termTitle) {
    return state.claimedTerms!.contains(termTitle);
  }

  String getProgressText() {
    return '${(state.progress! * 100).toInt()}% complete';
  }
} 