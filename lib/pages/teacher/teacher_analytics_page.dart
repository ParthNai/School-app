import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TeacherAnalyticsPage extends StatefulWidget {
  const TeacherAnalyticsPage({super.key});

  @override
  State<TeacherAnalyticsPage> createState() => _TeacherAnalyticsPageState();
}

class _TeacherAnalyticsPageState extends State<TeacherAnalyticsPage> {
  String _selectedTimeRange = 'This Month';
  String _selectedCourse = 'All Courses';
  
  // Sample analytics data
  final Map<String, dynamic> _analyticsData = {
    'studentPerformance': {
      'averageScore': 78,
      'highestScore': 96,
      'lowestScore': 52,
      'passingRate': 0.85,
    },
    'attendance': {
      'averageRate': 0.92,
      'totalClasses': 45,
      'missedClasses': 8,
    },
    'assignments': {
      'total': 24,
      'completed': 21,
      'pending': 3,
      'averageCompletionTime': '3.2 days',
    },
    'courseProgress': {
      'Advanced Mathematics': 0.75,
      'Mathematics Fundamentals': 0.68,
      'Calculus I': 0.82,
      'Physics for Mathematics': 0.45,
      'Statistics': 0.55,
    },
    'gradeDistribution': {
      'A': 28,
      'B': 42,
      'C': 18,
      'D': 8,
      'F': 4,
    },
    'topPerformers': [
      {
        'name': 'Emma Johnson',
        'grade': '10',
        'performance': 0.92,
        'avatar': 'https://i.pravatar.cc/150?img=5',
      },
      {
        'name': 'Isabella Anderson',
        'grade': '12',
        'performance': 0.94,
        'avatar': 'https://i.pravatar.cc/150?img=23',
      },
      {
        'name': 'Olivia Martinez',
        'grade': '11',
        'performance': 0.88,
        'avatar': 'https://i.pravatar.cc/150?img=20',
      },
    ],
    'needsImprovement': [
      {
        'name': 'Michael Brown',
        'grade': '10',
        'performance': 0.78,
        'avatar': 'https://i.pravatar.cc/150?img=8',
      },
      {
        'name': 'James Taylor',
        'grade': '12',
        'performance': 0.79,
        'avatar': 'https://i.pravatar.cc/150?img=12',
      },
      {
        'name': 'William Wilson',
        'grade': '11',
        'performance': 0.81,
        'avatar': 'https://i.pravatar.cc/150?img=11',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () {
              // Export analytics data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting analytics data...')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Row
            Row(
              children: [
                // Time Range Dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedTimeRange,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'This Week', child: Text('This Week')),
                          DropdownMenuItem(value: 'This Month', child: Text('This Month')),
                          DropdownMenuItem(value: 'This Quarter', child: Text('This Quarter')),
                          DropdownMenuItem(value: 'This Year', child: Text('This Year')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedTimeRange = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Course Dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCourse,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'All Courses', child: Text('All Courses')),
                          DropdownMenuItem(value: 'Advanced Mathematics', child: Text('Advanced Mathematics')),
                          DropdownMenuItem(value: 'Mathematics Fundamentals', child: Text('Mathematics Fundamentals')),
                          DropdownMenuItem(value: 'Calculus I', child: Text('Calculus I')),
                          DropdownMenuItem(value: 'Physics for Mathematics', child: Text('Physics for Mathematics')),
                          DropdownMenuItem(value: 'Statistics', child: Text('Statistics')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCourse = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Refresh Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Refresh analytics
                    setState(() {
                      // In a real app, fetch new data here
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Analytics refreshed')),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
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
            
            const SizedBox(height: 24),
            
            // Analytics Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Average Score',
                            '${_analyticsData['studentPerformance']['averageScore']}%',
                            Icons.score,
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Attendance Rate',
                            '${(_analyticsData['attendance']['averageRate'] * 100).toInt()}%',
                            Icons.people,
                            Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Passing Rate',
                            '${(_analyticsData['studentPerformance']['passingRate'] * 100).toInt()}%',
                            Icons.check_circle,
                            Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Assignments Completed',
                            '${_analyticsData['assignments']['completed']}/${_analyticsData['assignments']['total']}',
                            Icons.assignment_turned_in,
                            Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Course Progress
                    Card(
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
                              'Course Progress',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...(_analyticsData['courseProgress'] as Map<String, dynamic>).entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(entry.key),
                                        Text('${(entry.value * 100).toInt()}%'),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: entry.value,
                                      backgroundColor: Colors.grey[200],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getCourseProgressColor(entry.value),
                                      ),
                                      minHeight: 10,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Grade Distribution and Student Performance
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Grade Distribution
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
                                    'Grade Distribution',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ...(_analyticsData['gradeDistribution'] as Map<String, dynamic>).entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: _getGradeColor(entry.key),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                entry.key,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: LinearProgressIndicator(
                                              value: entry.value / 100,
                                              backgroundColor: Colors.grey[200],
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                _getGradeColor(entry.key),
                                              ),
                                              minHeight: 10,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${entry.value}',
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 24),
                        
                        // Student Performance
                        Expanded(
                          flex: 2,
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
                                    'Student Performance',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Top Performers
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Top Performers',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            ...(_analyticsData['topPerformers'] as List).map((student) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 12.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 16,
                                                      backgroundImage: NetworkImage(student['avatar']),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            student['name'],
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Grade ${student['grade']}',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey[600],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: Colors.green.withOpacity(0.1),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        '${(student['performance'] * 100).toInt()}%',
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                      
                                      const SizedBox(width: 24),
                                      
                                      // Needs Improvement
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Needs Improvement',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            ...(_analyticsData['needsImprovement'] as List).map((student) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 12.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 16,
                                                      backgroundImage: NetworkImage(student['avatar']),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            student['name'],
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Grade ${student['grade']}',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey[600],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange.withOpacity(0.1),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        '${(student['performance'] * 100).toInt()}%',
                                                        style: const TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Detailed Stats
                    Card(
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
                              'Detailed Statistics',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailStat(
                                    'Highest Score',
                                    '${_analyticsData['studentPerformance']['highestScore']}%',
                                    Icons.arrow_upward,
                                    Colors.green,
                                  ),
                                ),
                                Expanded(
                                  child: _buildDetailStat(
                                    'Lowest Score',
                                    '${_analyticsData['studentPerformance']['lowestScore']}%',
                                    Icons.arrow_downward,
                                    Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: _buildDetailStat(
                                    'Total Classes',
                                    '${_analyticsData['attendance']['totalClasses']}',
                                    Icons.calendar_today,
                                    Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  child: _buildDetailStat(
                                    'Missed Classes',
                                    '${_analyticsData['attendance']['missedClasses']}',
                                    Icons.event_busy,
                                    Colors.orange,
                                  ),
                                ),
                                Expanded(
                                  child: _buildDetailStat(
                                    'Avg. Completion Time',
                                    _analyticsData['assignments']['averageCompletionTime'],
                                    Icons.timer,
                                    Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildDetailStat(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getCourseProgressColor(double progress) {
    if (progress >= 0.8) {
      return Colors.green;
    } else if (progress >= 0.6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.deepOrange;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
