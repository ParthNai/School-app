import 'package:flutter/material.dart';
import 'regular_paper_page.dart';

class SubjectDetailsPage extends StatelessWidget {
  final String subjectName;
  final String subjectIcon;

  static final Map<String, List<Map<String, dynamic>>> _subjectChapters = {
    'Social Science': [
      {'number': 1, 'title': 'HERITAGE OF INDIA', 'isLocked': false},
      {'number': 2, 'title': 'CULTURAL HERITAGE OF INDIA: TRADITIONAL HANDICRAFT AND FINE ARTS', 'isLocked': false},
      {'number': 3, 'title': 'CULTURAL HERITAGE OF INDIA: SCULPTURE AND ARCHITECTURE', 'isLocked': true},
      {'number': 4, 'title': 'LITERARY HERITAGE OF INDIA', 'isLocked': true},
      {'number': 5, 'title': 'INDIA\'S HERITAGE OF SCIENCE AND TECHNOLOGY', 'isLocked': true},
      {'number': 6, 'title': 'PLACES OF INDIAN CULTURAL HERITAGE', 'isLocked': true},
      {'number': 7, 'title': 'PRESERVATION OF OUR HERITAGE', 'isLocked': true},
    ],
    'Maths': [
      {'number': 1, 'title': 'Real Numbers', 'isLocked': false},
      {'number': 2, 'title': 'Polynomials', 'isLocked': false},
      {'number': 3, 'title': 'Coordinate Geometry', 'isLocked': true},
      {'number': 4, 'title': 'Linear Equations in Two Variables', 'isLocked': true},
    ],
    'ENGLISH': [
      {'number': 1, 'title': 'Grammar Basics', 'isLocked': false},
      {'number': 2, 'title': 'Reading Comprehension', 'isLocked': false},
      {'number': 3, 'title': 'Writing Skills', 'isLocked': true},
      {'number': 4, 'title': 'Literature', 'isLocked': true},
    ],
    'Science': [
      {'number': 1, 'title': 'Chemical Reactions', 'isLocked': false},
      {'number': 2, 'title': 'Electricity', 'isLocked': false},
      {'number': 3, 'title': 'Life Processes', 'isLocked': true},
      {'number': 4, 'title': 'Light', 'isLocked': true},
    ],
    'Gujarati': [
      {'number': 1, 'title': 'ગદ્ય', 'isLocked': false},
      {'number': 2, 'title': 'પદ્ય', 'isLocked': false},
      {'number': 3, 'title': 'વ્યાકરણ', 'isLocked': true},
      {'number': 4, 'title': 'નિબંધ', 'isLocked': true},
    ],
    'Sanskrit': [
      {'number': 1, 'title': 'शब्दरूपाणि', 'isLocked': false},
      {'number': 2, 'title': 'धातुरूपाणि', 'isLocked': false},
      {'number': 3, 'title': 'सन्धिः', 'isLocked': true},
      {'number': 4, 'title': 'समासः', 'isLocked': true},
    ],
    'Hindi': [
      {'number': 1, 'title': 'गद्य', 'isLocked': false},
      {'number': 2, 'title': 'पद्य', 'isLocked': false},
      {'number': 3, 'title': 'व्याकरण', 'isLocked': true},
      {'number': 4, 'title': 'निबंध', 'isLocked': true},
    ],
    'Computer': [
      {'number': 1, 'title': 'Introduction to Computers', 'isLocked': false},
      {'number': 2, 'title': 'Operating Systems', 'isLocked': false},
      {'number': 3, 'title': 'Programming Basics', 'isLocked': true},
      {'number': 4, 'title': 'Internet and Web', 'isLocked': true},
    ],
  };

  const SubjectDetailsPage({
    super.key,
    required this.subjectName,
    required this.subjectIcon,
  });

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'assets/images/$icon',
                width: 48,
                height: 48,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.description, color: Colors.grey.shade400),
                  );
                },
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  subjectIcon,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              subjectName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          _buildOptionCard(
            title: 'Regular Paper',
            subtitle: 'Select Question Of Your Choice',
            icon: 'regular_paper.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegularPaperPage(
                    subjectName: subjectName,
                    chapters: _subjectChapters[subjectName] ?? [],
                  ),
                ),
              );
            },
          ),
          _buildOptionCard(
            title: 'Custom Paper',
            subtitle: 'Create Papers According To Your Blue Print',
            icon: 'custom_paper.png',
            onTap: () {},
          ),
          _buildOptionCard(
            title: 'Random Paper',
            subtitle: 'Just Select No. Of Question & Create Paper',
            icon: 'random_paper.png',
            onTap: () {},
          ),
          _buildOptionCard(
            title: 'Expert Mode',
            subtitle: 'Select From Already Best Papers',
            icon: 'expert_mode.png',
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Other Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildOptionCard(
            title: 'Chapter Note',
            subtitle: 'Get Study Material, Textbook, Sample papers, Blueprints etc.',
            icon: 'chapter_note.png',
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.help_outline),
        label: const Text('How to use ?'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
