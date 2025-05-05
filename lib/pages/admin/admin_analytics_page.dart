import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'dart:math';

class AdminAnalyticsPage extends StatefulWidget {
  const AdminAnalyticsPage({super.key});

  @override
  State<AdminAnalyticsPage> createState() => _AdminAnalyticsPageState();
}

class _AdminAnalyticsPageState extends State<AdminAnalyticsPage> {
  String _selectedTimeRange = 'This Month';
  String _selectedMetric = 'Attendance';
  
  // Sample data for charts
  final Map<String, List<Map<String, dynamic>>> _attendanceData = {
    'This Week': [
      {'day': 'Mon', 'value': 92},
      {'day': 'Tue', 'value': 88},
      {'day': 'Wed', 'value': 94},
      {'day': 'Thu', 'value': 85},
      {'day': 'Fri', 'value': 90},
    ],
    'This Month': [
      {'day': 'Week 1', 'value': 91},
      {'day': 'Week 2', 'value': 89},
      {'day': 'Week 3', 'value': 93},
      {'day': 'Week 4', 'value': 87},
    ],
    'This Year': [
      {'day': 'Jan', 'value': 88},
      {'day': 'Feb', 'value': 90},
      {'day': 'Mar', 'value': 92},
      {'day': 'Apr', 'value': 89},
      {'day': 'May', 'value': 91},
      {'day': 'Jun', 'value': 87},
      {'day': 'Jul', 'value': 85},
      {'day': 'Aug', 'value': 88},
      {'day': 'Sep', 'value': 93},
      {'day': 'Oct', 'value': 95},
      {'day': 'Nov', 'value': 92},
      {'day': 'Dec', 'value': 90},
    ],
  };
  
  final Map<String, List<Map<String, dynamic>>> _performanceData = {
    'This Week': [
      {'day': 'Mon', 'value': 78},
      {'day': 'Tue', 'value': 82},
      {'day': 'Wed', 'value': 76},
      {'day': 'Thu', 'value': 84},
      {'day': 'Fri', 'value': 80},
    ],
    'This Month': [
      {'day': 'Week 1', 'value': 79},
      {'day': 'Week 2', 'value': 81},
      {'day': 'Week 3', 'value': 83},
      {'day': 'Week 4', 'value': 80},
    ],
    'This Year': [
      {'day': 'Jan', 'value': 76},
      {'day': 'Feb', 'value': 78},
      {'day': 'Mar', 'value': 80},
      {'day': 'Apr', 'value': 82},
      {'day': 'May', 'value': 79},
      {'day': 'Jun', 'value': 81},
      {'day': 'Jul', 'value': 77},
      {'day': 'Aug', 'value': 75},
      {'day': 'Sep', 'value': 83},
      {'day': 'Oct', 'value': 85},
      {'day': 'Nov', 'value': 82},
      {'day': 'Dec', 'value': 80},
    ],
  };
  
  final Map<String, List<Map<String, dynamic>>> _enrollmentData = {
    'This Week': [
      {'day': 'Mon', 'value': 5},
      {'day': 'Tue', 'value': 3},
      {'day': 'Wed', 'value': 7},
      {'day': 'Thu', 'value': 2},
      {'day': 'Fri', 'value': 4},
    ],
    'This Month': [
      {'day': 'Week 1', 'value': 12},
      {'day': 'Week 2', 'value': 18},
      {'day': 'Week 3', 'value': 15},
      {'day': 'Week 4', 'value': 22},
    ],
    'This Year': [
      {'day': 'Jan', 'value': 45},
      {'day': 'Feb', 'value': 38},
      {'day': 'Mar', 'value': 52},
      {'day': 'Apr', 'value': 48},
      {'day': 'May', 'value': 60},
      {'day': 'Jun', 'value': 42},
      {'day': 'Jul', 'value': 30},
      {'day': 'Aug', 'value': 65},
      {'day': 'Sep', 'value': 72},
      {'day': 'Oct', 'value': 58},
      {'day': 'Nov', 'value': 50},
      {'day': 'Dec', 'value': 45},
    ],
  };
  
  // Grade distribution data
  final List<Map<String, dynamic>> _gradeDistribution = [
    {'grade': 'A', 'percentage': 22},
    {'grade': 'B', 'percentage': 38},
    {'grade': 'C', 'percentage': 27},
    {'grade': 'D', 'percentage': 10},
    {'grade': 'F', 'percentage': 3},
  ];
  
  // Subject performance data
  final List<Map<String, dynamic>> _subjectPerformance = [
    {'subject': 'Mathematics', 'average': 78},
    {'subject': 'Science', 'average': 82},
    {'subject': 'English', 'average': 85},
    {'subject': 'History', 'average': 76},
    {'subject': 'Computer Science', 'average': 88},
  ];
  
  // Top performing students
  final List<Map<String, dynamic>> _topStudents = [
    {
      'name': 'Emma Johnson',
      'grade': '11',
      'average': 95,
      'avatar': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'name': 'John Smith',
      'grade': '10',
      'average': 93,
      'avatar': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'name': 'Sophia Davis',
      'grade': '12',
      'average': 92,
      'avatar': 'https://i.pravatar.cc/150?img=9',
    },
    {
      'name': 'Michael Brown',
      'grade': '9',
      'average': 91,
      'avatar': 'https://i.pravatar.cc/150?img=8',
    },
    {
      'name': 'William Wilson',
      'grade': '10',
      'average': 90,
      'avatar': 'https://i.pravatar.cc/150?img=11',
    },
  ];

  List<Map<String, dynamic>> get currentChartData {
    switch (_selectedMetric) {
      case 'Attendance':
        return _attendanceData[_selectedTimeRange]!;
      case 'Performance':
        return _performanceData[_selectedTimeRange]!;
      case 'Enrollment':
        return _enrollmentData[_selectedTimeRange]!;
      default:
        return _attendanceData[_selectedTimeRange]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Row
            Row(
              children: [
                // Time Range Filter
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
                        hint: const Text('Time Range'),
                        items: const [
                          DropdownMenuItem(value: 'This Week', child: Text('This Week')),
                          DropdownMenuItem(value: 'This Month', child: Text('This Month')),
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
                
                // Metric Filter
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMetric,
                        isExpanded: true,
                        hint: const Text('Metric'),
                        items: const [
                          DropdownMenuItem(value: 'Attendance', child: Text('Attendance')),
                          DropdownMenuItem(value: 'Performance', child: Text('Performance')),
                          DropdownMenuItem(value: 'Enrollment', child: Text('Enrollment')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedMetric = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Export Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Generate report
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Generating detailed report...')),
                    );
                  },
                  icon: const Icon(Icons.assessment),
                  label: const Text('Generate Report'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
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
                    'Average Attendance',
                    '${_calculateAverage(_attendanceData[_selectedTimeRange]!)}%',
                    Icons.people,
                    Colors.blue,
                    _getChangeText(_attendanceData[_selectedTimeRange]!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Average Performance',
                    '${_calculateAverage(_performanceData[_selectedTimeRange]!)}%',
                    Icons.trending_up,
                    Colors.green,
                    _getChangeText(_performanceData[_selectedTimeRange]!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'New Enrollments',
                    _calculateSum(_enrollmentData[_selectedTimeRange]!).toString(),
                    Icons.school,
                    Colors.orange,
                    _getChangeText(_enrollmentData[_selectedTimeRange]!, isSum: true),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Main Chart
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_selectedMetric Trend - $_selectedTimeRange',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 250,
                      child: _buildBarChart(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Secondary Charts Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Grade Distribution
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Grade Distribution',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: _buildPieChart(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Subject Performance
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Subject Performance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._subjectPerformance.map((subject) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(subject['subject']),
                                      Text('${subject['average']}%'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: subject['average'] / 100,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(_getSubjectColor(subject['average'])),
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
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Top Performing Students
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Performing Students',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(_topStudents.length, (index) {
                      final student = _topStudents[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(student['avatar']),
                        ),
                        title: Text(student['name']),
                        subtitle: Text('Grade ${student['grade']}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${student['average']}%',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String subtitle) {
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
                color: subtitle.contains('+') ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final data = currentChartData;
    return CustomPaint(
      size: const Size(double.infinity, 250),
      painter: BarChartPainter(
        data: data,
        barColor: _getBarColor(),
        labelColor: Colors.grey[600]!,
      ),
    );
  }

  Widget _buildPieChart() {
    return CustomPaint(
      size: const Size(double.infinity, 200),
      painter: PieChartPainter(
        data: _gradeDistribution,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.orange,
          Colors.amber,
          Colors.red,
        ],
      ),
    );
  }

  Color _getBarColor() {
    switch (_selectedMetric) {
      case 'Attendance':
        return Colors.blue;
      case 'Performance':
        return Colors.green;
      case 'Enrollment':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  Color _getSubjectColor(int average) {
    if (average >= 85) {
      return Colors.green;
    } else if (average >= 75) {
      return Colors.blue;
    } else if (average >= 65) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  int _calculateAverage(List<Map<String, dynamic>> data) {
    final sum = data.map((e) => e['value'] as int).reduce((a, b) => a + b);
    return (sum / data.length).round();
  }

  int _calculateSum(List<Map<String, dynamic>> data) {
    return data.map((e) => e['value'] as int).reduce((a, b) => a + b);
  }

  String _getChangeText(List<Map<String, dynamic>> data, {bool isSum = false}) {
    final current = isSum ? _calculateSum(data) : _calculateAverage(data);
    final previous = current - Random().nextInt(5) + 2; // Simulate previous value
    final change = ((current - previous) / previous * 100).round();
    
    if (change > 0) {
      return '+$change% from previous period';
    } else {
      return '$change% from previous period';
    }
  }
}

class BarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final Color barColor;
  final Color labelColor;

  BarChartPainter({
    required this.data,
    required this.barColor,
    required this.labelColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double barWidth = size.width / (data.length * 2);
    final double maxValue = data.map((e) => e['value'] as num).reduce(max).toDouble();
    final double scaleFactor = size.height / maxValue;
    
    // Draw bars
    final Paint barPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;
    
    // Draw x-axis labels
    final TextStyle labelStyle = TextStyle(
      color: labelColor,
      fontSize: 12,
    );
    
    for (int i = 0; i < data.length; i++) {
      final double x = i * (size.width / data.length) + (size.width / data.length / 2) - barWidth / 2;
      final double barHeight = data[i]['value'] * scaleFactor;
      final double y = size.height - barHeight;
      
      // Draw bar
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(4),
        ),
        barPaint,
      );
      
      // Draw label
      final TextPainter labelPainter = TextPainter(
        text: TextSpan(
          text: data[i]['day'],
          style: labelStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      labelPainter.layout();
      labelPainter.paint(
        canvas,
        Offset(x - labelPainter.width / 2 + barWidth / 2, size.height + 5),
      );
      
      // Draw value
      final TextPainter valuePainter = TextPainter(
        text: TextSpan(
          text: '${data[i]['value']}',
          style: labelStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      valuePainter.layout();
      valuePainter.paint(
        canvas,
        Offset(x - valuePainter.width / 2 + barWidth / 2, y - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final List<Color> colors;

  PieChartPainter({
    required this.data,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double total = data.map((e) => e['percentage'] as num).reduce((a, b) => a + b).toDouble();
    final double radius = size.width < size.height ? size.width / 2 : size.height / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    
    double startAngle = 0;
    
    for (int i = 0; i < data.length; i++) {
      final double sweepAngle = (data[i]['percentage'] / total) * 2 * pi;
      
      final Paint paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      
      // Draw label
      final double labelAngle = startAngle + sweepAngle / 2;
      final double labelRadius = radius * 0.7;
      final Offset labelPosition = Offset(
        center.dx + cos(labelAngle) * labelRadius,
        center.dy + sin(labelAngle) * labelRadius,
      );
      
      final TextPainter labelPainter = TextPainter(
        text: TextSpan(
          text: '${data[i]['grade']}: ${data[i]['percentage']}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      labelPainter.layout();
      labelPainter.paint(
        canvas,
        Offset(
          labelPosition.dx - labelPainter.width / 2,
          labelPosition.dy - labelPainter.height / 2,
        ),
      );
      
      startAngle += sweepAngle;
    }
    
    // Draw center circle for donut chart effect
    final Paint centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.4, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
