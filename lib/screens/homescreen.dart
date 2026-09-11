import 'package:flutter/material.dart';
import 'package:graduateproject/models/responce.dart';
import 'package:graduateproject/services/movie_service.dart';
import '../cusoms/BottomNav.dart';
import '../cusoms/movie/SmallCard.dart';
import '../cusoms/movie/moviecard.dart';
import '../utils/Appimages.dart';
import '../utils/colors.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late Future<MoviesResponseModel> moviesFuture;

  final PageController pageController = PageController(
    viewportFraction: 0.58,
    initialPage: 0,
  );
  int currentPage = 0;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    moviesFuture = MovieService().getMovies();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page != currentPage) {
        setState(() {
          currentPage = page;
        });
      }
    });
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Appcolor.black,
      body: FutureBuilder<MoviesResponseModel>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
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

          if (!snapshot.hasData ||
              snapshot.data!.data.movies.isEmpty) {
            return const Center(
              child: Text(
                'No Movies Found',
                style: TextStyle(
                  color: Appcolor.white,
                ),
              ),
            );
          }
          final movies = snapshot.data!.data.movies;
          final actionMovies = movies.where((movie) {
            return movie.genres.any(
                  (genre) =>
              genre.toLowerCase() == 'action',
            );
          }).toList();
          final displayActionMovies =
          actionMovies.isNotEmpty
              ? actionMovies
              : movies;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 560,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          Appimages.background,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned.fill(
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.8),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          Center(
                            child: Image.asset(
                              Appimages.availableNow,
                              width: 260,
                              height: 93,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 300,
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: movies.length,
                              itemBuilder:
                                  (context, index) {
                                final movie =
                                movies[index];
                                final isSelected =
                                    index ==
                                        currentPage;
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

                          const SizedBox(height: 5),

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
                const SizedBox(height: 20),
                Container(
                  color: Appcolor.black,
                  child: Padding(
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
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection:
                    Axis.horizontal,
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount:
                    displayActionMovies.length,
                    itemBuilder: (context, index) {
                      return SmallCard(
                        movie:
                        displayActionMovies[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}