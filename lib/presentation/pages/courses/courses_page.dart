import 'dart:convert';

import 'package:finmentor/domain/models/course.dart';
import 'package:finmentor/domain/models/term.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finmentor/presentation/bloc/terms/terms_cubit.dart';
import 'package:finmentor/di/di.dart';
import 'package:http/http.dart' as http;

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  // final Function() showDialog;
  
  //final CoursesCubit coursesCubit;
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late final TermsCubit termsCubit = getIt<TermsCubit>();
  //final terms = fetchTerms();
  List<Term> terms = [];
  bool isLoading = true;
  String? error;

  //late AudioPlayer _audioPlayer;
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    _fetchTerms();
  }

  Future<void> _fetchTerms() async {
    try {
      final response = await http.get(
        Uri.parse('https://677a-111-235-226-130.ngrok-free.app/api/v1/finmentor/terms/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<ApiTerm> apiTerms = data.map((json) => ApiTerm.fromJson(json)).toList();
        setState(() {
          terms = apiTerms.map((apiTerm) => apiTerm.toTerm()).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Error al cargar los términos';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error de conexión: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    return BlocProvider.value(
      value: termsCubit,
      child: Scaffold(
        body: _courses(),
      ),
    );
  }

  Widget _courses() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/minilogo.png', width: 50, height: 50),
            const SizedBox(height: 6),
            const Text(
              'Financial Terms',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Progress Section
            BlocBuilder<TermsCubit, TermsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${(state.progress * 100).toInt()}% complete',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 8,
                        child: LinearProgressIndicator(
                          value: state.progress,
                          backgroundColor: const Color(0xFFEEEEEE),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB93BF9)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 32),
            // const Text(
            //   'Notifications',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 16),
            
            // Course Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: terms.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final term = terms[index];
                return _buildCourseCard(
                  category: term.category,
                  title: term.title,
                  description: term.description,
                  buttonText: index == 0 ? 'See NFT' : 'Claim Learning NFT',
                  imagePath: term.imagePath,
                  isSpecialButton: index == 1,
                  term: term,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard({
    required String category,
    required String title,
    required String description,
    required String buttonText,
    required String imagePath,
    required Term term,
    bool isSpecialButton = false,
  }) {
    return BlocBuilder<TermsCubit, TermsState>(
      builder: (context, state) {
        final isClaimed = state.claimedTerms.contains(title);
        final actualButtonText = isClaimed ? 'See NFT' : buttonText;
        
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('detail', arguments: term),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildButton(actualButtonText, term),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.error_outline),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(String buttonText, Term term) {
    return ElevatedButton(
      onPressed: buttonText == 'Claim Learning NFT' 
          ? () => _onClaimNFT(term.title)
          : () => Navigator.of(context).pushNamed('trophies'),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonText == 'Claim Learning NFT' ? const Color(0xFFB93BF9) : Colors.grey[200],
        foregroundColor: buttonText == 'Claim Learning NFT' ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(buttonText),
    );
  }

  void _onClaimNFT(String termTitle) async {
    await termsCubit.incrementTermsLearned(termTitle);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Nuevo término aprendido!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}