import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Animation controllers and animations for various effects
  late final AnimationController _fadeController;
  late final AnimationController _slideController;
  late final AnimationController _scaleController;
  late final AnimationController _rotateController;
  late final AnimationController _pulseController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;
  late final Animation<double> _pulseAnimation;

  // State variables for UI interactions
  bool _isPasswordVisible = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  String? _emailError;


  // Initialize the animations in initState
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();

    _emailController.addListener(() {
      final email = _emailController.text.trim();
      final isValid = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
      setState(() {
        _emailError = email.isEmpty || isValid ? null : 'Invalid email address';
      });
    });
  }

  // Initialize all animation controllers and animations
  void _initializeAnimations() {
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _rotateController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut));
    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  // Start the animations
  void _startAnimations() {
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
    _rotateController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B35),
              Color(0xFFFF8E53),
              Color(0xFFFFB366),
              Color(0xFFFFC679),
            ],
          ),
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: _authListener,
          builder: (context, state) {
            if (state is AuthLoading) {
              return _buildLoadingScreen();
            } else {
              return _buildSignupForm();
            }
          },
        ),
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is Authenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (state is Unauthenticated && state.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message!),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 29, 28, 28),
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Creating your account...',
            style: TextStyle(
              color: Color.fromARGB(255, 23, 22, 22),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildAnimatedLogo(),
                const SizedBox(height: 40),
                _buildWelcomeText(),
                const SizedBox(height: 50),
                _buildSignupCard(),
                const SizedBox(height: 30),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: _rotateAnimation,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(child: Text('🍩', style: TextStyle(fontSize: 50))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        const Text(
          'Join Cursteez!',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 29, 28, 28)),
        ),
        const SizedBox(height: 8),
        const Text(
          'Create your sweet account',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(179, 24, 23, 23)),
        ),
        const SizedBox(height: 12),
        Container(
          width: 50,
          height: 3,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 53, 51, 51).withOpacity(0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildAnimatedTextField(
            controller: _emailController,
            label: 'Email Address',
            icon: Icons.email_outlined,
            isFocused: _isEmailFocused,
            errorText: _emailError,
            onFocusChange: (focused) => setState(() => _isEmailFocused = focused),
          ),
          const SizedBox(height: 20),
          _buildAnimatedTextField(
            controller: _passwordController,
            label: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
            isFocused: _isPasswordFocused,
            onFocusChange: (focused) => setState(() => _isPasswordFocused = focused),
          ),
          const SizedBox(height: 20),
          _buildSignupButton(),
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isFocused,
    required Function(bool) onFocusChange,
    String? errorText,
    bool isPassword = false,
  }) {
    return Focus(
      onFocusChange: onFocusChange,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFocused ? const Color(0xFFFF6B35) : Colors.grey[300]!,
            width: isFocused ? 2 : 1,
          ),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF6B35).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: TextField(
          controller: controller,
          obscureText: isPassword && !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: label,
            errorText: errorText,
            labelStyle: TextStyle(
              color: isFocused ? const Color(0xFFFF6B35) : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(icon, color: isFocused ? const Color(0xFFFF6B35) : Colors.grey[600]),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600]),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final email = _emailController.text.trim();
            final password = _passwordController.text.trim();

            if (email.isEmpty || password.isEmpty || _emailError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Please enter a valid email and password.'),
                  backgroundColor: Colors.red[400],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
              return;
            }

            context.read<AuthBloc>().add(SignupRequested(email, password));
          },
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account? ', style: TextStyle(color: Color.fromARGB(179, 19, 19, 19), fontSize: 16)),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Color.fromARGB(255, 12, 12, 12),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Color.fromARGB(255, 57, 56, 56),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
