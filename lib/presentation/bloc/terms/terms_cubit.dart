import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsCubit extends Cubit<int> {
  TermsCubit() : super(0) {
    _loadTermsLearned();
  }

  Future<void> _loadTermsLearned() async {
    final prefs = await SharedPreferences.getInstance();
    final termsLearned = prefs.getInt('terms_learned') ?? 0;
    emit(termsLearned);
  }

  Future<void> incrementTermsLearned() async {
    final prefs = await SharedPreferences.getInstance();
    final newCount = state + 1;
    await prefs.setInt('terms_learned', newCount);
    emit(newCount);
  }
} 