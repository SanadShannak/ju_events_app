import 'package:flutter/material.dart';

class UJWidget extends StatelessWidget {
  const UJWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('lib/assets/logo/ju_logo.png'),
      height: size.height * .2,
    );
  }
}
