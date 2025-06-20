import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;
  const SplashScreen({super.key, required this.nextRoute});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late AnimationController _logoController;
  late AnimationController _particleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers with refined timing
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Setup sophisticated animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoRotation = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // Start animation sequence with precise timing
    _startAnimations();

    // Navigate to next screen after optimal duration
    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, widget.nextRoute);
      }
    });
  }

  void _startAnimations() async {
    // Staggered animation sequence for professional feel
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    _rotateController.repeat();
    _particleController.repeat();

    await Future.delayed(const Duration(milliseconds: 400));
    _logoController.forward();
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    _logoController.dispose();
    _particleController.dispose();
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
        child: Stack(
          children: [
            // Advanced floating particles system
            ...List.generate(15, (index) => _buildSophisticatedParticle(index)),

            // Main content with refined animations
            SafeArea(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Sophisticated animated logo
                      _buildAdvancedLogo(),

                      const SizedBox(height: 50),

                      // Enhanced app branding
                      SlideTransition(
                        position: _slideAnimation,
                        child: _buildBrandingSection(),
                      ),

                      const SizedBox(height: 80),

                      // Premium loading indicator
                      _buildLoadingIndicator(),
                    ],
                  ),
                ),
              ),
            ),

            // Elegant bottom section
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedLogo() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating ring
          RotationTransition(
            turns: _rotateAnimation,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Middle pulsing layer
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          // Core logo container with new bounce and glow animation
          AnimatedBuilder(
            animation: _logoController,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(
                child: Text('🍩', style: TextStyle(fontSize: 45)),
              ),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -10 * (1 - _logoScale.value)),
                child: Transform.scale(
                  scale: _logoScale.value * (1 + 0.1 * (_pulseAnimation.value - 1)),
                  child: Transform.rotate(
                    angle: _logoRotation.value,
                    child: child,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBrandingSection() {
    return Column(
      children: [
        // App name with sophisticated styling
        ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [Colors.white, Colors.white70, Colors.white],
                stops: [0.0, 0.5, 1.0],
              ).createShader(bounds),
          child: const Text(
            'Curteeze',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 31, 31, 31),
              letterSpacing: -1.2,
              shadows: [
                Shadow(
                  color: Color.fromARGB(66, 29, 28, 28),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: const Text(
            'Your Sweet Social Experience',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 20, 20, 20),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Decorative line
        AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return Container(
              width: 60 * _fadeAnimation.value,
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color.fromARGB(255, 18, 17, 17).withOpacity(0.9),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
          ),
        ),
        child: Column(
          children: [
            Text(
              'Donuts and Love',
              style: TextStyle(
                color: const Color.fromARGB(255, 48, 46, 46).withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          
          ],
        ),
      ),
    );
  }

  Widget _buildSophisticatedParticle(int index) {
    final random = (index * 1337) % 100;
    final size = 3.0 + (random % 6);
    final left = (random * 3.7) % (MediaQuery.of(context).size.width - 20);
    final animationDelay = (random * 15) % 2000;
    final floatDuration = 3000 + (random * 10) % 2000;

    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        final progress =
            ((_particleController.value * floatDuration + animationDelay) %
                floatDuration) /
            floatDuration;
        final top = MediaQuery.of(context).size.height * (1.0 + progress) - 100;
        final opacity =
            progress < 0.1
                ? progress / 0.1
                : progress > 0.9
                ? (1.0 - progress) / 0.1
                : 1.0;

        return Positioned(
          left: left + (progress * 20 - 10), // Slight horizontal drift
          top: top,
          child: Opacity(
            opacity: opacity * 0.7,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: size,
                    spreadRadius: size / 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}