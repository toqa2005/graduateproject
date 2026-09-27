import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/features/home/data/movie_service.dart';
import 'package:graduateproject/features/home/presentation/cubit/home_cubit.dart';
import 'package:graduateproject/features/home/presentation/cubit/home_state.dart';
import '../../../../core/colors/Appcolors.dart';
import '../../../../core/images/Appimages.dart';
import '../../../../core/widgets/movie/moviecard.dart';
import '../../../../core/widgets/movie/smallCard.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(
    viewportFraction: 0.58,
    initialPage: 0,
  );

  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(MovieService())..getMovies(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Scaffold(
              backgroundColor: Appcolor.black,
              body: Center(
                child: CircularProgressIndicator(
                  color: Appcolor.gray,
                ),
              ),
            );
          }

          if (state is HomeFailure) {
            return Scaffold(
              backgroundColor: Appcolor.black,
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Appcolor.white,
                  ),
                  textAlign: TextAlign.center,
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
                    style: TextStyle(
                      color: Appcolor.white,
                    ),
                  ),
                ),
              );
            }

            final selectedMovie =
            movies[currentPage.clamp(0, movies.length - 1)];

            final actionMovies = movies.where((movie) {
              return movie.genres?.any(
                    (genre) =>
                genre.toLowerCase() == 'action',
              ) ??
                  false;
            }).toList();

            final displayActionMovies =
            actionMovies.isNotEmpty
                ? actionMovies
                : movies;

            return Scaffold(
              backgroundColor: Appcolor.black,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 560,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              child: Image.network(
                                selectedMovie.mediumCoverImage ??
                                    '',
                                key: ValueKey(
                                  'background_${selectedMovie.id}',
                                ),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                    ) {
                                  return Container(
                                    color: Appcolor.black,
                                  );
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
                                color: Colors.black.withOpacity(
                                  0.60,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Image.asset(
                                  Appimages.availableNow,
                                  width: 260,
                                  height: 93,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 300,
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: movies.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      currentPage = index;
                                    });
                                  },
                                  itemBuilder: (
                                      context,
                                      index,
                                      ) {
                                    final movie = movies[index];

                                    final isSelected =
                                        index == currentPage;

                                    return AnimatedScale(
                                      duration:
                                      const Duration(
                                        milliseconds: 250,
                                      ),
                                      scale: isSelected
                                          ? 1
                                          : 0.82,
                                      child: MovieCard(
                                        movie: movie,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Image.asset(
                                  Appimages.watchNow,
                                  width: 350,
                                  height: 120,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Action',
                            style: TextStyle(
                              color: Appcolor.white,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              'See More →',
                              style: TextStyle(
                                color: Appcolor.yellow,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        itemCount: displayActionMovies.length,
                        itemBuilder: (context, index) {
                          return SmallCard(
                            movie: displayActionMovies[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
  }
}
