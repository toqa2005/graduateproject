import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/features/home/data/movie_service.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import 'package:graduateproject/features/home/presentation/cubit/home_cubit.dart';
import 'package:graduateproject/features/home/presentation/cubit/home_state.dart';

import '../../../../core/colors/Appcolors.dart';
import '../../../../core/images/Appimages.dart';
import '../../../../core/widgets/gener_selection.dart';
import '../../../../core/widgets/movie/moviecard.dart';
import '../../../../core/widgets/movie/smallCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit homeCubit = HomeCubit(MovieService());

  PageController? _pageController;
  double? _lastViewportFraction;

  int currentPage = 0;
  bool showAllActionMovies = false;
  late String selectedGenre;

  @override
  void initState() {
    super.initState();

    selectedGenre = GenreSelection.selected.value;
    GenreSelection.selected.addListener(_onGenreChanged);

    homeCubit.initialize(genre: selectedGenre);
  }

  void _onGenreChanged() {
    if (!mounted) return;

    setState(() {
      selectedGenre = GenreSelection.selected.value;
      showAllActionMovies = false;
    });

    homeCubit.getGenreMovies(selectedGenre);
  }

  double _getViewportFraction(double width) {
    if (width < 360) return 0.68;
    if (width < 600) return 0.58;
    return 0.42;
  }

  PageController _getPageController(double viewportFraction) {
    if (_pageController == null || _lastViewportFraction != viewportFraction) {
      final oldPage = _pageController?.hasClients == true
          ? _pageController!.page?.round() ?? currentPage
          : currentPage;

      _pageController?.dispose();

      _pageController = PageController(
        viewportFraction: viewportFraction,
        initialPage: oldPage,
      );

      _lastViewportFraction = viewportFraction;
    }

    return _pageController!;
  }

  @override
  void dispose() {
    GenreSelection.selected.removeListener(_onGenreChanged);
    _pageController?.dispose();
    homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final availableWidth = (width * 0.72).clamp(210.0, 260.0).toDouble();
        final watchNowWidth = (width - 32).clamp(220.0, 350.0).toDouble();
        final watchNowHeight = watchNowWidth * 120 / 350;
        final carouselHeight = (width * 0.75).clamp(240.0, 300.0).toDouble();
        final availableImageHeight = availableWidth * 93 / 260;
        final heroContentHeight =
            20 +
            availableImageHeight +
            20 +
            carouselHeight +
            5 +
            watchNowHeight +
            20;

        final heroHeight = heroContentHeight.clamp(420.0, 680.0);

        final viewportFraction = _getViewportFraction(width);
        final pageController = _getPageController(viewportFraction);

        final gridColumns = width >= 900
            ? 5
            : width >= 650
            ? 4
            : width >= 450
            ? 3
            : 2;

        return BlocProvider.value(
          value: homeCubit,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Scaffold(
                  backgroundColor: Appcolor.black,
                  body: Center(
                    child: CircularProgressIndicator(color: Appcolor.gray),
                  ),
                );
              }

              if (state is HomeFailure) {
                return Scaffold(
                  backgroundColor: Appcolor.black,
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Appcolor.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }

              if (state is HomeSuccess) {
                final movies = state.movieModel.data?.movies ?? [];

                if (movies.isEmpty) {
                  return const Scaffold(
                    backgroundColor: Appcolor.black,
                    body: Center(
                      child: Text(
                        'No Movies Found',
                        style: TextStyle(color: Appcolor.white),
                      ),
                    ),
                  );
                }

                final selectedIndex = currentPage.clamp(0, movies.length - 1);
                final selectedMovie = movies[selectedIndex];

                return Scaffold(
                  backgroundColor: Appcolor.black,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: heroHeight,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: Image.network(
                                    selectedMovie.backgroundImageOriginal ??
                                        selectedMovie.backgroundImage ??
                                        selectedMovie.largeCoverImage ??
                                        '',
                                    key: ValueKey(
                                      'background_${selectedMovie.id}',
                                    ),
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(color: Appcolor.black);
                                    },
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 8,
                                    sigmaY: 8,
                                  ),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.60),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Image.asset(
                                      Appimages.availableNow,
                                      width: availableWidth,
                                      height: availableWidth * 93 / 260,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: carouselHeight,
                                    child: PageView.builder(
                                      controller: pageController,
                                      itemCount: movies.length,
                                      onPageChanged: (index) {
                                        if (!mounted) return;

                                        setState(() {
                                          currentPage = index;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        final movie = movies[index];
                                        final isSelected = index == currentPage;

                                        return AnimatedScale(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          scale: isSelected ? 1 : 0.82,
                                          child: MovieCard(movie: movie),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Center(
                                    child: Image.asset(
                                      Appimages.watchNow,
                                      width: watchNowWidth,
                                      height: watchNowHeight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedGenre,
                                style: const TextStyle(
                                  color: Appcolor.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showAllActionMovies = !showAllActionMovies;
                                  });
                                },
                                child: Text(
                                  showAllActionMovies ? 'Show Less ↑' : 'See More →',
                                  style: const TextStyle(
                                    color: Appcolor.yellow,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Builder(
                          builder: (context) {
                            final homeState = context.watch<HomeCubit>().state;

                            final genreMovies = homeState is HomeSuccess
                                ? homeState.genreMovies
                                : const <Movies>[];

                            final genreLoading = homeState is HomeSuccess
                                ? homeState.genreLoading
                                : false;

                            if (genreLoading) {
                              return const SizedBox(
                                height: 220,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Appcolor.yellow,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }

                            if (genreMovies.isEmpty) {
                              return const SizedBox(
                                height: 220,
                                child: Center(
                                  child: Text(
                                    'No Movies Found',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              );
                            }

                            if (showAllActionMovies) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: genreMovies.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: gridColumns,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 14,
                                        childAspectRatio: 0.66,
                                      ),
                                  itemBuilder: (context, index) {
                                    return SmallCard(movie: genreMovies[index]);
                                  },
                                ),
                              );
                            }

                            return SizedBox(
                              height: width < 360 ? 200 : 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: genreMovies.length,
                                itemBuilder: (context, index) {
                                  return SmallCard(movie: genreMovies[index]);
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
              }

              return const Scaffold(
                backgroundColor: Appcolor.black,
                body: SizedBox(),
              );
            },
          ),
        );
      },
    );
  }
}
