import 'package:cos_challenge/app/design/design.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: CosColors.background,
            centerTitle: false,
            title: const Text(
              'Welcome back, ',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: CosColors.primary,
                ),
                onPressed: () {
                  // Handle logout action
                },
              ),
            ],
            forceElevated: false,
            elevation: 0,
          ),
          SliverAppBar(
            floating: true,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: CosColors.background,
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CosSpacing.sm),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: CosColors.primary),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
