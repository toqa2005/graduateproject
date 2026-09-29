import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';
import '../cubit/browse_cubit.dart';
import '../cubit/browse_state.dart';

class Geners extends StatelessWidget {
  const Geners({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: BlocBuilder<BrowseCubit, BrowseState>(
        builder: (context, state) {
          List<String> genres = [];
          String selectedGenre = 'Action';

          if (state is BrowseSuccess) {
            genres = state.genres;
            selectedGenre = state.selectedGenre;
          } else if (state is BrowseLoading) {
            genres = state.genres;
            selectedGenre = state.selectedGenre;
          } else if (state is BrowseFailure) {
            genres = state.genres;
            selectedGenre = state.selectedGenre;
          }

          if (genres.isEmpty) {
            return const SizedBox();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: genres.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              final genre = genres[index];

              final selected = selectedGenre == genre;

              return GestureDetector(
                onTap: () {
                  context.read<BrowseCubit>().changeGenre(genre);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Appcolor.yellow : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Appcolor.yellow, width: 1),
                  ),
                  child: Text(
                    genre,
                    style: TextStyle(
                      color: selected ? Appcolor.black : Appcolor.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
