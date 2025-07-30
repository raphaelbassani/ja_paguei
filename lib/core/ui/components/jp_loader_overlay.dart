import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class JPLoaderOverlay extends StatelessWidget {
  const JPLoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/loader_overlay.json',
            height: 150,
            width: 150,
          ),
        ],
      ),
    );
  }
}
