import 'package:flutter/material.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomBar(
        currentIndex: 3,
      ),
    );
  }
}
