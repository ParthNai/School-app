import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ManageTeachersPage extends StatefulWidget {
  const ManageTeachersPage({super.key});

  @override
  State<ManageTeachersPage> createState() => _ManageTeachersPageState();
}

class _ManageTeachersPageState extends State<ManageTeachersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedSort = 'Name (A-Z)';
  
  // Sample teacher data
  final List<Map<String, dynamic>> _teachers = [
    {
      'id': 'TCH001',
      'name': 'Dr. Robert Johnson',
      'subject': 'Mathematics',
      'email': 'robert.johnson@example.com',
      'phone': '+1 234 567 8910',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=12',
      'experience': '10 years',
      'joinDate': '15 Jun 2020',
      'classes': ['10-A', '11-B', '12-A'],
    },
    {
      'id': 'TCH002',
      'name': 'Prof. Sarah Williams',
      'subject': 'Physics',
      'email': 'sarah.williams@example.com',
      'phone': '+1 234 567 8911',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=23',
      'experience': '8 years',
      'joinDate': '22 Aug 2021',
      'classes': ['11-A', '12-B'],
    },
    {
      'id': 'TCH003',
      'name': 'Ms. Emily Davis',
      'subject': 'English Literature',
      'email': 'emily.davis@example.com',
      'phone': '+1 234 567 8912',
      'status': 'On Leave',
      'avatar': 'https://i.pravatar.cc/150?img=20',
      'experience': '5 years',
      'joinDate': '10 Jan 2022',
      'classes': ['9-A', '10-B', '11-C'],
    },
    {
      'id': 'TCH004',
      'name': 'Mr. James Wilson',
      'subject': 'Chemistry',
      'email': 'james.wilson@example.com',
      'phone': '+1 234 567 8913',
      'status': 'Active',
      'avatar': 'https://i.pravatar.cc/150?img=15',
      'experience': '12 years',
      'joinDate': '05 Mar 2019',
      'classes': ['10-C', '11-A', '12-A'],
    },
    {
      'id': 'TCH005',
      'name': 'Dr. Lisa Brown',
      'subject': 'Biology',
      'email': 'lisa.brown@example.com',
      'phone': '+1 234 567 8914',
      'status': 'Inactive',
      'avatar': 'https://i.pravatar.cc/150?img=29',
      'experience': '7 years',
      'joinDate': '18 Jul 2020',
      'classes': ['9-B', '10-A'],
    },
  ];

  List<Map<String, dynamic>> get filteredTeachers {
    return _teachers.where((teacher) {
      // Apply search filter
      final nameMatches = teacher['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final idMatches = teacher['id'].toLowerCase().contains(_searchQuery.toLowerCase());
      final subjectMatches = teacher['subject'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Apply status filter
      final statusMatches = _selectedFilter == 'All' || teacher['status'] == _selectedFilter;
      
      return (nameMatches || idMatches || subjectMatches) && statusMatches;
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
        title: const Text('Manage Teachers'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () {
              // Export teacher data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting teacher data...')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTeacherDialog(context);
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
                          DropdownMenuItem(value: 'On Leave', child: Text('On Leave')),
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
                          DropdownMenuItem(value: 'Experience (High-Low)', child: Text('Experience (High-Low)')),
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
            
            // Teachers Table
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
                      DataColumn(label: Text('Teacher')),
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Contact')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Classes')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: filteredTeachers.map((teacher) {
                      return DataRow(
                        cells: [
                          DataCell(Text(teacher['id'])),
                          DataCell(
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(teacher['avatar']),
                                  radius: 16,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(teacher['name']),
                                    Text('${teacher['experience']} exp', 
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          DataCell(Text(teacher['subject'])),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(teacher['email'], style: const TextStyle(fontSize: 12)),
                                Text(teacher['phone'], style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(teacher['status']).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                teacher['status'],
                                style: TextStyle(
                                  color: _getStatusColor(teacher['status']),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Wrap(
                              spacing: 4,
                              children: (teacher['classes'] as List<String>).map((className) {
                                return Chip(
                                  label: Text(className, style: const TextStyle(fontSize: 10)),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                );
                              }).toList(),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () {
                                    // Edit teacher
                                    _showEditTeacherDialog(context, teacher);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 20),
                                  onPressed: () {
                                    // Delete teacher
                                    _showDeleteConfirmationDialog(context, teacher);
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'On Leave':
        return Colors.orange;
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddTeacherDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController experienceController = TextEditingController();
    
    // Class selections
    final List<String> allClasses = ['9-A', '9-B', '9-C', '10-A', '10-B', '10-C', 
                                    '11-A', '11-B', '11-C', '12-A', '12-B', '12-C'];
    final List<String> selectedClasses = [];
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Teacher'),
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
                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: experienceController,
                      decoration: const InputDecoration(
                        labelText: 'Experience (e.g., 5 years)',
                        border: OutlineInputBorder(),
                      ),
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
                    const Text('Assign Classes', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: allClasses.map((className) {
                        final isSelected = selectedClasses.contains(className);
                        return FilterChip(
                          label: Text(className),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedClasses.add(className);
                              } else {
                                selectedClasses.remove(className);
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
                    // Add new teacher logic
                    if (nameController.text.isNotEmpty && subjectController.text.isNotEmpty) {
                      this.setState(() {
                        _teachers.add({
                          'id': 'TCH00${_teachers.length + 1}',
                          'name': nameController.text,
                          'subject': subjectController.text,
                          'email': emailController.text,
                          'phone': phoneController.text,
                          'status': 'Active',
                          'avatar': 'https://i.pravatar.cc/150?img=${_teachers.length + 30}',
                          'experience': experienceController.text.isEmpty ? '1 year' : experienceController.text,
                          'joinDate': '${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}',
                          'classes': List<String>.from(selectedClasses),
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Teacher added successfully')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Add Teacher'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showEditTeacherDialog(BuildContext context, Map<String, dynamic> teacher) {
    final TextEditingController nameController = TextEditingController(text: teacher['name']);
    final TextEditingController emailController = TextEditingController(text: teacher['email']);
    final TextEditingController phoneController = TextEditingController(text: teacher['phone']);
    final TextEditingController subjectController = TextEditingController(text: teacher['subject']);
    final TextEditingController experienceController = TextEditingController(text: teacher['experience']);
    String selectedStatus = teacher['status'];
    
    // Class selections
    final List<String> allClasses = ['9-A', '9-B', '9-C', '10-A', '10-B', '10-C', 
                                    '11-A', '11-B', '11-C', '12-A', '12-B', '12-C'];
    final List<String> selectedClasses = List<String>.from(teacher['classes']);
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Teacher'),
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
                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: experienceController,
                      decoration: const InputDecoration(
                        labelText: 'Experience',
                        border: OutlineInputBorder(),
                      ),
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
                        DropdownMenuItem(value: 'On Leave', child: Text('On Leave')),
                        DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
                      ],
                      onChanged: (value) {
                        selectedStatus = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Assign Classes', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: allClasses.map((className) {
                        final isSelected = selectedClasses.contains(className);
                        return FilterChip(
                          label: Text(className),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedClasses.add(className);
                              } else {
                                selectedClasses.remove(className);
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
                    // Update teacher logic
                    if (nameController.text.isNotEmpty && subjectController.text.isNotEmpty) {
                      this.setState(() {
                        final index = _teachers.indexWhere((t) => t['id'] == teacher['id']);
                        if (index != -1) {
                          _teachers[index] = {
                            ..._teachers[index],
                            'name': nameController.text,
                            'subject': subjectController.text,
                            'email': emailController.text,
                            'phone': phoneController.text,
                            'status': selectedStatus,
                            'experience': experienceController.text,
                            'classes': List<String>.from(selectedClasses),
                          };
                        }
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Teacher updated successfully')),
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

  void _showDeleteConfirmationDialog(BuildContext context, Map<String, dynamic> teacher) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Teacher'),
          content: Text('Are you sure you want to delete ${teacher['name']}?'),
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
                  _teachers.removeWhere((t) => t['id'] == teacher['id']);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Teacher deleted successfully')),
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
