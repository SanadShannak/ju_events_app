import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundVectorShape extends StatelessWidget {
  const BackgroundVectorShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return (orientation == Orientation.portrait)
        ? Container(
            alignment: Alignment.bottomCenter,
            height: size.height,
            child: SvgPicture.asset(
              'lib/assets/images/svg_files/background_vector.svg',
              alignment: Alignment.bottomCenter,
              height: size.height * 0.4,
              fit: BoxFit.fill,
            ),
          )
        : const SizedBox.shrink();
  }
}
