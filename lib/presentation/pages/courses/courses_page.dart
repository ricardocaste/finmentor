import 'package:finmentor/domain/models/course.dart';
import 'package:finmentor/presentation/bloc/courses/courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finmentor/presentation/bloc/terms/terms_cubit.dart';
import 'package:finmentor/di/di.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  // final Function() showDialog;
  
  //final CoursesCubit coursesCubit;
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late final TermsCubit termsCubit = getIt<TermsCubit>();

  //late AudioPlayer _audioPlayer;
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    //widget.coursesCubit.loadCourses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: termsCubit,
      child: Scaffold(
        body: _courses([]),
      ),
    );
  }

  Widget _courses(List<Course> courses) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Financial Terms',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Progress Section
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
                  '15% complete',
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
              child: const SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  value: 0.15,
                  backgroundColor: Color(0xFFEEEEEE),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB93BF9)),
                ),
              ),
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
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCourseCard(
                  category: 'Financial Education',
                  title: 'Omi Token',
                  description: 'The key to unlocking financial freedom in the Omi ecosystem. Earn, trade, and grow your wealth with seamless transactions and exclusive rewards. Your money, your rules.',
                  buttonText: 'See NFT',
                  imagePath: 'assets/images/course1.png',
                ),
                const SizedBox(height: 16),
                _buildCourseCard(
                  category: 'Investment Tip',
                  title: 'Smart Budgeting ',
                  description: 'Take control of your finances with AI-driven budgeting! Track expenses, optimize spending, and reach your savings goals effortlessly. Let your money work for you.',
                  buttonText: 'Claim Learning NFT',
                  imagePath: 'assets/images/course2.png',
                  isSpecialButton: true,
                ),
                const SizedBox(height: 16),
                _buildCourseCard(
                  category: 'Crypto Insight',
                  title: 'AI-Powered Investing',
                  description: 'Invest smarter, not harder! Our AI analyzes market trends to help you diversify and maximize returns. Say goodbye to guesswork and hello to financial growth.',
                  buttonText: 'Claim Learning NFT',
                  imagePath: 'assets/images/course3.png',
                ),
              ],
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
    bool isSpecialButton = false,
  }) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('detail'),
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
                _buildButton(buttonText),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: buttonText == 'Claim Learning NFT' ? _onClaimNFT : null,
      child: Text(buttonText),
    );
  }

  void _onClaimNFT() async {
    await termsCubit.incrementTermsLearned();
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