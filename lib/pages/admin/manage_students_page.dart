import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({super.key});

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedSort = 'Name (A-Z)';
  
  // Sample student data
  final List<Map<String, dynamic>> _students = [
    {
      'id': 'STU001',
      'name': 'John Smith',
      'grade': '10',
      'section': 'A',
      'email': 'john.smith@example.com',
      'phone': '+1 234 567 8901',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'attendance': '95%',
      'joinDate': '15 Aug 2024',
    },
    {
      'id': 'STU002',
      'name': 'Emma Johnson',
      'grade': '11',
      'section': 'B',
      'email': 'emma.johnson@example.com',
      'phone': '+1 234 567 8902',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'attendance': '98%',
      'joinDate': '10 Jul 2023',
    },
    {
      'id': 'STU003',
      'name': 'Michael Brown',
      'grade': '9',
      'section': 'C',
      'email': 'michael.brown@example.com',
      'phone': '+1 234 567 8903',
      'status': 'Inactive',
      'avatar': 'https://i.pravatar.cc/150?img=8',
      'attendance': '82%',
      'joinDate': '22 Sep 2024',
    },
    {
      'id': 'STU004',
      'name': 'Sophia Davis',
      'grade': '12',
      'section': 'A',
      'email': 'sophia.davis@example.com',
      'phone': '+1 234 567 8904',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=9',
      'attendance': '91%',
      'joinDate': '05 Jan 2022',
    },
    {
      'id': 'STU005',
      'name': 'William Wilson',
      'grade': '10',
      'section': 'B',
      'email': 'william.wilson@example.com',
      'phone': '+1 234 567 8905',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=11',
      'attendance': '89%',
      'joinDate': '18 Mar 2023',
    },
  ];

  List<Map<String, dynamic>> get filteredStudents {
    return _students.where((student) {
      // Apply search filter
      final nameMatches = student['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final idMatches = student['id'].toLowerCase().contains(_searchQuery.toLowerCase());
      final emailMatches = student['email'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Apply status filter
      final statusMatches = _selectedFilter == 'All' || student['status'] == _selectedFilter;
      
      return (nameMatches || idMatches || emailMatches) && statusMatches;
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
        title: const Text('Manage Students'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStudentDialog(context);
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
                
                // Filter Dropdown
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
                        value: _selectedFilter,
                        isExpanded: true,
                        hint: const Text('Filter'),
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All')),
                          DropdownMenuItem(value: 'Active', child: Text('Active')),
                          DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Sort Dropdown
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
                        value: _selectedSort,
                        isExpanded: true,
                        hint: const Text('Sort by'),
                        items: const [
                          DropdownMenuItem(value: 'Name (A-Z)', child: Text('Name (A-Z)')),
                          DropdownMenuItem(value: 'Name (Z-A)', child: Text('Name (Z-A)')),
                          DropdownMenuItem(value: 'Grade (High-Low)', child: Text('Grade (High-Low)')),
                          DropdownMenuItem(value: 'Grade (Low-High)', child: Text('Grade (Low-High)')),
                          DropdownMenuItem(value: 'Recent First', child: Text('Recent First')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSort = value!;
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Student')),
                      DataColumn(label: Text('Grade/Section')),
                      DataColumn(label: Text('Contact')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Attendance')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: filteredStudents.map((student) {
                      return DataRow(
                        cells: [
                          DataCell(Text(student['id'])),
                          DataCell(
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(student['avatar']),
                                  radius: 16,
                                ),
                                const SizedBox(width: 12),
                                Text(student['name']),
                              ],
                            ),
                          ),
                          DataCell(Text('${student['grade']} - ${student['section']}')),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(student['email'], style: const TextStyle(fontSize: 12)),
                                Text(student['phone'], style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: student['status'] == 'Active' 
                                    ? Colors.green.withOpacity(0.1) 
                                    : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                student['status'],
                                style: TextStyle(
                                  color: student['status'] == 'Active' 
                                      ? Colors.green 
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          DataCell(Text(student['attendance'])),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () {
                                    // Edit student
                                    _showEditStudentDialog(context, student);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 20),
                                  onPressed: () {
                                    // Delete student
                                    _showDeleteConfirmationDialog(context, student);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    String selectedGrade = '10';
    String selectedSection = 'A';
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Student'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
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
                            child: Text(grade),
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
                        value: selectedSection,
                        decoration: const InputDecoration(
                          labelText: 'Section',
                          border: OutlineInputBorder(),
                        ),
                        items: ['A', 'B', 'C', 'D'].map((section) {
                          return DropdownMenuItem(
                            value: section,
                            child: Text(section),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedSection = value!;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
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
                // Add new student logic
                if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                  setState(() {
                    _students.add({
                      'id': 'STU00${_students.length + 1}',
                      'name': nameController.text,
                      'grade': selectedGrade,
                      'section': selectedSection,
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'status': 'Active',
                      'avatar': 'https://i.pravatar.cc/150?img=${_students.length + 10}',
                      'attendance': '100%',
                      'joinDate': '${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}',
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Student added successfully')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
              child: const Text('Add Student'),
            ),
          ],
        );
      },
    );
  }

  void _showEditStudentDialog(BuildContext context, Map<String, dynamic> student) {
    final TextEditingController nameController = TextEditingController(text: student['name']);
    final TextEditingController emailController = TextEditingController(text: student['email']);
    final TextEditingController phoneController = TextEditingController(text: student['phone']);
    String selectedGrade = student['grade'];
    String selectedSection = student['section'];
    String selectedStatus = student['status'];
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
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
                            child: Text(grade),
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
                        value: selectedSection,
                        decoration: const InputDecoration(
                          labelText: 'Section',
                          border: OutlineInputBorder(),
                        ),
                        items: ['A', 'B', 'C', 'D'].map((section) {
                          return DropdownMenuItem(
                            value: section,
                            child: Text(section),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedSection = value!;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
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
                // Update student logic
                if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                  setState(() {
                    final index = _students.indexWhere((s) => s['id'] == student['id']);
                    if (index != -1) {
                      _students[index] = {
                        ..._students[index],
                        'name': nameController.text,
                        'grade': selectedGrade,
                        'section': selectedSection,
                        'email': emailController.text,
                        'phone': phoneController.text,
                        'status': selectedStatus,
                      };
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Student updated successfully')),
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
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text('Are you sure you want to delete ${student['name']}?'),
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
                  _students.removeWhere((s) => s['id'] == student['id']);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Student deleted successfully')),
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

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
