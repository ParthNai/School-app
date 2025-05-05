import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  // School settings
  final TextEditingController _schoolNameController = TextEditingController(text: 'Horizon International School');
  final TextEditingController _schoolAddressController = TextEditingController(text: '123 Education Street, Cityville, State, 12345');
  final TextEditingController _schoolPhoneController = TextEditingController(text: '+1 (555) 123-4567');
  final TextEditingController _schoolEmailController = TextEditingController(text: 'info@horizonschool.edu');
  
  // Notification settings
  bool _emailNotifications = true;
  bool _smsNotifications = true;
  bool _appNotifications = true;
  bool _attendanceAlerts = true;
  bool _performanceAlerts = true;
  bool _paymentReminders = true;
  
  // Security settings
  bool _twoFactorAuth = false;
  String _passwordResetPeriod = '90 days';
  
  // Academic settings
  String _gradingSystem = 'Letter Grade (A-F)';
  String _academicYear = '2024-2025';
  
  @override
  void dispose() {
    _schoolNameController.dispose();
    _schoolAddressController.dispose();
    _schoolPhoneController.dispose();
    _schoolEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // School Information Section
            _buildSectionHeader('School Information'),
            _buildTextField('School Name', _schoolNameController),
            _buildTextField('School Address', _schoolAddressController, maxLines: 2),
            _buildTextField('Phone Number', _schoolPhoneController),
            _buildTextField('Email Address', _schoolEmailController),
            
            const SizedBox(height: 32),
            
            // Notification Settings Section
            _buildSectionHeader('Notification Settings'),
            _buildSwitchTile(
              'Email Notifications',
              'Receive notifications via email',
              _emailNotifications,
              (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
            _buildSwitchTile(
              'SMS Notifications',
              'Receive notifications via SMS',
              _smsNotifications,
              (value) {
                setState(() {
                  _smsNotifications = value;
                });
              },
            ),
            _buildSwitchTile(
              'App Notifications',
              'Receive in-app notifications',
              _appNotifications,
              (value) {
                setState(() {
                  _appNotifications = value;
                });
              },
            ),
            _buildSwitchTile(
              'Attendance Alerts',
              'Get alerts for student absences',
              _attendanceAlerts,
              (value) {
                setState(() {
                  _attendanceAlerts = value;
                });
              },
            ),
            _buildSwitchTile(
              'Performance Alerts',
              'Get alerts for low student performance',
              _performanceAlerts,
              (value) {
                setState(() {
                  _performanceAlerts = value;
                });
              },
            ),
            _buildSwitchTile(
              'Payment Reminders',
              'Send payment reminders to parents',
              _paymentReminders,
              (value) {
                setState(() {
                  _paymentReminders = value;
                });
              },
            ),
            
            const SizedBox(height: 32),
            
            // Security Settings Section
            _buildSectionHeader('Security Settings'),
            _buildSwitchTile(
              'Two-Factor Authentication',
              'Require verification code for login',
              _twoFactorAuth,
              (value) {
                setState(() {
                  _twoFactorAuth = value;
                });
              },
            ),
            _buildDropdownSetting(
              'Password Reset Period',
              _passwordResetPeriod,
              ['30 days', '60 days', '90 days', '180 days', 'Never'],
              (value) {
                setState(() {
                  _passwordResetPeriod = value!;
                });
              },
            ),
            
            const SizedBox(height: 32),
            
            // Academic Settings Section
            _buildSectionHeader('Academic Settings'),
            _buildDropdownSetting(
              'Grading System',
              _gradingSystem,
              ['Letter Grade (A-F)', 'Percentage', 'GPA (0-4.0)', 'Custom'],
              (value) {
                setState(() {
                  _gradingSystem = value!;
                });
              },
            ),
            _buildDropdownSetting(
              'Academic Year',
              _academicYear,
              ['2023-2024', '2024-2025', '2025-2026'],
              (value) {
                setState(() {
                  _academicYear = value!;
                });
              },
            ),
            
            const SizedBox(height: 32),
            
            // Backup & Restore Section
            _buildSectionHeader('Backup & Restore'),
            ListTile(
              title: const Text('Backup Data'),
              subtitle: const Text('Create a backup of all school data'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating backup...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                ),
                child: const Text('Backup'),
              ),
            ),
            ListTile(
              title: const Text('Restore Data'),
              subtitle: const Text('Restore from a previous backup'),
              trailing: OutlinedButton(
                onPressed: () {
                  _showRestoreDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                ),
                child: const Text('Restore'),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings saved successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildDropdownSetting(String title, String value, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  items: options.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restore Data'),
          content: const Text(
            'Restoring from a backup will replace all current data. This action cannot be undone. Are you sure you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Restoring data...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Restore'),
            ),
          ],
        );
      },
    );
  }
}
