import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'board_selection_page.dart';
import 'registration_page.dart';
import '../theme/app_theme.dart';
import 'admin/admin_dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showOtpField = false;
  bool _isLoading = false;
  String _selectedUserType = 'student'; // Default to student login
  bool _showPasswordLogin = false;
  
  // Animation controllers - initialized in initState to prevent LateInitializationError
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controllers
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    ));
    
    // Start animation
    _animationController?.forward();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  void _verifyPhoneNumber() {
    if (_phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _showOtpField = true;
      });
      // Start animation for OTP field
      _animationController?.reset();
      _animationController?.forward();
    });
  }

  void _verifyOtp() {
    setState(() {
      _isLoading = true;
    });

    // Get OTP from controllers
    String otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
      return;
    }

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BoardSelectionPage(),
        ),
      );
    });
  }

  void _loginWithEmailPassword() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      // Handle different navigation based on user type
      if (_selectedUserType == 'admin') {
        // For admin users, navigate to the admin dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminDashboardPage(),
          ),
        );
      } else {
        // For students and teachers, navigate to the board selection page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BoardSelectionPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _showOtpField || _showPasswordLogin
          ? AppBar(
              backgroundColor: AppTheme.backgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppTheme.textColor),
                onPressed: () {
                  setState(() {
                    _showOtpField = false;
                    _showPasswordLogin = false;
                    for (var controller in _otpControllers) {
                      controller.clear();
                    }
                    // Restart animations
                    _animationController?.reset();
                    _animationController?.forward();
                  });
                },
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: screenSize.height - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Logo or app icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withOpacity(0.8),
                            AppTheme.secondaryColor.withOpacity(0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Welcome text
                  Center(
                    child: Text(
                      _showOtpField 
                          ? 'Verification' 
                          : _showPasswordLogin 
                              ? '${_selectedUserType.substring(0, 1).toUpperCase()}${_selectedUserType.substring(1)} Login' 
                              : 'Welcome Back',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      _showOtpField 
                          ? 'Enter the verification code we sent you' 
                          : _showPasswordLogin
                              ? 'Enter your credentials to continue'
                              : 'Revolutionize your writing\nEmpowering education, anytime, anywhere',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // User type selection (only show on initial screen)
                  if (!_showOtpField && !_showPasswordLogin)
                    FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login as',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildUserTypeOption('Student', 'student', Icons.person),
                                const SizedBox(width: 12),
                                _buildUserTypeOption('Teacher', 'teacher', Icons.school),
                                const SizedBox(width: 12),
                                _buildUserTypeOption('Admin', 'admin', Icons.admin_panel_settings),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  
                  // Phone input field with improved design (only for students)
                  if (!_showOtpField && !_showPasswordLogin && _selectedUserType == 'student') 
                    FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: AppTheme.primaryColor,
                              ),
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  
                  // Email and password fields (for teachers and admins)
                  if (_showPasswordLogin)
                    FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: AppTheme.primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: AppTheme.primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Handle forgot password
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: AppTheme.accentColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  // OTP verification fields
                  if (_showOtpField)
                    FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                4,
                                (index) => SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.secondaryColor.withOpacity(0.1),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      controller: _otpControllers[index],
                                      focusNode: _otpFocusNodes[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800,
                                      ),
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1 && index < 3) {
                                          _otpFocusNodes[index + 1].requestFocus();
                                        }
                                        if (value.isEmpty && index > 0) {
                                          _otpFocusNodes[index - 1].requestFocus();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  _verifyPhoneNumber();
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Didn\'t get code? ',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'Resend OTP',
                                        style: TextStyle(
                                          color: AppTheme.accentColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  const SizedBox(height: 40),
                  // Continue/Verify button with improved design
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentColor.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_showOtpField) {
                                String otp = _otpControllers.map((c) => c.text).join();
                                if (otp.length == 4) {
                                  _verifyOtp();
                                }
                              } else if (_showPasswordLogin) {
                                _loginWithEmailPassword();
                              } else {
                                if (_selectedUserType == 'student') {
                                  if (_phoneController.text.length == 10) {
                                    _verifyPhoneNumber();
                                  }
                                } else {
                                  // For teacher and admin, show email/password form
                                  setState(() {
                                    _showPasswordLogin = true;
                                    // Restart animations
                                    _animationController?.reset();
                                    _animationController?.forward();
                                  });
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _showOtpField
                                  ? 'Verify'
                                  : _showPasswordLogin
                                      ? 'Login'
                                      : 'Continue',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const Spacer(),
                  // Registration option (for students and teachers)
                  if (!_showOtpField && !_showPasswordLogin && (_selectedUserType == 'student' || _selectedUserType == 'teacher'))
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(
                                phoneNumber: _selectedUserType == 'student' ? _phoneController.text : '',
                              ),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeOption(String title, String value, IconData icon) {
    final bool isSelected = _selectedUserType == value;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedUserType = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
