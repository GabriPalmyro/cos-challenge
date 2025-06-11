import 'package:cos_challenge/app/common/client/cos_client.dart';
import 'package:cos_challenge/app/common/router/router.dart';
import 'package:cos_challenge/app/core/extensions/price_extension.dart';
import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/car_loading_widget.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/no_car_found_widget.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/similar_cars_by_vin_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget with NavigationDelegate {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationDelegate {
  late CarSearchCubit carCubit;
  late UserInfoCubit userCubit;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    carCubit = GetIt.I.get<CarSearchCubit>();
    userCubit = GetIt.I.get<UserInfoCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  String? _validateVin(String? value) {
    if (value == null || value.isEmpty) {
      return 'VIN cannot be empty';
    }

    // Remove espaços em branco
    final cleanValue = value.replaceAll(' ', '');

    // Validar se tem exatamente 17 caracteres
    if (cleanValue.length != CosChallenge.vinLength) {
      return 'VIN must have exactly ${CosChallenge.vinLength} characters';
    }

    // Validar se contém apenas letras e números (padrão VIN)
    final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
    if (!vinRegex.hasMatch(cleanValue.toUpperCase())) {
      return 'VIN must contain only letters and numbers (except I, O, Q)';
    }

    return null;
  }

  void _performSearch() {
    final vin = _searchController.text.trim();
    final error = _validateVin(vin);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: CosColors.error,
        ),
      );
      return;
    }

    if (vin.isNotEmpty) {
      carCubit.searchCarByVin(vin.toUpperCase());
      _searchFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: carCubit..loadCachedCars(),
        ),
        BlocProvider.value(
          value: userCubit..getUserInfo(),
        ),
      ],
      child: Scaffold(
        backgroundColor: CosColors.background,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: padding.top)),
                BlocConsumer<UserInfoCubit, UserInfoState>(
                  listener: (context, state) {
                    if (state is UserLogout) {
                      replaceWith(context, Routes.login);
                    }
                  },
                  builder: (context, state) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: CosSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state is UserInfoLoaded ? 'Welcome back, ${state.user.name}' : 'Welcome back',
                                  style: const TextStyle(
                                    fontSize: CosFonts.large,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.logout_rounded,
                                    color: CosColors.primary,
                                  ),
                                  onPressed: () {
                                    context.read<UserInfoCubit>().logout();
                                  },
                                ),
                              ],
                            ),
                            const Text(
                              'Here are your last searches',
                              style: TextStyle(
                                fontSize: CosFonts.medium,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: CosSpacing.xs)),
                const SliverToBoxAdapter(child: Divider(height: 1, thickness: 1, color: CosColors.primary)),
                const SliverToBoxAdapter(child: SizedBox(height: CosSpacing.xs)),
                BlocListener<CarSearchCubit, CarSearchState>(
                  listener: (context, state) {
                    if (state is CarSearchError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error.message,
                            style: const TextStyle(
                              color: CosColors.text,
                            ),
                          ),
                          backgroundColor: CosColors.error,
                        ),
                      );
                    } else if (state is CarSearchLoaded) {
                      navigateTo(context, Routes.carInfo, arguments: state.carInfo);
                      context.read<CarSearchCubit>().loadCachedCars();
                    } else if (state is MultipleCarSearchLoaded) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: CosColors.background,
                        isScrollControlled: true,
                        builder: (context) => SimilarCarsByVinModal(
                          similarCars: state.carInfoList,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<CarSearchCubit, CarSearchState>(
                    builder: (context, state) {
                      if (state is CarSearchLoading) {
                        return const SliverToBoxAdapter(
                          child: CarSearchLoadingWidget(),
                        );
                      }
                      if (state is CarSearchError || state is CarSearchInitial || state is MultipleCarSearchLoaded) {
                        final List<CarInfoModel> carList = state is CarSearchError
                            ? state.cachedResults
                            : state is CarSearchInitial
                                ? state.lastSearchResults
                                : (state as MultipleCarSearchLoaded).lastSearchResults;

                        if (carList.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.all(CosSpacing.md),
                              child: NoCarFoundWidget(),
                            ),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final car = carList[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text('${car.make} ${car.model}'),
                                    subtitle: Text('Price: ${car.price.toDouble().toCurrency()}'),
                                    trailing: Text('ID: ${car.id.toString()}'),
                                  ),
                                ],
                              );
                            },
                            childCount: carList.length,
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
                ),
                // Add bottom padding to account for the fixed search bar
                SliverToBoxAdapter(
                  child: SizedBox(height: 120 + padding.bottom),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: CosSpacing.md,
                  right: CosSpacing.md,
                  top: CosSpacing.md,
                  bottom: padding.bottom + CosSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: CosColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'VIN Code (${CosChallenge.vinLength} characters)',
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
                        final isLoading = state is CarSearchLoading;
                        return SizedBox(
                          width: double.infinity,
                          child: CosButton(
                            onPressed: !isLoading ? _performSearch : null,
                            size: CosButtonSize.medium,
                            type: isLoading ? CosButtonType.ghost : CosButtonType.primary,
                            label: 'Search',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
