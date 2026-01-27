import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class AppAnimatedRefreshIconWidget extends StatefulWidget {
  const AppAnimatedRefreshIconWidget({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.iconColor,
  });
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? iconColor;
  @override
  State<AppAnimatedRefreshIconWidget> createState() =>
      _AppAnimatedRefreshIconWidgetState();
}

class _AppAnimatedRefreshIconWidgetState
    extends State<AppAnimatedRefreshIconWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void didUpdateWidget(covariant AppAnimatedRefreshIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.repeat();
    } else if (oldWidget.isLoading && !widget.isLoading) {
      _controller.animateTo(1.0).whenComplete(() {
        _controller.stop();
        _controller.value = 0.0;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final appStyle = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (!_controller.isAnimating) {
          widget.onPressed?.call();
        }
      },
      child: SizedBox(
        height: 40,
        width: 40,
        child: Center(
          child: RotationTransition(
            turns: _controller,
            child: Icon(
              FeatherIcons.refreshCcw,
              color: widget.iconColor ?? Color(0xFF1A1A1A),
            ),
          ),
        ),
      ),
    );
  }
}
