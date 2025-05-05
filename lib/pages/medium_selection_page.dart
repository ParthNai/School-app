import 'package:flutter/material.dart';
import 'standard_selection_page.dart';
import '../theme/app_theme.dart';

class MediumSelectionPage extends StatefulWidget {
  final String selectedBoard;

  const MediumSelectionPage({
    super.key,
    required this.selectedBoard,
  });

  @override
  State<MediumSelectionPage> createState() => _MediumSelectionPageState();
}

class _MediumSelectionPageState extends State<MediumSelectionPage> {
  String? _selectedMedium;

  List<Map<String, String>> getMediumOptions() {
    if (widget.selectedBoard == 'Gujarat Board') {
      return [
        {'name': 'GSEB - English Medium', 'value': 'english'},
        {'name': 'GSEB - ગુજરાતી માધ્યમ', 'value': 'gujarati'},
        {'name': 'GSEB - हिंदी माध्यम', 'value': 'hindi'},
      ];
    }
    // Add more board-specific medium options here
    return [
      {'name': 'English Medium', 'value': 'english'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediumOptions = getMediumOptions();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Select Medium',
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
            height: 100,
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
                  widget.selectedBoard,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose your teaching medium',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Medium options list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is your sub board & standard?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose the sub-board and standard that you teach frequently.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Choose Your Medium',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mediumOptions.length,
                      itemBuilder: (context, index) {
                        final medium = mediumOptions[index];
                        final bool isSelected = _selectedMedium == medium['value'];
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: isSelected ? 2 : 1,
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
                                _selectedMedium = medium['value'];
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isSelected 
                                          ? AppTheme.accentColor.withOpacity(0.1)
                                          : AppTheme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.language,
                                      size: 20,
                                      color: isSelected 
                                          ? AppTheme.accentColor
                                          : AppTheme.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      medium['name']!,
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
                ],
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
                onPressed: _selectedMedium == null
                    ? null
                    : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StandardSelectionPage(
                              selectedBoard: widget.selectedBoard,
                              selectedMedium: _selectedMedium!,
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
                  _selectedMedium == null ? 'Select a Medium' : 'Continue',
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
