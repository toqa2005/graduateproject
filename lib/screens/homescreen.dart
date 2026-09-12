import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graduateproject/services/movie_service.dart';

import '../cusoms/movie/SmallCard.dart';
import '../cusoms/movie/moviecard.dart';
import '../models/movie_model.dart';
import '../utils/Appimages.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MovieModel> moviesFuture;

  final PageController pageController = PageController(
    viewportFraction: 0.58,
    initialPage: 0,
  );

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    moviesFuture = MovieService().getMovies();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: FutureBuilder<MovieModel>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Appcolor.gray,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  color: Appcolor.white,
                ),
              ),
            );
          }

          final movies = snapshot.data?.data?.movies ?? [];

          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'No Movies Found',
                style: TextStyle(
                  color: Appcolor.white,
                ),
              ),
            );
          }

          final selectedMovie = movies[
          currentPage.clamp(0, movies.length - 1)
          ];

          final actionMovies = movies.where((movie) {
            return movie.genres?.any(
                  (genre) => genre.toLowerCase() == 'action',
            ) ??
                false;
          }).toList();

          final displayActionMovies =
          actionMovies.isNotEmpty ? actionMovies : movies;

          return SingleChildScrollView(
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
                            selectedMovie.mediumCoverImage ?? '',
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
                            color: Colors.black.withOpacity(0.60),
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
                              itemBuilder: (context, index) {
                                final movie = movies[index];

                                final isSelected =
                                    index == currentPage;

                                return AnimatedScale(
                                  duration: const Duration(
                                    milliseconds: 250,
                                  ),
                                  scale: isSelected ? 1 : 0.82,
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
          );
        },
      ),
    );
  }
}
