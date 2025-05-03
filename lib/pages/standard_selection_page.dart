import 'package:flutter/material.dart';
import 'subject_selection_page.dart';

class StandardSelectionPage extends StatefulWidget {
  final String selectedBoard;
  final String selectedMedium;

  const StandardSelectionPage({
    super.key,
    required this.selectedBoard,
    required this.selectedMedium,
  });

  @override
  State<StandardSelectionPage> createState() => _StandardSelectionPageState();
}

class _StandardSelectionPageState extends State<StandardSelectionPage> {
  String? _selectedStandard;

  final Map<String, List<String>> _standards = {
    'Primary School': [
      'STD 1',
      'STD 2',
      'STD 3',
      'STD 4',
      'STD 5',
      'STD 6',
      'STD 7',
      'STD 8',
    ],
    'Secondary School': [
      'STD 9',
      'STD 10',
    ],
    'Higher School': [
      'STD 11 Science',
      'STD 11 Commerce',
      'STD 11 Arts',
      'STD 12 Science',
      'STD 12 Commerce',
      'STD 12 Arts',
    ],
  };

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStandardOption(String standard) {
    final isSelected = _selectedStandard == standard;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStandard = standard;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(24),
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        ),
        child: Text(
          standard,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Standard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _standards.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(entry.key),
                          if (entry.key == 'Primary School' ||
                              entry.key == 'Secondary School')
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: entry.value
                                  .map((std) => _buildStandardOption(std))
                                  .toList(),
                            )
                          else
                            Column(
                              children: entry.value.map((std) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: _buildStandardOption(std),
                                  ),
                                );
                              }).toList(),
                            ),
                          if (entry.key != 'Higher School')
                            Container(
                              height: 1,
                              color: Colors.grey.shade200,
                              margin: const EdgeInsets.symmetric(vertical: 24),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedStandard == null
                      ? null
                      : () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectSelectionPage(
                                selectedBoard: widget.selectedBoard,
                                selectedMedium: widget.selectedMedium,
                                selectedStandard: _selectedStandard!,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B7280),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
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
