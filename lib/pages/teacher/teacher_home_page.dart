import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=8'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=8'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back, Dr. Johnson',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Monday, May 5, 2025',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to create paper page
                    Navigator.pushNamed(context, '/create-paper');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create Paper'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Students',
                    '183',
                    Icons.people,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Total Courses',
                    '5',
                    Icons.book,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Papers Created',
                    '12',
                    Icons.assignment,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Average Score',
                    '78%',
                    Icons.score,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Quick Actions and Today's Schedule
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Actions
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.5,
                                children: [
                                  _buildActionCard(
                                    context,
                                    'Create Paper',
                                    Icons.assignment_add,
                                    Colors.blue,
                                    () {
                                      // Navigate to create paper page
                                    },
                                  ),
                                  _buildActionCard(
                                    context,
                                    'Take Attendance',
                                    Icons.fact_check,
                                    Colors.green,
                                    () {
                                      // Navigate to attendance page
                                    },
                                  ),
                                  _buildActionCard(
                                    context,
                                    'Grade Assignments',
                                    Icons.grading,
                                    Colors.orange,
                                    () {
                                      // Navigate to grading page
                                    },
                                  ),
                                  _buildActionCard(
                                    context,
                                    'Send Message',
                                    Icons.message,
                                    Colors.purple,
                                    () {
                                      // Navigate to messaging page
                                    },
                                  ),
                                  _buildActionCard(
                                    context,
                                    'View Analytics',
                                    Icons.analytics,
                                    Colors.teal,
                                    () {
                                      // Navigate to analytics page
                                    },
                                  ),
                                  _buildActionCard(
                                    context,
                                    'Upload Material',
                                    Icons.upload_file,
                                    Colors.indigo,
                                    () {
                                      // Navigate to upload page
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 24),
                  
                  // Today's Schedule
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Today\'s Schedule',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    // View full schedule
                                  },
                                  icon: const Icon(Icons.calendar_today, size: 16),
                                  label: const Text('View All'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppTheme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView(
                                children: [
                                  _buildClassItem(
                                    'Advanced Mathematics',
                                    '9:00 AM - 10:30 AM',
                                    'Room 101',
                                    '42 students',
                                    Colors.blue.withOpacity(0.1),
                                  ),
                                  _buildClassItem(
                                    'Mathematics Fundamentals',
                                    '11:00 AM - 12:30 PM',
                                    'Room 203',
                                    '38 students',
                                    Colors.green.withOpacity(0.1),
                                  ),
                                  _buildClassItem(
                                    'Calculus I',
                                    '2:00 PM - 3:30 PM',
                                    'Room 105',
                                    '35 students',
                                    Colors.orange.withOpacity(0.1),
                                  ),
                                  _buildClassItem(
                                    'Staff Meeting',
                                    '4:00 PM - 5:00 PM',
                                    'Conference Room',
                                    'All teachers',
                                    Colors.purple.withOpacity(0.1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Recent Activity
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Activity',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // View all activity
                            },
                            icon: const Icon(Icons.history, size: 16),
                            label: const Text('View All'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildActivityItem(
                              'You created a new paper for Advanced Mathematics',
                              '2 hours ago',
                              Icons.assignment,
                              Colors.blue,
                            ),
                            _buildActivityItem(
                              'You marked attendance for Mathematics Fundamentals',
                              '3 hours ago',
                              Icons.fact_check,
                              Colors.green,
                            ),
                            _buildActivityItem(
                              'You graded 15 assignments for Calculus I',
                              'Yesterday',
                              Icons.grading,
                              Colors.orange,
                            ),
                            _buildActivityItem(
                              'You uploaded new study materials for Statistics',
                              'Yesterday',
                              Icons.upload_file,
                              Colors.purple,
                            ),
                            _buildActivityItem(
                              'You sent a message to all students in Physics for Mathematics',
                              '2 days ago',
                              Icons.message,
                              Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassItem(String className, String time, String room, String students, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(1.0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  className,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                room,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                students,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
