import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty_flutter/character/presentation/favorite/favorite_characters_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../character/presentation/list/character_list_screen.dart';

class BottomBar extends StatelessWidget {
  final int currentPageIndex;

  const BottomBar({
    Key? key,
    required this.currentPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CharacterListScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FavoriteCharactersScreen()),
          );
        }
      },
      selectedIndex: currentPageIndex,
      destinations: <Widget>[
        NavigationDestination(
          icon: SvgPicture.asset(
                'assets/icons/characters_all.svg',
                semanticsLabel: 'Characters'
            ),
          label: AppLocalizations.of(context)!.bottom_bar_characters,
        ),
        NavigationDestination(
          icon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context)!.bottom_bar_favourites,
        ),
      ],
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final IconData icon;
  final VoidCallback onClick;

  const BottomBarItem({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          ),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
