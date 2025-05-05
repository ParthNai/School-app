import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TeacherCoursesPage extends StatefulWidget {
  const TeacherCoursesPage({super.key});

  @override
  State<TeacherCoursesPage> createState() => _TeacherCoursesPageState();
}

class _TeacherCoursesPageState extends State<TeacherCoursesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedGradeFilter = 'All';
  
  // Sample course data for the teacher
  final List<Map<String, dynamic>> _teacherCourses = [
    {
      'id': 'CRS001',
      'name': 'Advanced Mathematics',
      'grade': '12',
      'subject': 'Mathematics',
      'students': 42,
      'schedule': 'Mon, Wed, Fri - 9:00 AM',
      'description': 'Advanced mathematics course covering calculus, linear algebra, and statistics.',
      'materials': ['Textbook', 'Practice Problems', 'Video Lectures'],
      'progress': 0.75,
      'room': 'Room 101',
      'hasPaper': true,
    },
    {
      'id': 'CRS002',
      'name': 'Mathematics Fundamentals',
      'grade': '10',
      'subject': 'Mathematics',
      'students': 38,
      'schedule': 'Tue, Thu - 10:30 AM',
      'description': 'Introduction to algebra, geometry, and trigonometry.',
      'materials': ['Textbook', 'Practice Problems', 'Question Bank'],
      'progress': 0.68,
      'room': 'Room 203',
      'hasPaper': true,
    },
    {
      'id': 'CRS003',
      'name': 'Calculus I',
      'grade': '11',
      'subject': 'Mathematics',
      'students': 35,
      'schedule': 'Mon, Wed - 1:00 PM',
      'description': 'Introduction to differential and integral calculus.',
      'materials': ['Textbook', 'Study Guides', 'Problem Sets'],
      'progress': 0.82,
      'room': 'Room 105',
      'hasPaper': false,
    },
    {
      'id': 'CRS004',
      'name': 'Physics for Mathematics',
      'grade': '12',
      'subject': 'Physics',
      'students': 32,
      'schedule': 'Fri - 2:00 PM',
      'description': 'Application of mathematical concepts in physics.',
      'materials': ['Textbook', 'Lab Materials'],
      'progress': 0.45,
      'room': 'Lab 3',
      'hasPaper': false,
    },
    {
      'id': 'CRS005',
      'name': 'Statistics',
      'grade': '11',
      'subject': 'Mathematics',
      'students': 36,
      'schedule': 'Tue, Thu - 2:00 PM',
      'description': 'Introduction to statistical methods and data analysis.',
      'materials': ['Textbook', 'Data Sets', 'Research Papers'],
      'progress': 0.55,
      'room': 'Room 202',
      'hasPaper': true,
    },
  ];

  List<Map<String, dynamic>> get filteredCourses {
    return _teacherCourses.where((course) {
      // Apply search filter
      final nameMatches = course['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final idMatches = course['id'].toLowerCase().contains(_searchQuery.toLowerCase());
      final subjectMatches = course['subject'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Apply grade filter
      final gradeMatches = _selectedGradeFilter == 'All' || course['grade'] == _selectedGradeFilter;
      
      return (nameMatches || idMatches || subjectMatches) && gradeMatches;
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
        title: const Text('My Courses'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () {
              // Export course data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting course data...')),
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
                      hintText: 'Search by name, ID, or subject',
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
                  flex: 1,
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
                
                // Add Paper Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to paper creation
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreatePaperPage(),
                      ),
                    );
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
            
            const SizedBox(height: 24),
            
            // Course Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return _buildCourseCard(context, course);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          _showCourseDetailsDialog(context, course);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      course['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (course['hasPaper'])
                    Tooltip(
                      message: 'Has Exam Paper',
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.assignment,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Grade ${course['grade']} - ${course['subject']}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                course['room'],
                style: TextStyle(
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${course['students']} students',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Course Progress:',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: course['progress'],
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
              const SizedBox(height: 4),
              Text(
                '${(course['progress'] * 100).toInt()}% Complete',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.assignment_add, size: 20),
                    tooltip: 'Create Paper',
                    onPressed: () {
                      _navigateToCreatePaper(context, course);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.people, size: 20),
                    tooltip: 'View Students',
                    onPressed: () {
                      _showStudentsDialog(context, course);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    tooltip: 'Edit Course',
                    onPressed: () {
                      _showEditCourseDialog(context, course);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCourseDetailsDialog(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(course['name']),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${course['id']}'),
                const SizedBox(height: 8),
                Text('Grade: ${course['grade']}'),
                const SizedBox(height: 8),
                Text('Subject: ${course['subject']}'),
                const SizedBox(height: 8),
                Text('Students: ${course['students']}'),
                const SizedBox(height: 8),
                Text('Schedule: ${course['schedule']}'),
                const SizedBox(height: 8),
                Text('Room: ${course['room']}'),
                const SizedBox(height: 16),
                const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(course['description']),
                const SizedBox(height: 16),
                const Text('Materials:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                ...List.generate(
                  (course['materials'] as List).length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(course['materials'][index]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Progress:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: course['progress'],
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                ),
                const SizedBox(height: 4),
                Text('${(course['progress'] * 100).toInt()}% Complete'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Exam Paper:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text(
                      course['hasPaper'] ? 'Created' : 'Not Created',
                      style: TextStyle(
                        color: course['hasPaper'] ? Colors.green : Colors.red,
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
            if (!course['hasPaper'])
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _navigateToCreatePaper(context, course);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                ),
                child: const Text('Create Paper'),
              ),
          ],
        );
      },
    );
  }

  void _showStudentsDialog(BuildContext context, Map<String, dynamic> course) {
    // Sample student data
    final List<Map<String, dynamic>> students = [
      {
        'id': 'STU001',
        'name': 'John Smith',
        'grade': course['grade'],
        'section': 'A',
        'attendance': '95%',
        'performance': '87%',
        'avatar': 'https://i.pravatar.cc/150?img=1',
      },
      {
        'id': 'STU002',
        'name': 'Emma Johnson',
        'grade': course['grade'],
        'section': 'A',
        'attendance': '98%',
        'performance': '92%',
        'avatar': 'https://i.pravatar.cc/150?img=5',
      },
      {
        'id': 'STU003',
        'name': 'Michael Brown',
        'grade': course['grade'],
        'section': 'A',
        'attendance': '82%',
        'performance': '78%',
        'avatar': 'https://i.pravatar.cc/150?img=8',
      },
      {
        'id': 'STU004',
        'name': 'Sophia Davis',
        'grade': course['grade'],
        'section': 'A',
        'attendance': '91%',
        'performance': '85%',
        'avatar': 'https://i.pravatar.cc/150?img=9',
      },
      {
        'id': 'STU005',
        'name': 'William Wilson',
        'grade': course['grade'],
        'section': 'A',
        'attendance': '89%',
        'performance': '81%',
        'avatar': 'https://i.pravatar.cc/150?img=11',
      },
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Students in ${course['name']}'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(student['avatar']),
                  ),
                  title: Text(student['name']),
                  subtitle: Text('ID: ${student['id']}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Attendance: ${student['attendance']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Performance: ${student['performance']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  onTap: () {
                    // View student details
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEditCourseDialog(BuildContext context, Map<String, dynamic> course) {
    final TextEditingController descriptionController = TextEditingController(text: course['description']);
    final TextEditingController scheduleController = TextEditingController(text: course['schedule']);
    final TextEditingController roomController = TextEditingController(text: course['room']);
    
    // Materials
    final List<String> availableMaterials = [
      'Textbook', 'Practice Problems', 'Video Lectures', 
      'Lab Materials', 'Question Bank', 'Study Guides',
      'Research Papers', 'Essay Templates', 'Novels',
      'Data Sets', 'Problem Sets'
    ];
    final List<String> selectedMaterials = List<String>.from(course['materials']);
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit ${course['name']}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: scheduleController,
                      decoration: const InputDecoration(
                        labelText: 'Schedule',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: roomController,
                      decoration: const InputDecoration(
                        labelText: 'Room',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    const Text('Course Materials', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: availableMaterials.map((material) {
                        final isSelected = selectedMaterials.contains(material);
                        return FilterChip(
                          label: Text(material),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedMaterials.add(material);
                              } else {
                                selectedMaterials.remove(material);
                              }
                            });
                          },
                          selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                          checkmarkColor: AppTheme.primaryColor,
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
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Update course logic
                    this.setState(() {
                      final index = _teacherCourses.indexWhere((c) => c['id'] == course['id']);
                      if (index != -1) {
                        _teacherCourses[index] = {
                          ..._teacherCourses[index],
                          'schedule': scheduleController.text,
                          'room': roomController.text,
                          'description': descriptionController.text,
                          'materials': List<String>.from(selectedMaterials),
                        };
                      }
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Course updated successfully')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Update'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _navigateToCreatePaper(BuildContext context, Map<String, dynamic> course) {
    // Navigate to create paper page with course details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePaperPage(course: course),
      ),
    );
  }
}

// Placeholder for CreatePaperPage with course parameter
class CreatePaperPage extends StatefulWidget {
  final Map<String, dynamic>? course;
  
  const CreatePaperPage({super.key, this.course});

  @override
  State<CreatePaperPage> createState() => _CreatePaperPageState();
}

class _CreatePaperPageState extends State<CreatePaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course != null 
            ? 'Create Paper for ${widget.course!['name']}' 
            : 'Create New Paper'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          widget.course != null
              ? 'Create paper interface for ${widget.course!['name']}'
              : 'Create new paper interface',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
