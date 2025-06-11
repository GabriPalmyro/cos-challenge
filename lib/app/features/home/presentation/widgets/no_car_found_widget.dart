import 'package:cos_challenge/app/design/tokens/cos_spacing.dart';
import 'package:flutter/material.dart';

class NoCarFoundWidget extends StatelessWidget {
  const NoCarFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.6,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: CosSpacing.sm),
            Text(
              'No search results found',
            ),
          ],
        ),
      ),
    );
  }
}
