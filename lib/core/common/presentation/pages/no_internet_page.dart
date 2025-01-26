
import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:flutter/material.dart';


class NoInternetPage extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoInternetPage({super.key, required this.onRetry});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        
        ],
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: app_padding,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 34,
                    width: 34,
                  ),
                  const AppTextViewMedium(
                    text: app_title,
                    padding: 4,
                    fontSize: 20,
                    weight: FontWeight.w800,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(size: 24),
        titleSpacing: 20,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pulsating "No Internet" Icon
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + (_controller.value * 0.1),
                  child: child,
                );
              },
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Animated Text
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Column(
                children: [
                  Text(
                    "Oops! No Internet Connection",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please check your connection and try again.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Retry Button with Hover and Tap Effects
            widget.onRetry != null
                ? GestureDetector(
                    onTap: widget.onRetry,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Text(
                          "Retry",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent.shade700,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
