import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/character_detail_view_model.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/state/character_detail_state.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';
import 'package:rick_and_morty_flutter/design/components/error_screen.dart';
import 'package:rick_and_morty_flutter/design/components/top_bar.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';
import 'package:rick_and_morty_flutter/locator.dart';

const double avatarSizeInDp = 120.0;

class CharacterDetailScreen extends StatefulWidget {
  final int id;

  const CharacterDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            locator<CharacterDetailViewModel>(param1: widget.id),
        child: Consumer<CharacterDetailViewModel>(
          builder: (context, viewModel, child) {
            CharacterDetailState characterDetailState =
                viewModel.characterState;
            if (characterDetailState.state is LoadingState) {
              return const CircularProgressIndicator();
            }

            if (characterDetailState.state is ErrorState) {
              return ErrorScreen(tryAgain: () {});
            }

            return CharacterDetailScreenContent(state: characterDetailState);
          },
        ));
  }
}

class CharacterDetailScreenContent extends StatelessWidget {
  final CharacterDetailState state;

  const CharacterDetailScreenContent({Key? key, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = state.character;

    return Scaffold(
        appBar: TopBar(title: character?.name ?? ""),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              if (character != null) ...[
                Header(name: character.name, iconUrl: character.iconUrl),
                const Divider(),
                InfoPair(title: "Status", value: character.status),
                InfoPair(title: "Species", value: character.species),
                InfoPair(title: "Type", value: character.type),
                InfoPair(title: "Gender", value: character.gender),
                InfoPair(title: "Origin", value: character.origin),
                InfoPair(title: "Location", value: character.location),
              ],
            ])));
  }
}

class InfoPair extends StatelessWidget {
  final String title;
  final String value;

  const InfoPair({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: paddingMedium,
        vertical: paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String name;
  final String iconUrl;

  const Header({Key? key, required this.name, required this.iconUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadiusSmall),
          child: Image.network(
            iconUrl,
            width: avatarSizeInDp,
            height: avatarSizeInDp,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(),
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
