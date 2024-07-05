import 'package:crypto_pulse/application/ui/navigation/Navigation.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../_common/screen.dart';
import './component/list/FavoriteList.dart';
import './component/TopHint.dart';

class Home extends StatefulWidget implements Screen {
  static const NAME = "Your crypto";
  static const PATH = "/";

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey _topHintKey = GlobalKey();
  final GlobalKey _homeContentState = GlobalKey();

  HomeModel? _model;
  HomeContent? _homeContent;

  @override
  void dispose() {
    _model?.clear();
    super.dispose();
  }

  void toggleAppearance() {
    final state = _homeContentState.currentState;

    if (state == null) return;

    (state as _HomeContentState).toggleAppearance();
  }

  @override
  Widget build(BuildContext context) {
    _homeContent = HomeContent(key: _homeContentState, topHintKey: _topHintKey);

    return Consumer<HomeModel>(
      builder: (context, model, child) {
        _model = model;

        return Scaffold(
          appBar: AppBar(
            title: const Text(Home.NAME),
            actions: <Widget>[
              IconButton(
                onPressed: () => toggleAppearance(),
                icon: const Icon(Icons.info)
              )
            ],
            bottom: model.isLoading ? const PreferredSize(
              preferredSize: Size.fromHeight(6),
              child: LinearProgressIndicator()
            ) : null,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: 0,
            destinations: navigationBarDestinations,
            onDestinationSelected: (index) {
              context.go(routes[index].path);
            },
          ),
          body: _homeContent!
        );
      }
    );
  }
}

class HomeContent extends StatefulWidget {
  final GlobalKey? _topHintKey;

  HomeContent({super.key, GlobalKey? topHintKey}) : 
    _topHintKey = topHintKey;

  @override
  State<HomeContent> createState() => _HomeContentState(topHintKey: _topHintKey);
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  static const ANIMATION_DURATION = Duration(milliseconds: 400);

  final GlobalKey? _topHintKey;

  double? _topHintHeight;
  double? _curTopHintHeight;

  _HomeContentState({GlobalKey? topHintKey}) : _topHintKey = topHintKey;

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
          child: FavoriteList(
            hintTextKey: _topHintKey
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
          _curTopHintHeight = _curTopHintHeight == _topHintHeight ? 0 : 40; // todo: refactor!
        }

        print("toggleAppearance(): _curTopHintHeight = $_curTopHintHeight;");
    });
  }
}