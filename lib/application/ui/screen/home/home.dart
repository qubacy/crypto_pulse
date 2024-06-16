
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import '../_common/screen.dart';

class Home extends StatelessWidget implements Screen {
  late TopHint _topHint;

  Home({super.key});
  
  @override
  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        onPressed: () {
          _topHint.toggleAppearance();
        },
        icon: const Icon(Icons.info)
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    _topHint = TopHint(hint: "Feel free to swipe out unnecessary items.");

    return Column(
      children: [
        _topHint
      ],
    );
  }
}

class TopHint extends StatefulWidget {
  _TopHintState? _lastState;
  final String hint;

  TopHint({super.key, required this.hint});

  @override
  _TopHintState createState() => _TopHintState(hint: hint);

  void toggleAppearance() {
    // todo: HOWW TO RESOLVE????!:

    _lastState?.toggleAppearance();
  }
}

class _TopHintState extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  static const ANIMATION_DURATION = Duration(milliseconds: 400);

  final String _hint;
  
  late AnimationController _animationController = AnimationController(vsync: this, duration: ANIMATION_DURATION);
  late Animation<Offset> _offsetAnimation = Tween(begin: Offset.zero, end: const Offset(0.0, -1.0)).animate(_animationController);
  late Widget _hintText;

  _TopHintState({required String hint}) : _hint = hint;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _hintText = SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(_hint)
      )
    );

    return _hintText;
  }

  void toggleAppearance() {
    switch (_animationController.status) {
      case AnimationStatus.completed || AnimationStatus.forward:
        _animationController.reverse();
      case AnimationStatus.dismissed || AnimationStatus.reverse:
        _animationController.forward();
      default:
    }
  }
}