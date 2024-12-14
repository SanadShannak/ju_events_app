import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBackgroundVectorShape extends StatelessWidget {
  const TopBackgroundVectorShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return (orientation == Orientation.portrait)
        ? Container(
            alignment: Alignment.topCenter,
            height: size.height,
            child: SvgPicture.asset(
              // 'lib/assets/images/svg_files/background_vector.svg',
              'lib/assets/images/svg_files/top_green_layered-waves.svg',
              alignment: Alignment.topCenter,
              height: size.height * 0.4,
              fit: BoxFit.fill,
            ),
          )
        : const SizedBox.shrink();
  }
}
