import 'package:flutter/material.dart';

class CarSearchLoadingWidget extends StatelessWidget {
  const CarSearchLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.6,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
