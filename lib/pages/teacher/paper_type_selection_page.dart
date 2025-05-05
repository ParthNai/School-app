import 'package:flutter/material.dart';

class PaperTypeSelectionPage extends StatelessWidget {
  final Map<String, dynamic>? course;
  
  const PaperTypeSelectionPage({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Select paper type or chapter',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Paper Types
              _buildPaperTypeCard(
                context,
                'Regular Paper',
                'Create a standard exam paper',
                Icons.description,
                Colors.blue,
                () {
                  _navigateToCreatePaper(context, 'regular', course);
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildPaperTypeCard(
                context,
                'Custom Paper',
                'Create a custom exam paper',
                Icons.edit_document,
                Colors.purple,
                () {
                  _navigateToCreatePaper(context, 'custom', course);
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildPaperTypeCard(
                context,
                'Chapter-wise Paper',
                'Create a paper for specific chapters',
                Icons.menu_book,
                Colors.green,
                () {
                  _navigateToCreatePaper(context, 'chapter', course);
                },
              ),
              
              const SizedBox(height: 32),
              
              // Chapters Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Chapters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '8',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // View all chapters
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Chapter list would go here
              // For now, showing a placeholder
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'No chapters available for this course',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navigateToCreatePaper(context, 'regular', course);
        },
        backgroundColor: Colors.orange,
        label: const Text('Create Paper'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPaperTypeCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCreatePaper(BuildContext context, String paperType, Map<String, dynamic>? course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DummyCreatePaperPage(paperType: paperType, course: course),
      ),
    );
  }
}

// Placeholder for the actual create paper page
class DummyCreatePaperPage extends StatelessWidget {
  final String paperType;
  final Map<String, dynamic>? course;

  const DummyCreatePaperPage({
    super.key,
    required this.paperType,
    this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Create $paperType Paper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create $paperType Paper',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            if (course != null)
              Text(
                'For course: ${course!['name']}',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
