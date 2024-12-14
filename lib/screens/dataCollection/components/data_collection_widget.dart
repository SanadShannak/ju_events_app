import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:temp_project/utilities/constants.dart';

const int numberOfPages = 3;

class DataCollectionWidget extends StatefulWidget {
  final Widget pageBody;
  final int dataCollectionPageIndex;
  final Widget? nextPage;
  final Widget? previousPage;
  final GlobalKey<FormState>? pageFormKey;

  const DataCollectionWidget({
    super.key,
    required this.pageBody,
    required this.dataCollectionPageIndex,
    this.nextPage,
    this.previousPage,
    this.pageFormKey,
  });

  @override
  _DataCollectionWidgetState createState() => _DataCollectionWidgetState();
}

class _DataCollectionWidgetState extends State<DataCollectionWidget> {
  void _navigateToNext(Widget nextPage) {
    if (widget.pageFormKey!.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  void _navigateToPrevious(Widget previousPage) {
    Navigator.pop(context);
  }

  void _finish() {
    if (widget.pageFormKey == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homePage',
        (Route<dynamic> route) => false,
      );
    } else if (widget.pageFormKey!.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homePage',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          color: AppColors.kBackground,
          child: Form(
            key: widget.pageFormKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                DotsIndicator(
                  dotsCount: numberOfPages,
                  position: widget.dataCollectionPageIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.kDarkGreen,
                    activeColor: AppColors.kPaleGoldenrod,
                    size: const Size.square(16.0),
                    activeSize: const Size.square(16.0),
                    spacing: const EdgeInsets.all(20.0),
                  ),
                ),
                widget.pageBody,
                const Spacer(),
                if (widget.dataCollectionPageIndex == 0) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 315, bottom: 8.0),
                    child: TextButton(
                      onPressed: () => _navigateToNext(widget.nextPage!),
                      child: const Text('Next',
                          style: TextStyle(
                              color: AppColors.kForestGreen, fontSize: 16)),
                    ),
                  ),
                ] else if (widget.dataCollectionPageIndex ==
                    numberOfPages - 1) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () =>
                              _navigateToPrevious(widget.previousPage!),
                          child: const Text('Previous',
                              style: TextStyle(
                                  color: AppColors.kForestGreen, fontSize: 16)),
                        ),
                        TextButton(
                          onPressed: _finish,
                          child: const Text('Finish',
                              style: TextStyle(
                                  color: AppColors.kForestGreen, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () =>
                              _navigateToPrevious(widget.previousPage!),
                          child: const Text('Previous',
                              style: TextStyle(
                                  color: AppColors.kForestGreen, fontSize: 16)),
                        ),
                        TextButton(
                          onPressed: () => _navigateToNext(widget.nextPage!),
                          child: const Text('Next',
                              style: TextStyle(
                                  color: AppColors.kForestGreen, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
