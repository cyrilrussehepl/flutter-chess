import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 125,
        height: 125,
        child: Center(
          child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotatePulse,
            strokeWidth: 3,
            colors: [Colors.green, Colors.grey],
          ),
        ),
      ),
    );
  }
}
