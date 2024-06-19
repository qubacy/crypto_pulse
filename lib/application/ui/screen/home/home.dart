
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

  double? _topHintHeight;
  double? _curTopHintHeight;

  _HomeContentState({GlobalKey? topHintKey}) : _topHintKey = topHintKey;

  @override
  void initState() {
    super.initState();

    print("initState;");

    (widget as HomeContent).lastState = this;
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget as HomeContent);

    print("didUpdateWidget;");

    (widget as HomeContent).lastState = this;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets commonMargin = const EdgeInsets.only(left: 16, right: 16);
    final topHint = TopHint(
      key: _topHintKey,
      hint: "Feel free to swipe out unnecessary items.",
      margin: commonMargin.copyWith(top: 8, bottom: 8)
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: ANIMATION_DURATION,
          height: _curTopHintHeight,
          child: topHint
        ),
        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return FavoriteList(
                hintTextKey: _topHintKey
              );
            }
          )
        )
      ],
    );
  }

  void toggleAppearance() {
    _topHintHeight ??= _topHintKey!.currentContext!.size!.height;

    print("toggleAppearance(): _topHintHeight = $_topHintHeight;");

    setState(() {
        if (_curTopHintHeight == null) {
          _curTopHintHeight = 0;
        } else {
          _curTopHintHeight = _curTopHintHeight == _topHintHeight ? 0 : 40;
        }

        print("toggleAppearance(): _curTopHintHeight = $_curTopHintHeight;");
    });
  }
}