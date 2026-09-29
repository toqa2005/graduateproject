import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/features/search/data/search_repo.dart';
import 'package:graduateproject/features/search/presentation/cubit/search_cubit.dart';
import 'package:graduateproject/features/search/presentation/cubit/search_state.dart';
import '../../../../core/widgets/custom/CustomField.dart';
import '../customs/empty_search.dart';
import '../customs/searchPlaceholder.dart';
import '../customs/search_error.dart';
import '../customs/search_movie.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(SearchRepository()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _search(String value) {
    setState(() {});

    context.read<SearchCubit>().search(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: CustomField(
                controller: _controller,
                hintText: 'Search',
                icon: Icons.search,
                onChanged: _search,
                keyboardType: TextInputType.text,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Appcolor.yellow,
                        strokeWidth: 2,
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    return MovieSearch(movies: state.movies);
                  }

                  if (state is SearchEmpty) {
                    return EmptySearch(query: state.query);
                  }

                  if (state is SearchFailure) {
                    return SearchError(
                      message: state.message,
                      onRetry: () {
                        final query = _controller.text.trim();

                        if (query.isNotEmpty) {
                          context.read<SearchCubit>().searchMovies(query);
                        }
                      },
                    );
                  }
                  return const SearchPlaceholder();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
