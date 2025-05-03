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
    {'name': 'Social Science', 'icon': 'assets/images/subjects/globe.png'},
    {'name': 'Maths', 'icon': 'assets/images/subjects/ruler.png'},
    {'name': 'ENGLISH', 'icon': 'assets/images/subjects/books.png'},
    {'name': 'Science', 'icon': 'assets/images/subjects/microscope.png'},
    {'name': 'Gujarati', 'icon': 'assets/images/subjects/book.png'},
    {'name': 'Sanskrit', 'icon': 'assets/images/subjects/scroll.png'},
    {'name': 'Hindi', 'icon': 'assets/images/subjects/pencil.png'},
    {'name': 'Computer', 'icon': 'assets/images/subjects/laptop.png'},
  ];

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return InkWell(
      onTap: () {
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
      child: AppAnimations.scaleIn(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(
                    subject['icon'],
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.school,
                        size: 24,
                        color: Colors.grey.shade600,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                subject['name'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: AppAnimations.fadeSlideInFromBottom(
          child: Text(
            'Curriculum',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppTheme.textColor,
            ),
          ),
          duration: AppAnimations.fast,
        ),
        leading: AppAnimations.scaleIn(
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          duration: AppAnimations.fast,
        ),
        actions: [
          AppAnimations.scaleIn(
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            duration: AppAnimations.fast,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _subjects.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return AppAnimations.fadeSlideInFromBottom(
                  duration: Duration(milliseconds: 800 + (index * 100)),
                  child: _buildSubjectCard(_subjects[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
