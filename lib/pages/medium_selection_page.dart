import 'package:flutter/material.dart';
import 'standard_selection_page.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What is your sub board & standard?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the sub-board and standard that you teach frequently.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Choose Your Medium',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: mediumOptions.map((medium) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMedium = medium['value'];
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.transparent,
                            ),
                            child: Text(
                              medium['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
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
                    backgroundColor: const Color(0xFF6B7280),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
