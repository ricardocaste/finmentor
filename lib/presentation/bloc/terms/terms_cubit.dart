import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsState {
  final int termsLearned;
  final Set<String> claimedTerms;
  final double progress;

  TermsState({
    required this.termsLearned,
    required this.claimedTerms,
  }) : progress = claimedTerms.length / 3; // 3 es el total de términos

  TermsState copyWith({
    int? termsLearned,
    Set<String>? claimedTerms,
  }) {
    return TermsState(
      termsLearned: termsLearned ?? this.termsLearned,
      claimedTerms: claimedTerms ?? this.claimedTerms,
    );
  }
}

class TermsCubit extends Cubit<TermsState> {
  TermsCubit() : super(TermsState(termsLearned: 0, claimedTerms: {})) {
    _loadTermsLearned();
  }

  Future<void> _loadTermsLearned() async {
    final prefs = await SharedPreferences.getInstance();
    final termsLearned = prefs.getInt('terms_learned') ?? 0;
    final claimedTermsList = prefs.getStringList('claimed_terms') ?? [];
    emit(TermsState(
      termsLearned: termsLearned,
      claimedTerms: Set<String>.from(claimedTermsList),
    ));
  }

  Future<void> incrementTermsLearned(String termTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final newCount = state.termsLearned + 1;
    final newClaimedTerms = Set<String>.from(state.claimedTerms)..add(termTitle);
    
    await prefs.setInt('terms_learned', newCount);
    await prefs.setStringList('claimed_terms', newClaimedTerms.toList());
    
    emit(TermsState(
      termsLearned: newCount,
      claimedTerms: newClaimedTerms,
    ));
  }

  bool isTermClaimed(String termTitle) {
    return state.claimedTerms.contains(termTitle);
  }

  String getProgressText() {
    return '${(state.progress * 100).toInt()}% complete';
  }
} 