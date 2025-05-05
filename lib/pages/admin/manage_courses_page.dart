import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ManageCoursesPage extends StatefulWidget {
  const ManageCoursesPage({super.key});

  @override
  State<ManageCoursesPage> createState() => _ManageCoursesPageState();
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedGradeFilter = 'All';
  String _selectedStatusFilter = 'All';
  
  // Sample course data
  final List<Map<String, dynamic>> _courses = [
    {
      'id': 'CRS001',
      'name': 'Advanced Mathematics',
      'grade': '12',
      'subject': 'Mathematics',
      'teacher': 'Dr. Robert Johnson',
      'status': 'Active',
      'students': 42,
      'schedule': 'Mon, Wed, Fri - 9:00 AM',
      'description': 'Advanced mathematics course covering calculus, linear algebra, and statistics.',
      'materials': ['Textbook', 'Practice Problems', 'Video Lectures'],
      'progress': 0.75,
    },
    {
      'id': 'CRS002',
      'name': 'Physics Fundamentals',
      'grade': '11',
      'subject': 'Physics',
      'teacher': 'Prof. Sarah Williams',
      'status': 'Active',
      'students': 38,
      'schedule': 'Tue, Thu - 10:30 AM',
      'description': 'Introduction to physics principles including mechanics, thermodynamics, and waves.',
      'materials': ['Textbook', 'Lab Materials', 'Question Bank'],
      'progress': 0.68,
    },
    {
      'id': 'CRS003',
      'name': 'English Literature',
      'grade': '10',
      'subject': 'English',
      'teacher': 'Ms. Emily Davis',
      'status': 'Active',
      'students': 45,
      'schedule': 'Mon, Wed - 1:00 PM',
      'description': 'Study of classic and contemporary literature with focus on critical analysis.',
      'materials': ['Novels', 'Study Guides', 'Essay Templates'],
      'progress': 0.82,
    },
    {
      'id': 'CRS004',
      'name': 'Chemistry Basics',
      'grade': '9',
      'subject': 'Chemistry',
      'teacher': 'Mr. James Wilson',
      'status': 'Inactive',
      'students': 0,
      'schedule': 'Not scheduled',
      'description': 'Introduction to basic chemistry concepts and laboratory techniques.',
      'materials': ['Textbook', 'Lab Materials'],
      'progress': 0.0,
    },
    {
      'id': 'CRS005',
      'name': 'Biology Advanced',
      'grade': '12',
      'subject': 'Biology',
      'teacher': 'Dr. Lisa Brown',
      'status': 'Active',
      'students': 36,
      'schedule': 'Tue, Thu - 2:00 PM',
      'description': 'Advanced study of biological systems, genetics, and evolutionary biology.',
      'materials': ['Textbook', 'Lab Materials', 'Research Papers'],
      'progress': 0.55,
    },
  ];

  List<Map<String, dynamic>> get filteredCourses {
    return _courses.where((course) {
      // Apply search filter
      final nameMatches = course['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final idMatches = course['id'].toLowerCase().contains(_searchQuery.toLowerCase());
      final subjectMatches = course['subject'].toLowerCase().contains(_searchQuery.toLowerCase());
      final teacherMatches = course['teacher'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Apply grade filter
      final gradeMatches = _selectedGradeFilter == 'All' || course['grade'] == _selectedGradeFilter;
      
      // Apply status filter
      final statusMatches = _selectedStatusFilter == 'All' || course['status'] == _selectedStatusFilter;
      
      return (nameMatches || idMatches || subjectMatches || teacherMatches) && 
             gradeMatches && statusMatches;
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
        title: const Text('Manage Courses'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog(context);
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
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
                      hintText: 'Search by name, ID, subject, or teacher',
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
                
                // Status Filter Dropdown
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
    final Color statusColor = course['status'] == 'Active' ? Colors.green : Colors.red;
    
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      course['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
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
                'Teacher: ${course['teacher']}',
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
              if (course['status'] == 'Active') ...[
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
              ],
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () {
                      _showEditCourseDialog(context, course);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, course);
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
                Text('Teacher: ${course['teacher']}'),
                const SizedBox(height: 8),
                Text('Status: ${course['status']}'),
                const SizedBox(height: 8),
                Text('Students: ${course['students']}'),
                const SizedBox(height: 8),
                Text('Schedule: ${course['schedule']}'),
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
                if (course['status'] == 'Active') ...[
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
                ],
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
          ],
        );
      },
    );
  }

  void _showAddCourseDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController scheduleController = TextEditingController();
    String selectedGrade = '10';
    String selectedSubject = 'Mathematics';
    String selectedTeacher = 'Dr. Robert Johnson';
    
    // Available teachers
    final List<String> teachers = _getUniqueTeachers();
    
    // Available subjects
    final List<String> subjects = [
      'Mathematics', 'Physics', 'Chemistry', 'Biology', 
      'English', 'History', 'Geography', 'Computer Science'
    ];
    
    // Materials
    final List<String> availableMaterials = [
      'Textbook', 'Practice Problems', 'Video Lectures', 
      'Lab Materials', 'Question Bank', 'Study Guides',
      'Research Papers', 'Essay Templates', 'Novels'
    ];
    final List<String> selectedMaterials = ['Textbook'];
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Course'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Course Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedGrade,
                            decoration: const InputDecoration(
                              labelText: 'Grade',
                              border: OutlineInputBorder(),
                            ),
                            items: ['9', '10', '11', '12'].map((grade) {
                              return DropdownMenuItem(
                                value: grade,
                                child: Text('Grade $grade'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedGrade = value!;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedSubject,
                            decoration: const InputDecoration(
                              labelText: 'Subject',
                              border: OutlineInputBorder(),
                            ),
                            items: subjects.map((subject) {
                              return DropdownMenuItem(
                                value: subject,
                                child: Text(subject),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedSubject = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedTeacher,
                      decoration: const InputDecoration(
                        labelText: 'Teacher',
                        border: OutlineInputBorder(),
                      ),
                      items: teachers.map((teacher) {
                        return DropdownMenuItem(
                          value: teacher,
                          child: Text(teacher),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedTeacher = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: scheduleController,
                      decoration: const InputDecoration(
                        labelText: 'Schedule (e.g., Mon, Wed - 9:00 AM)',
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
                    // Add new course logic
                    if (nameController.text.isNotEmpty) {
                      this.setState(() {
                        _courses.add({
                          'id': 'CRS00${_courses.length + 1}',
                          'name': nameController.text,
                          'grade': selectedGrade,
                          'subject': selectedSubject,
                          'teacher': selectedTeacher,
                          'status': 'Active',
                          'students': 0,
                          'schedule': scheduleController.text.isEmpty ? 'Not scheduled' : scheduleController.text,
                          'description': descriptionController.text.isEmpty ? 
                                        'No description provided' : descriptionController.text,
                          'materials': List<String>.from(selectedMaterials),
                          'progress': 0.0,
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Course added successfully')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Add Course'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showEditCourseDialog(BuildContext context, Map<String, dynamic> course) {
    final TextEditingController nameController = TextEditingController(text: course['name']);
    final TextEditingController descriptionController = TextEditingController(text: course['description']);
    final TextEditingController scheduleController = TextEditingController(text: course['schedule']);
    String selectedGrade = course['grade'];
    String selectedSubject = course['subject'];
    String selectedTeacher = course['teacher'];
    String selectedStatus = course['status'];
    
    // Available teachers
    final List<String> teachers = _getUniqueTeachers();
    
    // Available subjects
    final List<String> subjects = [
      'Mathematics', 'Physics', 'Chemistry', 'Biology', 
      'English', 'History', 'Geography', 'Computer Science'
    ];
    
    // Materials
    final List<String> availableMaterials = [
      'Textbook', 'Practice Problems', 'Video Lectures', 
      'Lab Materials', 'Question Bank', 'Study Guides',
      'Research Papers', 'Essay Templates', 'Novels'
    ];
    final List<String> selectedMaterials = List<String>.from(course['materials']);
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Course'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Course Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedGrade,
                            decoration: const InputDecoration(
                              labelText: 'Grade',
                              border: OutlineInputBorder(),
                            ),
                            items: ['9', '10', '11', '12'].map((grade) {
                              return DropdownMenuItem(
                                value: grade,
                                child: Text('Grade $grade'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedGrade = value!;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedSubject,
                            decoration: const InputDecoration(
                              labelText: 'Subject',
                              border: OutlineInputBorder(),
                            ),
                            items: subjects.map((subject) {
                              return DropdownMenuItem(
                                value: subject,
                                child: Text(subject),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedSubject = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedTeacher,
                      decoration: const InputDecoration(
                        labelText: 'Teacher',
                        border: OutlineInputBorder(),
                      ),
                      items: teachers.map((teacher) {
                        return DropdownMenuItem(
                          value: teacher,
                          child: Text(teacher),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedTeacher = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: scheduleController,
                      decoration: const InputDecoration(
                        labelText: 'Schedule',
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
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Active', child: Text('Active')),
                        DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
                      ],
                      onChanged: (value) {
                        selectedStatus = value!;
                      },
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
                    if (nameController.text.isNotEmpty) {
                      this.setState(() {
                        final index = _courses.indexWhere((c) => c['id'] == course['id']);
                        if (index != -1) {
                          _courses[index] = {
                            ..._courses[index],
                            'name': nameController.text,
                            'grade': selectedGrade,
                            'subject': selectedSubject,
                            'teacher': selectedTeacher,
                            'status': selectedStatus,
                            'schedule': scheduleController.text,
                            'description': descriptionController.text,
                            'materials': List<String>.from(selectedMaterials),
                          };
                        }
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Course updated successfully')),
                      );
                    }
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

  void _showDeleteConfirmationDialog(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Course'),
          content: Text('Are you sure you want to delete ${course['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _courses.removeWhere((c) => c['id'] == course['id']);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course deleted successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  List<String> _getUniqueTeachers() {
    return [
      'Dr. Robert Johnson',
      'Prof. Sarah Williams',
      'Ms. Emily Davis',
      'Mr. James Wilson',
      'Dr. Lisa Brown',
    ];
  }
}
