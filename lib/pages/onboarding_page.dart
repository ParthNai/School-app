import 'package:flutter/material.dart';
import 'login_page.dart';
import '../theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildOnboardingPage(
                    image: 'assets/images/todo_illustration/todo.png',
                    title: 'Create a paper like pro',
                    subtitle: 'Easy to use and create anywhere\nwithout any hustle.',
                    iconFallback: Icons.description,
                  ),
                  _buildOnboardingPage(
                    image: 'assets/images/todo_illustration/curriculum.png',
                    title: 'Create a curriculum',
                    subtitle: 'Select the subjects and capture for the\nexam paper.',
                    iconFallback: Icons.menu_book,
                  ),
                  _buildOnboardingPage(
                    image: 'assets/images/todo_illustration/questions.png',
                    title: 'Select the questions.',
                    subtitle: 'Choose questions step by step mark\nand type wise.',
                    iconFallback: Icons.help_outline,
                  ),
                  _buildOnboardingPage(
                    image: 'assets/images/todo_illustration/export.png',
                    title: 'Export & Save Paper.',
                    subtitle: 'Export using the name and watermark for your\norganization, with an additional feature.',
                    iconFallback: Icons.upload_file,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppTheme.primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String subtitle,
    IconData iconFallback = Icons.school,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImageWithFallback(image, iconFallback, title),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildImageWithFallback(String imagePath, IconData fallbackIcon, String title) {
    return Container(
      height: 300,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                fallbackIcon,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
