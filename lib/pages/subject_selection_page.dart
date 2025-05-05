import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'subject_details_page.dart';

class SubjectSelectionPage extends StatefulWidget {
  final String selectedBoard;
  final String selectedMedium;
  final String selectedStandard;

  const SubjectSelectionPage({
    super.key,
    required this.selectedBoard,
    required this.selectedMedium,
    required this.selectedStandard,
  });

  @override
  State<SubjectSelectionPage> createState() => _SubjectSelectionPageState();
}

class _SubjectSelectionPageState extends State<SubjectSelectionPage> {
  // Filter options
  bool _showFilterOptions = false;
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Languages', 'Sciences', 'Humanities', 'Others'];

  final List<Map<String, dynamic>> _allSubjects = [
    // Humanities
    {'name': 'History', 'icon': Icons.history_edu, 'color': Color(0xFFF97B22), 'category': 'Humanities'},
    {'name': 'Geography', 'icon': Icons.public, 'color': Color(0xFF1A5D1A), 'category': 'Humanities'},
    {'name': 'Psychology', 'icon': Icons.psychology, 'color': Color(0xFF7A4069), 'category': 'Humanities'},
    {'name': 'Sociology', 'icon': Icons.groups, 'color': Color(0xFF1D5B79), 'category': 'Humanities'},
    {'name': 'Economics', 'icon': Icons.trending_up, 'color': Color(0xFF6C3428), 'category': 'Humanities'},
    
    // Languages
    {'name': 'English', 'icon': Icons.menu_book, 'color': Color(0xFF0F2167), 'category': 'Languages'},
    {'name': 'Sanskrit', 'icon': Icons.translate, 'color': Color(0xFFFF6969), 'category': 'Languages'},
    {'name': 'Gujarati', 'icon': Icons.language, 'color': Color(0xFF5C8374), 'category': 'Languages'},
    {'name': 'Hindi', 'icon': Icons.text_fields, 'color': Color(0xFFAF2655), 'category': 'Languages'},
    
    // Sciences
    {'name': 'Science', 'icon': Icons.science, 'color': Color(0xFF3559E0), 'category': 'Sciences'},
    {'name': 'Maths', 'icon': Icons.calculate, 'color': Color(0xFF1D5B79), 'category': 'Sciences'},
    
    // Others
    {'name': 'Computer', 'icon': Icons.computer, 'color': Color(0xFF2D4356), 'category': 'Others'},
  ];
  
  late List<Map<String, dynamic>> _subjects;
  int? _selectedSubjectIndex;

  @override
  void initState() {
    super.initState();
    // Initialize with all subjects
    _subjects = List.from(_allSubjects);
  }

  void _filterSubjects(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _subjects = List.from(_allSubjects);
      } else {
        _subjects = _allSubjects.where((subject) => subject['category'] == category).toList();
      }
      _showFilterOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar with selection chips
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppTheme.textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildSelectionChip(
                            'Board',
                            widget.selectedBoard,
                            onTap: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          _buildSelectionChip(
                            'Medium',
                            widget.selectedMedium,
                            onTap: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          _buildSelectionChip(
                            'Standard',
                            widget.selectedStandard,
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Pro version banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1E293B),
                    AppTheme.primaryColor.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Pro Version',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Access all premium features',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppTheme.accentColor, AppTheme.accentColor.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            
            // Subjects header with filter
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Text(
                    'Subjects',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showFilterOptions = !_showFilterOptions;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _showFilterOptions
                            ? AppTheme.accentColor.withOpacity(0.2)
                            : AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.filter_list,
                            size: 16,
                            color: _showFilterOptions
                                ? AppTheme.accentColor
                                : AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _showFilterOptions
                                  ? AppTheme.accentColor
                                  : AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Filter options
            if (_showFilterOptions)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        return GestureDetector(
                          onTap: () => _filterSubjects(category),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.accentColor
                                  : AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            
            // Subjects grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  final subject = _subjects[index];
                  final bool isSelected = _selectedSubjectIndex == index;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSubjectIndex = index;
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? (subject['color'] as Color).withOpacity(0.3)
                                : Colors.grey.shade200,
                            blurRadius: isSelected ? 8 : 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: isSelected
                            ? Border.all(
                                color: subject['color'] as Color,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: (subject['color'] as Color).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              subject['icon'] as IconData,
                              color: subject['color'] as Color,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            subject['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionChip(String label, String value, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.subtitleColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
