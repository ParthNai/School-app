import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TeacherStudentsPage extends StatefulWidget {
  const TeacherStudentsPage({super.key});

  @override
  State<TeacherStudentsPage> createState() => _TeacherStudentsPageState();
}

class _TeacherStudentsPageState extends State<TeacherStudentsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedGradeFilter = 'All';
  String _selectedSectionFilter = 'All';
  String _selectedStatusFilter = 'All';
  
  // Sample student data
  final List<Map<String, dynamic>> _students = [
    {
      'id': 'STU001',
      'name': 'John Smith',
      'grade': '10',
      'section': 'A',
      'email': 'john.smith@example.com',
      'phone': '(555) 123-4567',
      'attendance': 0.95,
      'performance': 0.87,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'id': 'STU002',
      'name': 'Emma Johnson',
      'grade': '10',
      'section': 'A',
      'email': 'emma.johnson@example.com',
      'phone': '(555) 234-5678',
      'attendance': 0.98,
      'performance': 0.92,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'id': 'STU003',
      'name': 'Michael Brown',
      'grade': '10',
      'section': 'B',
      'email': 'michael.brown@example.com',
      'phone': '(555) 345-6789',
      'attendance': 0.82,
      'performance': 0.78,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=8',
    },
    {
      'id': 'STU004',
      'name': 'Sophia Davis',
      'grade': '11',
      'section': 'A',
      'email': 'sophia.davis@example.com',
      'phone': '(555) 456-7890',
      'attendance': 0.91,
      'performance': 0.85,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=9',
    },
    {
      'id': 'STU005',
      'name': 'William Wilson',
      'grade': '11',
      'section': 'B',
      'email': 'william.wilson@example.com',
      'phone': '(555) 567-8901',
      'attendance': 0.89,
      'performance': 0.81,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=11',
    },
    {
      'id': 'STU006',
      'name': 'Olivia Martinez',
      'grade': '11',
      'section': 'A',
      'email': 'olivia.martinez@example.com',
      'phone': '(555) 678-9012',
      'attendance': 0.94,
      'performance': 0.88,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=20',
    },
    {
      'id': 'STU007',
      'name': 'James Taylor',
      'grade': '12',
      'section': 'A',
      'email': 'james.taylor@example.com',
      'phone': '(555) 789-0123',
      'attendance': 0.86,
      'performance': 0.79,
      'status': 'Inactive',
      'avatar': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'id': 'STU008',
      'name': 'Isabella Anderson',
      'grade': '12',
      'section': 'B',
      'email': 'isabella.anderson@example.com',
      'phone': '(555) 890-1234',
      'attendance': 0.97,
      'performance': 0.94,
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=23',
    },
  ];

  List<Map<String, dynamic>> get filteredStudents {
    return _students.where((student) {
      // Apply search filter
      final nameMatches = student['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final idMatches = student['id'].toLowerCase().contains(_searchQuery.toLowerCase());
      final emailMatches = student['email'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Apply grade filter
      final gradeMatches = _selectedGradeFilter == 'All' || student['grade'] == _selectedGradeFilter;
      
      // Apply section filter
      final sectionMatches = _selectedSectionFilter == 'All' || student['section'] == _selectedSectionFilter;
      
      // Apply status filter
      final statusMatches = _selectedStatusFilter == 'All' || student['status'] == _selectedStatusFilter;
      
      return (nameMatches || idMatches || emailMatches) && gradeMatches && sectionMatches && statusMatches;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Students'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () {
              // Export student data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting student data...')),
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
            // Search and Filter Row
            Row(
              children: [
                // Search Field
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name, ID, or email',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                
                // Grade Filter Dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedGradeFilter,
                        isExpanded: true,
                        hint: const Text('Grade'),
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All Grades')),
                          DropdownMenuItem(value: '9', child: Text('Grade 9')),
                          DropdownMenuItem(value: '10', child: Text('Grade 10')),
                          DropdownMenuItem(value: '11', child: Text('Grade 11')),
                          DropdownMenuItem(value: '12', child: Text('Grade 12')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedGradeFilter = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Section Filter Dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSectionFilter,
                        isExpanded: true,
                        hint: const Text('Section'),
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All Sections')),
                          DropdownMenuItem(value: 'A', child: Text('Section A')),
                          DropdownMenuItem(value: 'B', child: Text('Section B')),
                          DropdownMenuItem(value: 'C', child: Text('Section C')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSectionFilter = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Status Filter Dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStatusFilter,
                        isExpanded: true,
                        hint: const Text('Status'),
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All Status')),
                          DropdownMenuItem(value: 'Active', child: Text('Active')),
                          DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedStatusFilter = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Students Table
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
                      // Table Header
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 60),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'ID',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Grade',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Section',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Attendance',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Performance',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            const SizedBox(width: 100),
                          ],
                        ),
                      ),
                      
                      // Table Body
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = filteredStudents[index];
                            return _buildStudentRow(student);
                          },
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

  Widget _buildStudentRow(Map<String, dynamic> student) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(student['avatar']),
          ),
          const SizedBox(width: 20),
          
          // Name
          Expanded(
            flex: 2,
            child: Text(
              student['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // ID
          Expanded(
            child: Text(student['id']),
          ),
          
          // Grade
          Expanded(
            child: Text('Grade ${student['grade']}'),
          ),
          
          // Section
          Expanded(
            child: Text('Section ${student['section']}'),
          ),
          
          // Attendance
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${(student['attendance'] * 100).toInt()}%'),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: student['attendance'],
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getAttendanceColor(student['attendance']),
                  ),
                ),
              ],
            ),
          ),
          
          // Performance
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${(student['performance'] * 100).toInt()}%'),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: student['performance'],
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getPerformanceColor(student['performance']),
                  ),
                ),
              ],
            ),
          ),
          
          // Actions
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  tooltip: 'View Details',
                  onPressed: () {
                    _showStudentDetailsDialog(context, student);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.message, size: 20),
                  tooltip: 'Message',
                  onPressed: () {
                    _showMessageDialog(context, student);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.assessment, size: 20),
                  tooltip: 'Assessment',
                  onPressed: () {
                    _showAssessmentDialog(context, student);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getAttendanceColor(double attendance) {
    if (attendance >= 0.9) {
      return Colors.green;
    } else if (attendance >= 0.8) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Color _getPerformanceColor(double performance) {
    if (performance >= 0.9) {
      return Colors.green;
    } else if (performance >= 0.7) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void _showStudentDetailsDialog(BuildContext context, Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(student['name']),
          content: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(student['avatar']),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${student['id']}'),
                          const SizedBox(height: 8),
                          Text('Grade: ${student['grade']} - Section ${student['section']}'),
                          const SizedBox(height: 8),
                          Text('Email: ${student['email']}'),
                          const SizedBox(height: 8),
                          Text('Phone: ${student['phone']}'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('Status: '),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: student['status'] == 'Active' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  student['status'],
                                  style: TextStyle(
                                    color: student['status'] == 'Active' ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Performance Metrics',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Attendance'),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: student['attendance'],
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getAttendanceColor(student['attendance']),
                            ),
                            minHeight: 10,
                          ),
                          const SizedBox(height: 4),
                          Text('${(student['attendance'] * 100).toInt()}%'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Academic Performance'),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: student['performance'],
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getPerformanceColor(student['performance']),
                            ),
                            minHeight: 10,
                          ),
                          const SizedBox(height: 4),
                          Text('${(student['performance'] * 100).toInt()}%'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showMessageDialog(context, student);
              },
              icon: const Icon(Icons.message),
              label: const Text('Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessageDialog(BuildContext context, Map<String, dynamic> student) {
    final TextEditingController messageController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message to ${student['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (messageController.text.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Message sent to ${student['name']}')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showAssessmentDialog(BuildContext context, Map<String, dynamic> student) {
    // Sample assessment data
    final List<Map<String, dynamic>> assessments = [
      {
        'title': 'Mid-Term Exam',
        'subject': 'Mathematics',
        'date': '2025-03-15',
        'score': 85,
        'maxScore': 100,
      },
      {
        'title': 'Quiz 1',
        'subject': 'Mathematics',
        'date': '2025-02-10',
        'score': 18,
        'maxScore': 20,
      },
      {
        'title': 'Assignment 2',
        'subject': 'Mathematics',
        'date': '2025-02-28',
        'score': 27,
        'maxScore': 30,
      },
      {
        'title': 'Class Participation',
        'subject': 'Mathematics',
        'date': '2025-01-31',
        'score': 9,
        'maxScore': 10,
      },
    ];
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${student['name']} - Assessments'),
          content: SizedBox(
            width: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Assessment Table
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Subject')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Score')),
                    DataColumn(label: Text('Grade')),
                  ],
                  rows: assessments.map((assessment) {
                    final score = assessment['score'];
                    final maxScore = assessment['maxScore'];
                    final percentage = (score / maxScore) * 100;
                    String grade;
                    Color gradeColor;
                    
                    if (percentage >= 90) {
                      grade = 'A';
                      gradeColor = Colors.green;
                    } else if (percentage >= 80) {
                      grade = 'B';
                      gradeColor = Colors.blue;
                    } else if (percentage >= 70) {
                      grade = 'C';
                      gradeColor = Colors.orange;
                    } else if (percentage >= 60) {
                      grade = 'D';
                      gradeColor = Colors.deepOrange;
                    } else {
                      grade = 'F';
                      gradeColor = Colors.red;
                    }
                    
                    return DataRow(
                      cells: [
                        DataCell(Text(assessment['title'])),
                        DataCell(Text(assessment['subject'])),
                        DataCell(Text(assessment['date'])),
                        DataCell(Text('${assessment['score']}/${assessment['maxScore']}')),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: gradeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              grade,
                              style: TextStyle(
                                color: gradeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Add new assessment
                Navigator.pop(context);
                _showAddAssessmentDialog(context, student);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Assessment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddAssessmentDialog(BuildContext context, Map<String, dynamic> student) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController scoreController = TextEditingController();
    final TextEditingController maxScoreController = TextEditingController(text: '100');
    String selectedSubject = 'Mathematics';
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Assessment for ${student['name']}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Assessment Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedSubject,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'Mathematics', 'Physics', 'Chemistry', 'Biology',
                      'English', 'History', 'Geography', 'Computer Science'
                    ].map((subject) {
                      return DropdownMenuItem(
                        value: subject,
                        child: Text(subject),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSubject = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: scoreController,
                          decoration: const InputDecoration(
                            labelText: 'Score',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: maxScoreController,
                          decoration: const InputDecoration(
                            labelText: 'Max Score',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty && scoreController.text.isNotEmpty) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Assessment added for ${student['name']}')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Add'),
                ),
              ],
            );
          }
        );
      },
    );
  }
}
