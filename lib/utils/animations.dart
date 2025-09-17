import 'package:flutter/material.dart';

class AppAnimations {
  // Animation durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);

  // Animation curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeOutCubic;
  static const Curve sharpCurve = Curves.easeInOutQuart;

  // Slide transitions
  static Widget slideInFromBottom(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween(begin: 1.0, end: 0.0),
      curve: smoothCurve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * 50),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  static Widget slideInFromRight(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween(begin: 1.0, end: 0.0),
      curve: smoothCurve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * 100, 0),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  static Widget slideInFromLeft(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween(begin: 1.0, end: 0.0),
      curve: smoothCurve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-value * 100, 0),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Scale animations
  static Widget scaleIn(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween(begin: 0.0, end: 1.0),
      curve: bounceCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget pulseScale(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? slow,
      tween: Tween(begin: 1.0, end: 1.05),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Fade animations
  static Widget fadeIn(Widget child, {Duration? duration, double? delay}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween(begin: 0.0, end: 1.0),
      curve: defaultCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Shimmer loading animation
  static Widget shimmerLoading({
    required double width,
    required double height,
    BorderRadius? borderRadius,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: -1.0, end: 2.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (value - 1).clamp(0.0, 1.0),
                value.clamp(0.0, 1.0),
                (value + 1).clamp(0.0, 1.0),
              ],
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
            ),
          ),
        );
      },
    );
  }

  // Ripple effect animation
  static Widget rippleEffect({
    required Widget child,
    required VoidCallback onTap,
    Color? rippleColor,
    BorderRadius? borderRadius,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: rippleColor ?? Colors.blue.withOpacity(0.2),
        highlightColor: rippleColor?.withOpacity(0.1) ?? Colors.blue.withOpacity(0.1),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: child,
      ),
    );
  }

  // Bounce animation for buttons
  static Widget bounceOnTap({
    required Widget child,
    required VoidCallback onTap,
    double scale = 0.95,
  }) {
    return TweenAnimationBuilder<double>(
      duration: fast,
      tween: Tween(begin: 1.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, animatedChild) {
        return GestureDetector(
          onTapDown: (_) {
            // Scale down animation would be handled by AnimatedContainer
          },
          onTapUp: (_) {
            onTap();
          },
          onTapCancel: () {
            // Scale back up animation would be handled by AnimatedContainer
          },
          child: AnimatedScale(
            scale: value,
            duration: fast,
            curve: Curves.elasticOut,
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }

  // Floating animation
  static Widget floatingAnimation(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? const Duration(seconds: 3),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 5 * (0.5 - (value - 0.5).abs())),
          child: child,
        );
      },
      child: child,
    );
  }

  // Staggered list animation
  static Widget staggeredListItem({
    required Widget child,
    required int index,
    Duration? duration,
    double? offset,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 1.0, end: 0.0),
      curve: smoothCurve,
      builder: (context, value, animatedChild) {
        return Transform.translate(
          offset: Offset(0, (offset ?? 50) * value),
          child: Opacity(
            opacity: 1 - value,
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }

  // Page transition animations
  static PageRouteBuilder<T> createRoute<T>(Widget page, {String? routeName}) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: medium,
      reverseTransitionDuration: medium,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  // Loading spinner with custom animation
  static Widget loadingSpinner({
    Color? color,
    double size = 24,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Colors.blue,
        ),
      ),
    );
  }

  // Success checkmark animation
  static Widget successCheckmark({
    Color? color,
    double size = 24,
  }) {
    return TweenAnimationBuilder<double>(
      duration: slow,
      tween: Tween(begin: 0.0, end: 1.0),
      curve: bounceCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Icon(
            Icons.check_circle,
            color: color ?? Colors.green,
            size: size,
          ),
        );
      },
    );
  }
}

