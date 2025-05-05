import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import 'subject_details_page.dart';

class CurriculumPage extends StatefulWidget {
  final String selectedBoard;
  final String selectedMedium;
  final String selectedStandard;

  const CurriculumPage({
    super.key,
    required this.selectedBoard,
    required this.selectedMedium,
    required this.selectedStandard,
  });

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _subjects = [
    {'name': 'Social Science', 'icon': Icons.public},
    {'name': 'Maths', 'icon': Icons.calculate},
    {'name': 'ENGLISH', 'icon': Icons.menu_book},
    {'name': 'Science', 'icon': Icons.science},
    {'name': 'Gujarati', 'icon': Icons.translate},
    {'name': 'Sanskrit', 'icon': Icons.history_edu},
    {'name': 'Hindi', 'icon': Icons.language},
    {'name': 'Computer', 'icon': Icons.computer},
  ];

  Widget _buildSubjectCard(Map<String, dynamic> subject, int index) {
    bool isSelected = _selectedIndex == index;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailsPage(
              subjectName: subject['name'],
              subjectIcon: subject['icon'],
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppTheme.primaryColor.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor.withOpacity(0.2) : AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                subject['icon'],
                size: 30,
                color: isSelected ? AppTheme.primaryColor : Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to select questions',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create a Curriculum'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Create a curriculum',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select the subjects and capture for the exam paper.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(widget.selectedBoard, Icons.school),
                    _buildInfoChip(widget.selectedMedium, Icons.language),
                    _buildInfoChip(widget.selectedStandard, Icons.grade),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Select Subject',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                return _buildSubjectCard(_subjects[index], index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle curriculum creation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Curriculum created successfully!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: AppTheme.accentColor,
        label: const Text('Create Paper'),
        icon: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
