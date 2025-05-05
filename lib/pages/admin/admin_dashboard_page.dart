import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'manage_students_page.dart';
import 'manage_teachers_page.dart';
import 'manage_courses_page.dart';
import 'admin_settings_page.dart';
import 'admin_analytics_page.dart';
import 'admin_home_page.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const AdminHomePage(),
    const ManageStudentsPage(),
    const ManageTeachersPage(),
    const ManageCoursesPage(),
    const AdminAnalyticsPage(),
    const AdminSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation Bar
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            extended: MediaQuery.of(context).size.width > 800,
            minExtendedWidth: 200,
            backgroundColor: AppTheme.primaryColor,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.7)),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Students'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.school),
                label: Text('Teachers'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                label: Text('Courses'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.analytics),
                label: Text('Analytics'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
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
