import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:flutter/material.dart';

class SimilarCarsByVinModal extends StatelessWidget {
  const SimilarCarsByVinModal({
    required this.similarCars,
    super.key,
  });

  final List<CarModel> similarCars;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: height * 0.6,
      child: Column(
        children: [
          const SizedBox(height: CosSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: CosSpacing.md),
            child: Row(
              children: [
                const Text(
                  'Similar Cars by VIN',
                  style: TextStyle(
                    fontSize: CosFonts.large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: CosColors.primary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const SizedBox(height: CosFonts.medium),
          Expanded(
            child: ListView.builder(
              itemCount: similarCars.length,
              itemBuilder: (context, index) {
                final car = similarCars[index];
                return ListTile(
                  title: Text('${car.make} ${car.model}'),
                  subtitle: Text('VIN Similarity: ${car.similarity.toStringAsFixed(2)}%'),
                  trailing: Text(car.externalId.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
