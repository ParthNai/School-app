import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'regular_paper_page.dart';

class SubjectDetailsPage extends StatelessWidget {
  final String subjectName;
  final dynamic subjectIcon;

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
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
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
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapterCard(Map<String, dynamic> chapter) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: chapter['isLocked'] ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: chapter['isLocked']
            ? BorderSide(color: Colors.grey.shade200)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: chapter['isLocked']
            ? null
            : () {
                // Handle chapter selection
              },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: chapter['isLocked']
                      ? Colors.grey.shade100
                      : AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${chapter['number']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: chapter['isLocked']
                          ? Colors.grey.shade400
                          : AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  chapter['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: chapter['isLocked']
                        ? Colors.grey.shade400
                        : AppTheme.textColor,
                  ),
                ),
              ),
              if (chapter['isLocked'])
                Icon(
                  Icons.lock,
                  size: 18,
                  color: Colors.grey.shade400,
                )
              else
                Icon(
                  Icons.check_circle,
                  size: 18,
                  color: Colors.green.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chapters =
        _subjectChapters[subjectName] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(subjectName),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildSubjectIcon(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subjectName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Select paper type or chapter',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildOptionCard(
                  title: 'Regular Paper',
                  subtitle: 'Create a standard exam paper',
                  icon: Icons.description,
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
                  subtitle: 'Create a custom exam paper',
                  icon: Icons.edit_document,
                  onTap: () {
                    // Navigate to custom paper page
                  },
                ),
                _buildOptionCard(
                  title: 'Chapter-wise Paper',
                  subtitle: 'Create a paper for specific chapters',
                  icon: Icons.menu_book,
                  onTap: () {
                    // Navigate to chapter-wise paper page
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Chapters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${chapters.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return _buildChapterCard(chapters[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle paper creation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Paper created successfully!'),
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

  Widget _buildSubjectIcon() {
    IconData iconData;
    
    // Determine the appropriate icon based on subject name
    if (subjectIcon is IconData) {
      iconData = subjectIcon;
    } else {
      // Fallback icons based on subject name
      switch (subjectName) {
        case 'Social Science':
          iconData = Icons.public;
          break;
        case 'Maths':
          iconData = Icons.calculate;
          break;
        case 'ENGLISH':
          iconData = Icons.menu_book;
          break;
        case 'Science':
          iconData = Icons.science;
          break;
        case 'Gujarati':
          iconData = Icons.translate;
          break;
        case 'Sanskrit':
          iconData = Icons.history_edu;
          break;
        case 'Hindi':
          iconData = Icons.language;
          break;
        case 'Computer':
          iconData = Icons.computer;
          break;
        default:
          iconData = Icons.school;
      }
    }
    
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        iconData,
        size: 30,
        color: AppTheme.primaryColor,
      ),
    );
  }
}
