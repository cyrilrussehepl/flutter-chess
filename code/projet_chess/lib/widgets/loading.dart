import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 150,
        height: 150,
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
