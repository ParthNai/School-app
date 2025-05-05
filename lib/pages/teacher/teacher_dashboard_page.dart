import 'package:flutter/material.dart';
import 'teacher_home_page.dart';
import 'teacher_students_page.dart';
import 'teacher_courses_page.dart';
import 'create_paper_page.dart' as paper;
import 'teacher_analytics_page.dart';
import 'teacher_settings_page.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const TeacherHomePage(),
    const TeacherStudentsPage(),
    const Placeholder(fallbackHeight: 400), // Teachers page placeholder
    const TeacherCoursesPage(),
    const TeacherAnalyticsPage(),
    const TeacherSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation Bar
          Container(
            width: MediaQuery.of(context).size.width > 800 ? 200 : 72,
            color: const Color(0xFF2196F3), // Exact blue color from the image
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              extended: MediaQuery.of(context).size.width > 800,
              minExtendedWidth: 200,
              backgroundColor: Colors.transparent,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              selectedLabelTextStyle: const TextStyle(color: Colors.white),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
              useIndicator: false,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: Text('Students'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: Text('Teachers'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Courses'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: Text('Analytics'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
