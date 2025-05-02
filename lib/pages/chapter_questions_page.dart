import 'package:flutter/material.dart';

class ChapterQuestionsPage extends StatelessWidget {
  final String chapterTitle;
  final String subjectName;
  final int chapterNumber;

  const ChapterQuestionsPage({
    super.key,
    required this.chapterTitle,
    required this.subjectName,
    required this.chapterNumber,
  });

  Widget _buildQuestionTypeCard(String title, int marks, {bool isSection = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // TODO: Implement question type selection
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: isSection ? 18 : 16,
                      fontWeight: isSection ? FontWeight.bold : FontWeight.w500,
                      color: isSection ? Colors.black87 : Colors.black54,
                    ),
                  ),
                ),
                if (!isSection) ...[
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                  ),
                ],
              ],
            ),
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chap $chapterNumber',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              chapterTitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          _buildQuestionTypeCard('A. Match The Following. [3 Marks]', 3, isSection: true),
          _buildQuestionTypeCard('A. True-False', 0),
          _buildQuestionTypeCard('A. 1 Marks Each', 0),
          _buildQuestionTypeCard('A. Fill In The Blanks', 0),
          _buildQuestionTypeCard('A. M.C.Q', 0),
          _buildQuestionTypeCard('B. 2 Marks Each', 0, isSection: true),
          _buildQuestionTypeCard('C. 3 Marks Each', 0, isSection: true),
          _buildQuestionTypeCard('D. 4 Marks Each', 0, isSection: true),
        ],
      ),
    );
  }
}
