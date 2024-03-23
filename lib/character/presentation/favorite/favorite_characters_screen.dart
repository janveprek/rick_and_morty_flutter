import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/character_detail_screen.dart';
import 'package:rick_and_morty_flutter/character/presentation/favorite/favorite_characters_view_model.dart';
import 'package:rick_and_morty_flutter/character/presentation/favorite/state/favorite_characters_state.dart';
import 'package:rick_and_morty_flutter/design/components/bottom_bar.dart';
import 'package:rick_and_morty_flutter/design/components/card.dart';
import 'package:rick_and_morty_flutter/design/components/empty_screen.dart';
import 'package:rick_and_morty_flutter/design/components/error_screen.dart';
import 'package:rick_and_morty_flutter/design/components/loading_screen.dart';
import 'package:rick_and_morty_flutter/design/components/top_bar.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';
import 'package:rick_and_morty_flutter/locator.dart';

class FavoriteCharactersScreen extends StatefulWidget {
  const FavoriteCharactersScreen({Key? key}) : super(key: key);

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<FavoriteCharactersScreen> {
  late FavoriteCharactersViewModel viewModel;

  void navigateToDetail(int characterId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoriteCharactersScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel = locator<FavoriteCharactersViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => locator<FavoriteCharactersViewModel>(),
        child: Consumer<FavoriteCharactersViewModel>(
            builder: (context, viewModel, child) {
          FavoriteCharactersState charactersState = viewModel.charactersState;
          return characterListScreenContent(
            state: charactersState,
            navigateToDetail: navigateToDetail,
            toggleFavourite: viewModel.toggleFavourite,
            applyFilters: (filter) {},
            onSearch: viewModel.search,
            openBottomSheet: () {},
            closeBottomSheet: () {},
          );
        }));
  }
}

Widget characterListScreenContent({
  required FavoriteCharactersState state,
  required Function(int) navigateToDetail,
  required Function(CharacterModel) toggleFavourite,
  required Function(String) onSearch,
  required Function(StatusFilter) applyFilters,
  required VoidCallback openBottomSheet,
  required VoidCallback closeBottomSheet,
}) {
  return SafeArea(
      child: Scaffold(
    appBar: AppSearchBar(
      onSearch: onSearch,
      onQueryChange: onSearch,
      onFilterClick: openBottomSheet,
      characters: state.characters,
    ),
    body: CharacterList(
      state: state,
      onCharacterClick: navigateToDetail,
      onCharacterLongClick: toggleFavourite,
    ),
    bottomNavigationBar: const BottomBar(currentPageIndex: 1),
    // body: FilterBottomSheet(
    //   open: state.openBottomSheet,
    //   selected: state.appliedFilter,
    //   onDismissRequest: closeBottomSheet,
    //   onSubmitClick: applyFilters,
    //   //... other parameters
    // ),
  ));
}

class CharacterList extends StatelessWidget {
  final FavoriteCharactersState state;
  final Function(int) onCharacterClick;
  final Function(CharacterModel) onCharacterLongClick;

  const CharacterList({
    Key? key,
    required this.state,
    required this.onCharacterClick,
    required this.onCharacterLongClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (state.state is LoadingState) CharacterShimmerList(),
        if (state.state is ErrorState) ErrorScreen(tryAgain: () {}),
        if (state.state is EmptyState) const EmptyScreen(),
        if (state.state is SuccessState)
          Expanded(
            child: ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                var character = state.characters[index];
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CharacterCard(
                      character: character,
                      onCharacterClick: (index) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CharacterDetailScreen(id: character.id),
                          ),
                        );
                      },
                      onCharacterLongClick: (character) =>
                          onCharacterLongClick(character),
                    ));
              },
            ),
          ),
      ],
    );
  }
}
