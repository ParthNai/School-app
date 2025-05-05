import 'package:flutter/material.dart';
import 'board_selection_page.dart';
import 'curriculum_page.dart';

class RegistrationPage extends StatefulWidget {
  final String phoneNumber;

  const RegistrationPage({super.key, required this.phoneNumber});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  String? _selectedRole;
  bool _isLoading = false;
  bool _showTeacherFields = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _qualificationController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _handleRegistration() {
    // Basic validation
    if (_nameController.text.isEmpty || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    
    // Additional validation for teacher fields
    if (_selectedRole == 'Teacher' && (
        _emailController.text.isEmpty ||
        _qualificationController.text.isEmpty ||
        _experienceController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all teacher information fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate registration process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      if (_selectedRole == 'Teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BoardSelectionPage()),
        );
      } else if (_selectedRole == 'Student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CurriculumPage(
              selectedBoard: 'Gujarat Board',
              selectedMedium: 'GSEB - English',
              selectedStandard: 'STD 10',
            ),
          ),
        );
      } else {
        // Handle Parents role
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context); // Go back to login page
      }
    });
  }

  Widget _buildRoleOption(String role, String iconPath) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
          _showTeacherFields = role == 'Teacher';
        });
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    role == 'Student' ? Icons.school :
                    role == 'Teacher' ? Icons.person :
                    Icons.family_restroom,
                    size: 32,
                    color: isSelected ? Colors.blue : Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey.shade700,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
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
                'Create an account as',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: TextField(
                  enabled: _selectedRole != 'Teacher',
                  controller: widget.phoneNumber.isNotEmpty 
                      ? TextEditingController(text: widget.phoneNumber)
                      : _emailController,
                  decoration: InputDecoration(
                    hintText: _selectedRole == 'Teacher' ? 'Email Address' : 'Phone Number',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  keyboardType: _selectedRole == 'Teacher' ? TextInputType.emailAddress : TextInputType.phone,
                ),
              ),
              
              // Teacher-specific fields
              if (_showTeacherFields) ...[                
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: TextField(
                    controller: _qualificationController,
                    decoration: const InputDecoration(
                      hintText: 'Qualification',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: TextField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      hintText: 'Years of Experience',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
              const SizedBox(height: 32),
              const Text(
                'Role',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRoleOption('Student', 'assets/images/icons/student.png'),
                  _buildRoleOption('Teacher', 'assets/images/icons/teacher.png'),
                  _buildRoleOption('Parents', 'assets/images/icons/parents.png'),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      children: [
                        const TextSpan(text: 'By clicking below, you are accepting our '),
                        TextSpan(
                          text: 'Terms & Condition',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegistration,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B7280),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Agree and Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
