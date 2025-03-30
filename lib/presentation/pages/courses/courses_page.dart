import 'package:finmentor/domain/models/course.dart';
import 'package:finmentor/presentation/bloc/courses/courses_cubit.dart';
import 'package:flutter/material.dart';


class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  // final Function() showDialog;
  
  //final CoursesCubit coursesCubit;
  @override
  State<CoursesPage> createState() => CoursesPageState();
}


class CoursesPageState extends State<CoursesPage> {

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
    return _courses([]);
  }

  Widget _courses(List<Course> courses) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Courses',
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
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Course Cards
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCourseCard(
                  category: 'Financial Education',
                  title: 'The Power of Compound Interest',
                  description: 'Analyze the impact on your portfolio.',
                  buttonText: 'See NFT',
                  imagePath: 'assets/images/course1.png',
                ),
                const SizedBox(height: 16),
                _buildCourseCard(
                  category: 'Investment Tip',
                  title: 'Diversify your holdings for balanced risk',
                  description: 'Consider bonds and REITs.',
                  buttonText: 'Claim Learning NFT',
                  imagePath: 'assets/images/course2.png',
                  isSpecialButton: true,
                ),
                const SizedBox(height: 16),
                _buildCourseCard(
                  category: 'Crypto Insight',
                  title: 'Potential altcoins for Q4 2024',
                  description: 'Explore innovative DeFi and gaming tokens.',
                  buttonText: 'See NFT',
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
    return Container(
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSpecialButton ? const Color(0xFFB93BF9) : Colors.grey[200],
                    foregroundColor: isSpecialButton ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(buttonText),
                ),
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
    );
  }
}