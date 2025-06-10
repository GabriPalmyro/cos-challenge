import 'package:cos_challenge/app/common/client/cos_client.dart';
import 'package:cos_challenge/app/common/router/router.dart';
import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/no_car_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget with NavigationDelegate {
  const HomePage({
    required this.userCubit,
    required this.carCubit,
    super.key,
  });

  final UserInfoCubit userCubit;
  final CarSearchCubit carCubit;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationDelegate {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  String? _validateVin(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Permitir campo vazio
    }

    // Remove espaços em branco
    final cleanValue = value.replaceAll(' ', '');

    // Validar se tem exatamente 17 caracteres
    if (cleanValue.length != CosChallenge.vinLength) {
      return 'VIN deve ter exatamente ${CosChallenge.vinLength} caracteres';
    }

    // Validar se contém apenas letras e números (padrão VIN)
    final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
    if (!vinRegex.hasMatch(cleanValue.toUpperCase())) {
      return 'VIN deve conter apenas letras e números (exceto I, O, Q)';
    }

    return null;
  }

  void _performSearch() {
    final vin = _searchController.text.trim();
    final error = _validateVin(vin);

    if (error == null && vin.isNotEmpty) {
      widget.carCubit.searchCarByVin(vin.toUpperCase());
      _searchFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return BlocProvider(
      create: (context) => widget.carCubit,
      child: Scaffold(
        backgroundColor: CosColors.background,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: padding.top)),
            BlocConsumer<UserInfoCubit, UserInfoState>(
              bloc: widget.userCubit..getUserInfo(),
              listener: (context, state) {
                if (state is UserLogout) {
                  replaceWith(context, Routes.login);
                }
              },
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: CosSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state is UserInfoLoaded ? 'Welcome back, ${state.user.name}' : 'Welcome back',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                    ),
                  ),
                );
              },
            ),
            SliverAppBar(
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: CosColors.background,
              collapsedHeight: 85,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(CosSpacing.md),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Digite o VIN do veículo (17 caracteres)',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(CosSpacing.sm),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(CosSpacing.sm),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        prefixIcon: const Icon(Icons.search, color: CosColors.primary),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-HJ-NPR-Z0-9]')),
                        LengthLimitingTextInputFormatter(CosChallenge.vinLength),
                      ],
                      onSubmitted: (_) => _performSearch(),
                    ),
                    const SizedBox(height: CosSpacing.md),
                    BlocBuilder<CarSearchCubit, CarSearchState>(
                      builder: (context, state) {
                        return CosButton(
                          onPressed: state is! CarSearchLoading ? _performSearch : null,
                          size: CosButtonSize.medium,
                          isLoading: state is CarSearchLoading,
                          type: CosButtonType.secondary,
                          label: 'Search',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocConsumer<CarSearchCubit, CarSearchState>(
              listener: (context, state) {
                if (state is CarSearchError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.message),
                      backgroundColor: CosColors.error,
                    ),
                  );
                } else if (state is CarSearchLoaded) {
                  navigateTo(context, Routes.carInfo, arguments: state.carInfo);
                }
              },
              builder: (context, state) {
                if (state is CarSearchLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is CarSearchError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(CosSpacing.md),
                      child: Text(
                        state.error.message,
                        style: const TextStyle(
                          color: CosColors.error,
                        ),
                      ),
                    ),
                  );
                } else if (state is MultipleCarSearchLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: state.carInfoList.map((car) {
                            return ListTile(
                              title: Text('${car.make} ${car.model}'),
                              subtitle: Text('VIN: ${car.externalId}'),
                            );
                          }).toList(),
                        );
                      },
                      childCount: state.carInfoList.length,
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(CosSpacing.md),
                      child: NoCarFoundWidget(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
