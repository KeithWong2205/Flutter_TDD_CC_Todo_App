import 'package:flutter_tcc_base_source/core/helpers/base_state.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class _HomeScreenState extends BaseState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _drawerKey,
      body: Container(
        color: Colors.blue,
        child: ListView()
      ),
    );
  }
}
