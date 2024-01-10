import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo/ezofis/logo.png',
      height: 36,
      width: 200,
      alignment: Alignment.topRight,
    );
  }
}
