import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:flutter/material.dart';

class CarInfoPage extends StatelessWidget {
  const CarInfoPage({required this.carInfo, super.key});

  final CarInfoModel carInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.background,
      appBar: AppBar(
        title: const Text('Auction Car Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CosPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${carInfo.make} ${carInfo.model}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: CosSpacing.sm),
            Text(
              '${carInfo.price} USD',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: CosSpacing.sm),
            Text(
              carInfo.positiveCustomerFeedback
                  ? 'Positive Customer Feedback'
                  : 'Negative Customer Feedback',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: CosSpacing.md),
            Text(
              'Origin: ${carInfo.origin}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
