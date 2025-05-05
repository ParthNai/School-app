import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
              radius: 16,
            ),
            onPressed: () {
              // Show profile options
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Admin',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s what\'s happening today',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            
            // Stats Cards
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              children: [
                _buildStatCard(
                  context,
                  'Total Students',
                  '1,254',
                  Icons.people,
                  Colors.blue,
                  '+12% from last month',
                ),
                _buildStatCard(
                  context,
                  'Total Teachers',
                  '86',
                  Icons.school,
                  Colors.green,
                  '+3 new this month',
                ),
                _buildStatCard(
                  context,
                  'Active Courses',
                  '42',
                  Icons.book,
                  Colors.orange,
                  '98% completion rate',
                ),
                _buildStatCard(
                  context,
                  'Pending Approvals',
                  '18',
                  Icons.pending_actions,
                  Colors.red,
                  'Action required',
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Recent Activity
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: ListView(
                children: [
                  _buildActivityItem(
                    'New Student Registration',
                    'John Doe registered as a new student',
                    '10 minutes ago',
                    Icons.person_add,
                    Colors.green,
                  ),
                  _buildActivityItem(
                    'Course Updated',
                    'Mathematics for Grade 10 syllabus was updated',
                    '1 hour ago',
                    Icons.update,
                    Colors.blue,
                  ),
                  _buildActivityItem(
                    'Teacher Absence',
                    'Ms. Johnson reported absence for tomorrow',
                    '3 hours ago',
                    Icons.event_busy,
                    Colors.orange,
                  ),
                  _buildActivityItem(
                    'System Update',
                    'System maintenance completed successfully',
                    '5 hours ago',
                    Icons.system_update,
                    Colors.purple,
                  ),
                  _buildActivityItem(
                    'Fee Payment',
                    '15 new fee payments processed',
                    'Yesterday',
                    Icons.payment,
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, 
      IconData icon, Color color, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Icon(
                  icon,
                  color: color,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String description, String time, 
      IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
