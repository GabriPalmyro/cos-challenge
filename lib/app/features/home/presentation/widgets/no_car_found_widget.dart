import 'package:flutter/material.dart';

class NoCarFoundWidget extends StatelessWidget {
  const NoCarFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No car found with the provided VIN.',
          ),
        ],
      ),
    );
  }
}
