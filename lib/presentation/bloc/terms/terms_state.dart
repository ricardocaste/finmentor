import 'package:finmentor/domain/models/term.dart';

class TermsState {
  int? termsLearned = 0;
  Set<String>? claimedTerms = {};
  double? progress = 0;
  List<Term>? terms = [];

  TermsState();
    // required this.termsLearned,
    // required this.claimedTerms,
  // }); // 3 es el total de términos

  // TermsState copyWith({
  //   int? termsLearned,
  //   Set<String>? claimedTerms,
  // }) {
  //   return TermsState(
  //     termsLearned: termsLearned ?? this.termsLearned,
  //     claimedTerms: claimedTerms ?? this.claimedTerms,
  //   );
  // }
}

class TermsInitial extends TermsState {}

class TermsLoading extends TermsState {}

class TermsLoaded extends TermsState {}

