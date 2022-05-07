import 'package:flutter/material.dart';

class ExtendedTextWidget extends StatefulWidget {
  final String label;
  final String text;
  final Color color;
  final Color backgroundColor;

  const ExtendedTextWidget(
    this.label,
    this.text, {
    Key? key,
    this.color = Colors.white,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _ExtendedTextWidgetState createState() => _ExtendedTextWidgetState();
}

class _ExtendedTextWidgetState extends State<ExtendedTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Duration animatedIconsDuration = Duration(seconds: 1);
  Duration textExpansion = Duration(seconds: 1);

  bool visible = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: animatedIconsDuration);
  }

  void toggle() {
    setState(() {
      visible = !visible;
      bool isPlaying = visible;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: widget.backgroundColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: GestureDetector(
              onTap: toggle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.color,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                    color: widget.color,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ExpandedSection(
            duration: textExpansion,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.color,
                ),
              ),
            ),
            expand: visible,
          ),
        ],
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Duration duration;

  final Widget? child;
  final bool expand;

  ExpandedSection(
      {this.expand = false,
      this.child,
      this.duration = const Duration(seconds: 1)});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: duration);
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
