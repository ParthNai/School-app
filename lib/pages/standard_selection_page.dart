import 'package:flutter/material.dart';
import 'subject_selection_page.dart';
import '../theme/app_theme.dart';

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

class _StandardSelectionPageState extends State<StandardSelectionPage> with SingleTickerProviderStateMixin {
  String? _selectedStandard;
  late TabController _tabController;
  
  final Map<String, List<String>> _standards = {
    'Primary': [
      'STD 1',
      'STD 2',
      'STD 3',
      'STD 4',
      'STD 5',
      'STD 6',
      'STD 7',
      'STD 8',
    ],
    'Secondary': [
      'STD 9',
      'STD 10',
    ],
    'Higher': [
      'STD 11 Science',
      'STD 11 Commerce',
      'STD 11 Arts',
      'STD 12 Science',
      'STD 12 Commerce',
      'STD 12 Arts',
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Select Standard',
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
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      Text(
                        '${widget.selectedBoard} - ${widget.selectedMedium}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choose Your Standard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tab Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppTheme.accentColor,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: AppTheme.accentColor,
                    unselectedLabelColor: AppTheme.textColor.withOpacity(0.7),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    tabs: const [
                      Tab(text: 'Primary'),
                      Tab(text: 'Secondary'),
                      Tab(text: 'Higher'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPrimaryStandardsGrid(),
                _buildSecondaryStandardsGrid(),
                _buildHigherStandardsList(),
              ],
            ),
          ),
          
          // Selected standard indicator
          if (_selectedStandard != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selected: $_selectedStandard',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedStandard = null;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          // Continue button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
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
                  _selectedStandard == null ? 'Select a Standard' : 'Continue',
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

  Widget _buildPrimaryStandardsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _standards['Primary']!.length,
      itemBuilder: (context, index) {
        final standard = _standards['Primary']![index];
        return _buildStandardGridItem(standard);
      },
    );
  }

  Widget _buildSecondaryStandardsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _standards['Secondary']!.length,
      itemBuilder: (context, index) {
        final standard = _standards['Secondary']![index];
        return _buildStandardGridItem(standard);
      },
    );
  }

  Widget _buildHigherStandardsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _standards['Higher']!.length,
      itemBuilder: (context, index) {
        final standard = _standards['Higher']![index];
        return _buildStandardCard(standard);
      },
    );
  }

  Widget _buildStandardGridItem(String standard) {
    final isSelected = _selectedStandard == standard;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedStandard = standard;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.accentColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.accentColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  standard.replaceAll('STD ', ''),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              standard,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardCard(String standard) {
    final isSelected = _selectedStandard == standard;
    
    // Extract the STD number and stream
    final parts = standard.split(' ');
    final stdNumber = parts.length > 1 ? parts[1] : '';
    final stream = parts.length > 2 ? parts[2] : '';
    
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
            _selectedStandard = standard;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppTheme.accentColor
                      : AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    stdNumber,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      standard,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? AppTheme.textColor : AppTheme.textColor.withOpacity(0.8),
                      ),
                    ),
                    if (stream.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Stream: $stream',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.subtitleColor,
                          ),
                        ),
                      ),
                  ],
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
  }
}
