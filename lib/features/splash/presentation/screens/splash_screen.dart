import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    // Enable immersive mode for a premium feel
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }

  void _onStartPressed() async {
    if (_isNavigating) return;
    setState(() => _isNavigating = true);
    await _controller.reverse();
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColor.logBackColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Deep Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0A0E27), // Deepest Dark
                  Color(0xFF141936), // Slightly lighter
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 2. Exotic Ambient Glows (Aurora Effect)
          Positioned(
            top: -100,
            left: -50,
            child: _buildGlowCircle(
              color: MyColor.vibrantPurple,
              size: size.width * 1.2,
              blur: 150,
            ),
          ),
          Positioned(
            bottom: size.height * 0.2,
            right: -100,
            child: _buildGlowCircle(
              color: MyColor.skyPrimary,
              size: size.width * 0.8,
              blur: 120,
            ),
          ),

          // 3. Typographic Background Element
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.03,
              child: Text(
                'FITNESS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.175,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 8,
                ),
              ),
            ),
          ),

          // 4. Main Character Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.75,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                MyImage.trainerImg,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.fitness_center,
                      size: 80,
                      color: Colors.white10,
                    ),
                  );
                },
              ),
            ),
          ),

          // 5. Gradient Overlay (for text readability)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.55,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    MyColor.logBackColor.withOpacity(0.8),
                    MyColor.logBackColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // 6. Content Area
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: MyColor.vibrantPurple.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: MyColor.vibrantPurple.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '#1 FITNESS APP',
                        style: TextStyle(
                          color: MyColor.vibrantPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main Headline with Gradient
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 40,
                          height: 1.1,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontFamily: 'Poppins', // Using theme font
                        ),
                        children: [
                          const TextSpan(text: 'Shape Your\n'),
                          TextSpan(
                            text: 'Ideal Body',
                            style: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: MyColor.fitnessGradient,
                                ).createShader(
                                    const Rect.fromLTWH(0, 0, 200, 70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Achieve your fitness goals with personalized workout plans and smart diet schedules.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                        height: 1.5,
                        fontFamily: 'Rubik',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Action Button
                    _buildExoticButton(),
                    const SizedBox(height: 16), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowCircle({
    required Color color,
    required double size,
    required double blur,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.25),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: blur,
            spreadRadius: blur / 2,
          ),
        ],
      ),
    );
  }

  Widget _buildExoticButton() {
    return InkWell(
      onTap: _onStartPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: MyColor.fitnessGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: MyColor.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: MyColor.primaryColor,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
