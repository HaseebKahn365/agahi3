import 'package:flutter/material.dart';

class CustomSquareButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double size;
  final bool enabled;
  final Icon? icon;

  const CustomSquareButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = false,
    this.size = 150.0,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(size, size),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: enabled ? Colors.black : Colors.grey[300],
        foregroundColor: enabled ? Colors.white : Colors.black54,
      ),
      child: Column(
        children: [
          if (icon != null) icon!,
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}

class SexyCustomNextButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SexyCustomNextButton({super.key, required this.onPressed});

  @override
  _SexyCustomNextButtonState createState() => _SexyCustomNextButtonState();
}

class _SexyCustomNextButtonState extends State<SexyCustomNextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Increased duration
    )..repeat(reverse: true); // Repeat the animation

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        _opacityAnimation.value * 0.5,
                      ),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Pulse effect
                    ...List.generate(
                      3,
                      (index) => TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(seconds: 1),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: (1 - value) * 0.3,
                            child: Container(
                              width: 200,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2 * value,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              double arrowOffset =
                                  10.0 * _animationController.value;
                              return Row(
                                children: [
                                  SizedBox(width: arrowOffset),
                                  //usee green_arrow.png
                                  Image.asset(
                                    'assets/images/green_arrow.png',
                                    width: 60,
                                    height: 30,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomTallCategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? imagePath;

  const CustomTallCategoryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (imagePath != null)
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath!,
                      width: double.infinity,
                      fit: BoxFit.fill,
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
