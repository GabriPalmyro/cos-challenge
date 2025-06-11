import 'package:cos_challenge/app/core/extensions/price_extension.dart';
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
            const SizedBox(height: CosSpacing.lg),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.directions_car,
                size: 80,
                color: CosColors.background,
              ),
            ),
            const SizedBox(height: CosSpacing.lg),
            Text(
              '${carInfo.make} ${carInfo.model}',
              style: const TextStyle(
                fontSize: CosFonts.extraLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: CosSpacing.sm),
            Text(
              carInfo.price.toDouble().toCurrency(),
              style: const TextStyle(
                fontSize: CosFonts.large,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: CosSpacing.sm),
            Text(
              carInfo.positiveCustomerFeedback ? 'Positive Customer Feedback' : 'Negative Customer Feedback',
              style: const TextStyle(
                fontSize: CosFonts.medium,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: CosSpacing.xs),
            Text(
              'Origin: ${carInfo.origin}',
              style: const TextStyle(
                fontSize: CosFonts.medium,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: CosSpacing.xs),
            Text(
              'ID: ${carInfo.id}',
              style: const TextStyle(
                fontSize: CosFonts.medium,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
