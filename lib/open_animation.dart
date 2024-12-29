import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_layout.dart';
import 'login_page.dart';

class OpenAnimation extends StatefulWidget {
  @override
  _OpenAnimationState createState() => _OpenAnimationState();
}

class _OpenAnimationState extends State<OpenAnimation>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _flashController;
  late Animation<double> _circleAnimation;
  late Animation<double> _flashAnimation;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _circleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_circleController);

    _flashController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _flashAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeOut,
    ));

    _circleController.forward();

    _circleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flashController.forward();
      }
    });

    _flashController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkUserDetails();
      }
    });
  }

  Future<void> _checkUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (username == null || email == null || password == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainLayout()),
      );
    }
  }

  @override
  void dispose() {
    _circleController.dispose();
    _flashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final circleSize = screenSize.width * 0.4;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _circleAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: CirclePainter(_circleAnimation.value),
                          size: Size(circleSize, circleSize),
                        );
                      },
                    ),
                    Container(
                      width: circleSize * 0.8,
                      height: circleSize * 0.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[800],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/hiremi.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Hiremi",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _flashAnimation,
            builder: (context, child) {
              return ClipOval(
                clipper: FlashClipper(_flashAnimation.value, screenSize),
                child: Container(
                  color: Colors.blue[800],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 21, 101, 192)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -90 * (3.14159 / 180),
      progress * 2 * 3.14159,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FlashClipper extends CustomClipper<Rect> {
  final double progress;
  final Size screenSize;

  FlashClipper(this.progress, this.screenSize);

  @override
  Rect getClip(Size size) {
    final center = Offset(screenSize.width / 2, screenSize.height / 2);
    final radius = progress * screenSize.longestSide;
    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldReclip(covariant FlashClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}
