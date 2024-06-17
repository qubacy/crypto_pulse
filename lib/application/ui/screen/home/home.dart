
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

import '../_common/screen.dart';
import './component/list/FavoriteList.dart';
import './component/TopHint.dart';

class Home extends StatelessWidget implements Screen {
  final GlobalKey _topHintKey = GlobalKey();
  HomeContent? _homeContent;

  Home({super.key});
  
  @override
  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        onPressed: () {
          _homeContent?.toggleAppearance();
        },
        icon: const Icon(Icons.info)
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    _homeContent = HomeContent(topHintKey: _topHintKey,);

    return _homeContent!;
  }
}

class HomeContent extends StatefulWidget {
  final GlobalKey? _topHintKey;
  _HomeContentState? lastState;

  HomeContent({super.key, GlobalKey? topHintKey}) : 
    _topHintKey = topHintKey;

  @override
  State<HomeContent> createState() => _HomeContentState(topHintKey: _topHintKey);

  void toggleAppearance() {
    lastState?.toggleAppearance();
  }
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  static const ANIMATION_DURATION = Duration(milliseconds: 400);

  final GlobalKey? _topHintKey;

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  double _contentTopShift = 0.0;

  _HomeContentState({GlobalKey? topHintKey}) : _topHintKey = topHintKey;

  @override
  void initState() {
    super.initState();

    _initAnimation();
    print("initState;");

    (widget as HomeContent).lastState = this;
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget as HomeContent);

    print("didUpdateWidget;");

    (widget as HomeContent).lastState = this;
  }

  void _initAnimation() {
    _animationController = AnimationController(vsync: this, duration: ANIMATION_DURATION);
    _offsetAnimation = Tween(begin: Offset.zero, end: const Offset(0.0, -1.0)).animate(_animationController);

    _animationController.addListener(_onAnimationRunning);
  }

  void _onAnimationRunning() {
    double hintTextHeight = (_topHintKey?.currentContext?.findRenderObject()?.semanticBounds.height)!;

    setState(() {
      _contentTopShift = -(hintTextHeight * _animationController.value);

      print("content top margin: $_contentTopShift");
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets commonMargin = const EdgeInsets.only(left: 16, right: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: _offsetAnimation,
          child: TopHint(
            key: _topHintKey,
            hint: "Feel free to swipe out unnecessary items.",
            margin: commonMargin.copyWith(top: 8, bottom: 8)
          )
        ),
        Transform.translate(
          offset: Offset(0, _contentTopShift),
          child: FavoriteList(
            hintTextKey: _topHintKey
          )
        )
      ],
    );
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