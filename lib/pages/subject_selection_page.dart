import 'package:flutter/material.dart';

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
  final List<Map<String, String>> _subjects = [
    {'name': 'HISTORY', 'icon': 'assets/images/subjects/history.png'},
    {'name': 'Geography', 'icon': 'assets/images/subjects/geography.png'},
    {'name': 'psychology', 'icon': 'assets/images/subjects/psychology.png'},
    {'name': 'sociology', 'icon': 'assets/images/subjects/sociology.png'},
    {'name': 'Economics', 'icon': 'assets/images/subjects/economics.png'},
    {'name': 'ENGLISH', 'icon': 'assets/images/subjects/english.png'},
    {'name': 'संस्कृत', 'icon': 'assets/images/subjects/sanskrit.png'},
    {'name': 'Gujarati', 'icon': 'assets/images/subjects/gujarati.png'},
    {'name': 'Computer', 'icon': 'assets/images/subjects/computer.png'},
    {'name': 'हिंदी', 'icon': 'assets/images/subjects/hindi.png'},
  ];

  Widget _buildSubjectItem(Map<String, String> subject) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 32,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                subject['icon']!,
                width: 32,
                height: 32,
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
          const SizedBox(height: 8),
          Text(
            subject['name']!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Active Pro Version',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.yellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Subjects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              children: _subjects.map((subject) => _buildSubjectItem(subject)).toList(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_outlined, 'Home', true),
                  _buildNavItem(Icons.school, 'My Purchase', false),
                  _buildNavItem(Icons.person_outline, 'Profile', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionChip(String label, String value, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label\n$value',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey.shade600,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.blue : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
