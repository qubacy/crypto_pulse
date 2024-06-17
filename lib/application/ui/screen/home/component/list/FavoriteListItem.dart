import 'package:flutter/material.dart';

class FavoriteListItem extends StatefulWidget {
  final String name;
  final String price;

  FavoriteListItem({super.key, required this.name, required this.price});

  @override
  State<FavoriteListItem> createState() => _FavoriteListItemState();
}

class _FavoriteListItemState extends State<FavoriteListItem> with SingleTickerProviderStateMixin {
  static const double SWIPE_OUT_THRESHOLD = 0.4;
  static const Duration SWIPE_CANCEL_ANIMATION_DURATION = Duration(milliseconds: 300);

  Offset _offset = Offset.zero;

  late AnimationController _animationController;
  late Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        print("onHorizontalDragUpdate(): $details;");

        _updateDragging(details);
      },
      onHorizontalDragEnd: (dragEndDetails) {
        print("onHorizontalDragEnd(): $dragEndDetails;");

        _endDragging(dragEndDetails);
      },
      child: SlideTransition(
        position: _animationOffset,
        child: Transform.translate(
          offset: _offset,
          child: ListTile(
            title: Text(widget.name),
            trailing: Text(widget.price, style: textTheme.bodyLarge,),
          )
        )
      ),
    );
  }

  void _initAnimation() {
    _animationController = AnimationController(vsync: this, duration: SWIPE_CANCEL_ANIMATION_DURATION);
    _animationOffset = Tween(begin: _offset, end: const Offset(0, 0)).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;

      _setOffset(0.0);
    });
  }

  void _updateDragging(DragUpdateDetails details) {
    _updateOffset(details.delta.dx);
  }

  void _endDragging(dragEndDetails) {
    // todo: doesn't work:

    _animationController.forward();
  }

  void _updateOffset(double dx) {
    double newDx = _offset.dx + dx;

    _setOffset(newDx);
  }

  void _setOffset(double x) {
    setState(() {
      _offset = Offset(x, 0);
    });
  }
}