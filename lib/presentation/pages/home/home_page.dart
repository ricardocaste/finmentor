import 'dart:async';

import 'package:azbox/azbox.dart';
import 'package:finmentor/domain/models/term.dart';
import 'package:finmentor/presentation/bloc/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finmentor/di/di.dart';
import 'package:finmentor/domain/models/user.dart';
import 'package:finmentor/infrastructure/utils.dart';
import 'package:finmentor/presentation/bloc/user/user_cubit.dart';
import 'package:finmentor/presentation/bloc/terms/terms_cubit.dart';
import 'package:finmentor/presentation/widgets/app_bar_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.homeCubit});

  final HomeCubit homeCubit;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserCubit userCubit = getIt<UserCubit>();
  late final TermsCubit termsCubit = getIt<TermsCubit>();
  User? user;

  @override
  void initState() {
    super.initState();

    user = Utils.getUser();
    _incrementStudyDays();
  }

  Future<void> _incrementStudyDays() async {
    final prefs = await SharedPreferences.getInstance();
    final currentStudyDays = prefs.getInt('study_days') ??
        0; // Obtiene los días actuales o 0 si no existe
    await prefs.setInt(
        'study_days', currentStudyDays + 1); // Incrementa y guarda
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo abrir el enlace'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al abrir el enlace: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: termsCubit),
      ],
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,          
          removeLeading: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('notifications');
              },
              icon: SvgPicture.asset(
                'assets/images/noti.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainView(),
              //const ProgressView()
            ],
          ),
        ),
      ),
    );
  }

  Widget mainView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/minilogo.png', width: 50, height: 50),
          const SizedBox(height: 6),
          Text(
            'Dashboard'.translate(capitalize: true),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 24),
          // _buildLearningProgress(),
          const SizedBox(height: 24),
          _buildSummary(),
          const SizedBox(height: 24),
          _buildTodayRecommendation(),
          const SizedBox(height: 24),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary'.translate(capitalize: true),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard('Terms\nLearned', ''),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard('Thropies\nEarned', '6'),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    if (title.contains('Terms')) {
      return BlocBuilder<TermsCubit, TermsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFB93BF9),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0D141C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.termsLearned.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFB93BF9),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0D141C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayRecommendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last Term from Omi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('detail', arguments: Term.terms[0]),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
             boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: .1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Colors.blue[100],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/bg_new.png',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Omi Token',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'The key to unlocking financial freedom in the Omi ecosystem. Earn, trade, and grow your wealth with seamless transactions and exclusive rewards. Your money, your rules.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text(
                    //   '3 modules',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'know more about the project'.translate(capitalize: true),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        
        // Our Team Section
        Text(
          'our team'.translate(capitalize: true),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildTeamMember('Rafael Martín Gallego', 'https://www.linkedin.com/in/rafaelmartingallego/', 'assets/images/rafael.png'),
        _buildTeamMember('Ricardo Castellanos', 'https://www.linkedin.com/in/ricardo-castellanos-herreros/', 'assets/images/ricardo.png'),
        _buildTeamMember('Cristhian Rodriguez', 'https://www.linkedin.com/in/cristhianrodr%C3%ADguez/', 'assets/images/cris.png'),
        _buildTeamMember('Ali Hussein', 'https://www.linkedin.com/in/ali-hussein-721a5a359/', 'assets/images/ali.png'),
        
        const SizedBox(height: 32),
        
        // We work with Section
        Text(
          'we work with'.translate(capitalize: true),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildTool('Figma', '(Design)', 'https://www.figma.com/', 'assets/images/figma.png'),
        _buildTool('Flutter', '(App)', 'https://flutter.dev/', 'assets/images/flutter.png'),
        _buildTool('AZbox', '(Translations)', 'https://azbox.io/', 'assets/images/azbox.png'),
        _buildTool('Brotea', '(Plan Project)', 'https://brotea.xyz/', 'assets/images/brotea.png'),
        
        const SizedBox(height: 32),
        
        // Testimonials Section
        Text(
          'what they say about us'.translate(capitalize: true),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildTestimonial(
          name: 'Carlos Rodriguez',
          title: 'An Essential Financial Assistant!',
          content: 'FinMentor has been a game-changer. The "OMI - Explain that" feature helps me understand finance easily during podcasts & chats. Highly recommend!',
          rating: 5,
        ),
        const SizedBox(height: 16),
        _buildTestimonial(
          name: 'David Lynch',
          title: 'Say Goodbye to Jargon!',
          content: 'As an entrepreneur, I love FinMentor. "OMI - Explain that" is my go-to for financial terms I don\'t know. The AI is amazing and saves me research time. A must-have app!',
          rating: 5,
        ),
        
        const SizedBox(height: 32),
        // Sponsored Section
        Center(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Image.asset(
                'assets/images/brotea_logo.png',
                height: 60,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(
              path: 'assets/images/x.png',
              url: 'https://x.com/finmentorai',
              label: 'X (Twitter)',
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              path: 'assets/images/instagram.svg',
              url: 'https://www.instagram.com/finmentorai/',
              label: 'Instagram',
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              path: 'assets/images/tiktok.svg',
              url: 'https://www.tiktok.com/@finmentorai',
              label: 'TikTok',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamMember(String name, String linkedin, String imagePath) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 20,
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _launchUrl(linkedin, context),
    );
  }

  Widget _buildTool(String name, String description, String url, String imagePath) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      title: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _launchUrl(url, context),
    );
  }

  Widget _buildTestimonial({
    required String name,
    required String title,
    required String content,
    required int rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              rating,
              (index) => const Icon(
                Icons.star,
                color: Colors.purple,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required String path,
    required String url,
    required String label,
  }) {
    return InkWell(
      onTap: () => _launchUrl(url, context),
      child: Tooltip(
        message: label,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: path.contains('svg') ? SvgPicture.asset(
            path,
            colorFilter: ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ) : Image.asset(
            path,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
