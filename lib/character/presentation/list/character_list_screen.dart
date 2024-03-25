import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/character_detail_screen.dart';
import 'package:rick_and_morty_flutter/character/presentation/list/character_list_view_model.dart';
import 'package:rick_and_morty_flutter/design/components/filter_bottom_sheet.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';
import 'package:rick_and_morty_flutter/design/components/card.dart';
import 'package:rick_and_morty_flutter/design/components/empty_screen.dart';
import 'package:rick_and_morty_flutter/design/components/error_screen.dart';
import 'package:rick_and_morty_flutter/design/components/top_bar.dart';
import 'package:rick_and_morty_flutter/locator.dart';

import '../../../design/components/bottom_bar.dart';
import '../../../design/components/loading_screen.dart';
import 'state/character_list_state.dart';

var logger = Logger();

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late CharactersListViewModel viewModel;

  void navigateToDetail(int characterId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CharacterDetailScreen(id: 0)),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel = locator<CharactersListViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => locator<CharactersListViewModel>(),
        child: Consumer<CharactersListViewModel>(
            builder: (context, viewModel, child) {
          CharacterListState characterListState = viewModel.charactersState;
          return characterListScreenContent(
            state: characterListState,
            navigateToDetail: navigateToDetail,
            toggleFavourite: viewModel.toggleFavourite,
            onTryAgainClick: viewModel.updateCharacters,
            applyFilters: (filter) {},
            onSearch: viewModel.search,
            openBottomSheet: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                      height: 400,
                      child: FilterBottomSheet(
                        open: true,
                        onDismissRequest: () => Navigator.pop(context),
                        selected: viewModel.charactersState.appliedFilter,
                        onSubmitClick: (filter) => {
                          viewModel.applyFilter(filter),
                        },
                      ));
                },
              );
            },
            closeBottomSheet: () {},
          );
        }));
  }
}

Widget characterListScreenContent({
  required CharacterListState state,
  required Function(int) navigateToDetail,
  required Function(CharacterModel) toggleFavourite,
  required Function(String) onSearch,
  required Function(StatusFilter) applyFilters,
  required VoidCallback onTryAgainClick,
  required VoidCallback openBottomSheet,
  required VoidCallback closeBottomSheet,
}) {
  return SafeArea(
      child: Scaffold(
    appBar: AppSearchBar(
        onSearch: onSearch,
        onQueryChange: onSearch,
        characters: state.characters,
        onFilterClick: openBottomSheet),
    body: CharacterList(
      state: state,
      onCharacterClick: navigateToDetail,
      onCharacterLongClick: toggleFavourite,
      onTryAgainClick: onTryAgainClick,
    ),
    bottomNavigationBar: const BottomBar(currentPageIndex: 0),
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
  final CharacterListState state;
  final Function(int) onCharacterClick;
  final Function(CharacterModel) onCharacterLongClick;
  final VoidCallback onTryAgainClick;

  const CharacterList({
    Key? key,
    required this.state,
    required this.onCharacterClick,
    required this.onCharacterLongClick,
    required this.onTryAgainClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d("listScreen");
    return Column(
      children: [
        if (state.state is LoadingState) CharacterShimmerList(),
        if (state.state is ErrorState) ErrorScreen(tryAgain: onTryAgainClick),
        if (state.state is EmptyState) const EmptyScreen(),
        if (state.state is SuccessState)
          Expanded(
            child: ListView.separated(
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  var character = state.characters[index];
                  return CharacterCard(
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      height: paddingSmall,
                    )),
          ),
      ],
    );
  }
}
