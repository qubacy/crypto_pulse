import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import '../_common/screen.dart';

class Home extends StatefulWidget implements Screen {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
  
  @override
  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        onPressed: () {
          
        },
        icon: const Icon(Icons.info)
      )
    ];
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}