import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TeacherSettingsPage extends StatefulWidget {
  const TeacherSettingsPage({super.key});

  @override
  State<TeacherSettingsPage> createState() => _TeacherSettingsPageState();
}

class _TeacherSettingsPageState extends State<TeacherSettingsPage> {
  // Profile settings
  final TextEditingController _nameController = TextEditingController(text: 'Dr. Robert Johnson');
  final TextEditingController _emailController = TextEditingController(text: 'robert.johnson@horizonschool.edu');
  final TextEditingController _phoneController = TextEditingController(text: '+1 (555) 987-6543');
  final TextEditingController _bioController = TextEditingController(
    text: 'Mathematics teacher with over 15 years of experience. Specialized in advanced calculus and statistics.',
  );
  
  // Notification settings
  bool _emailNotifications = true;
  bool _smsNotifications = true;
  bool _appNotifications = true;
  bool _attendanceAlerts = true;
  bool _performanceAlerts = true;
  bool _assignmentReminders = true;
  
  // Privacy settings
  bool _showContactInfo = true;
  bool _showProfilePicture = true;
  bool _allowMessaging = true;
  
  // Appearance settings
  String _selectedTheme = 'System Default';
  String _selectedFontSize = 'Medium';
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Categories
            SizedBox(
              width: 200,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      _buildSettingsCategoryItem(
                        'Profile',
                        Icons.person,
                        true,
                      ),
                      _buildSettingsCategoryItem(
                        'Notifications',
                        Icons.notifications,
                        false,
                      ),
                      _buildSettingsCategoryItem(
                        'Privacy',
                        Icons.privacy_tip,
                        false,
                      ),
                      _buildSettingsCategoryItem(
                        'Appearance',
                        Icons.color_lens,
                        false,
                      ),
                      _buildSettingsCategoryItem(
                        'Security',
                        Icons.security,
                        false,
                      ),
                      _buildSettingsCategoryItem(
                        'Help & Support',
                        Icons.help,
                        false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 24),
            
            // Settings Content
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Settings
                      const Text(
                        'Profile Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Picture
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=8'),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        size: 16,
                                        color: AppTheme.primaryColor,
                                      ),
                                      onPressed: () {
                                        // Change profile picture
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Change profile picture
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Change Picture'),
                              ),
                            ],
                          ),
                          
                          const SizedBox(width: 32),
                          
                          // Profile Form
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Full Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _phoneController,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _bioController,
                                  decoration: const InputDecoration(
                                    labelText: 'Bio',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Notification Settings
                      const Text(
                        'Notification Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Notification Channels',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildSwitchTile(
                                  'Email Notifications',
                                  _emailNotifications,
                                  (value) {
                                    setState(() {
                                      _emailNotifications = value;
                                    });
                                  },
                                ),
                                _buildSwitchTile(
                                  'SMS Notifications',
                                  _smsNotifications,
                                  (value) {
                                    setState(() {
                                      _smsNotifications = value;
                                    });
                                  },
                                ),
                                _buildSwitchTile(
                                  'App Notifications',
                                  _appNotifications,
                                  (value) {
                                    setState(() {
                                      _appNotifications = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Notification Types',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildSwitchTile(
                                  'Attendance Alerts',
                                  _attendanceAlerts,
                                  (value) {
                                    setState(() {
                                      _attendanceAlerts = value;
                                    });
                                  },
                                ),
                                _buildSwitchTile(
                                  'Performance Alerts',
                                  _performanceAlerts,
                                  (value) {
                                    setState(() {
                                      _performanceAlerts = value;
                                    });
                                  },
                                ),
                                _buildSwitchTile(
                                  'Assignment Reminders',
                                  _assignmentReminders,
                                  (value) {
                                    setState(() {
                                      _assignmentReminders = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Privacy Settings
                      const Text(
                        'Privacy Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSwitchTile(
                        'Show Contact Information to Students',
                        _showContactInfo,
                        (value) {
                          setState(() {
                            _showContactInfo = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        'Show Profile Picture to Students',
                        _showProfilePicture,
                        (value) {
                          setState(() {
                            _showProfilePicture = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        'Allow Direct Messaging from Students',
                        _allowMessaging,
                        (value) {
                          setState(() {
                            _allowMessaging = value;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Appearance Settings
                      const Text(
                        'Appearance Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Theme'),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedTheme,
                                      isExpanded: true,
                                      items: const [
                                        DropdownMenuItem(value: 'System Default', child: Text('System Default')),
                                        DropdownMenuItem(value: 'Light', child: Text('Light')),
                                        DropdownMenuItem(value: 'Dark', child: Text('Dark')),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedTheme = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Font Size'),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedFontSize,
                                      isExpanded: true,
                                      items: const [
                                        DropdownMenuItem(value: 'Small', child: Text('Small')),
                                        DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                                        DropdownMenuItem(value: 'Large', child: Text('Large')),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedFontSize = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Save Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // Reset settings
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Reset'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Save settings
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Settings saved successfully')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Save Changes'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCategoryItem(String title, IconData icon, bool isSelected) {
    return InkWell(
      onTap: () {
        // Change settings category
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppTheme.primaryColor : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryColor : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}
