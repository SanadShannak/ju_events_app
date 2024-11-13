import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundVectorShape extends StatelessWidget {
  const BackgroundVectorShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SvgPicture.asset(
        'lib/assets/svg_files/background_vector.svg',
        height: MediaQuery.of(context).size.height * 0.3,
        fit: BoxFit.cover,
      ),
    );
  }
}
