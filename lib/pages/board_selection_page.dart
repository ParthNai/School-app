import 'package:flutter/material.dart';
import 'medium_selection_page.dart';
import '../theme/app_theme.dart';

class BoardSelectionPage extends StatefulWidget {
  const BoardSelectionPage({super.key});

  @override
  State<BoardSelectionPage> createState() => _BoardSelectionPageState();
}

class _BoardSelectionPageState extends State<BoardSelectionPage> {
  String? _selectedBoard;

  final List<Map<String, dynamic>> _boards = [
    {'name': 'Gujarat Board', 'icon': Icons.school},
    {'name': 'CBSE Board', 'icon': Icons.menu_book},
    {'name': 'JEE/NEET', 'icon': Icons.science},
    {'name': 'ICSE Board', 'icon': Icons.history_edu},
    {'name': 'Maharashtra Board', 'icon': Icons.account_balance},
    {'name': 'Rajasthan Board', 'icon': Icons.architecture},
    {'name': 'Tamilnadu Board', 'icon': Icons.temple_hindu},
    {'name': 'Bihar Board', 'icon': Icons.location_city},
    {'name': 'Uttar Pradesh Board', 'icon': Icons.landscape},
    {'name': 'Haryana Board', 'icon': Icons.agriculture},
    {'name': 'Madhya Pradesh Board', 'icon': Icons.forest},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Select Board',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header with wave design
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Educational Board',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose your teaching board',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Board list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: ListView.builder(
                itemCount: _boards.length,
                itemBuilder: (context, index) {
                  final board = _boards[index];
                  final bool isSelected = _selectedBoard == board['name'];
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: isSelected ? 3 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? AppTheme.accentColor : Colors.transparent,
                        width: isSelected ? 2 : 0,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedBoard = board['name'];
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? AppTheme.accentColor.withOpacity(0.1)
                                    : AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                board['icon'],
                                size: 28,
                                color: isSelected 
                                    ? AppTheme.accentColor
                                    : AppTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                board['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected 
                                      ? FontWeight.bold 
                                      : FontWeight.w500,
                                  color: isSelected 
                                      ? AppTheme.textColor
                                      : AppTheme.textColor.withOpacity(0.8),
                                ),
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppTheme.accentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Continue button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedBoard == null
                    ? null
                    : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MediumSelectionPage(
                              selectedBoard: _selectedBoard!,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  shadowColor: AppTheme.accentColor.withOpacity(0.4),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Text(
                  _selectedBoard == null ? 'Select a Board' : 'Continue',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
