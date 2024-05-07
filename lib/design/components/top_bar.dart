import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget Function(BuildContext)? actions;

  const TopBar({Key? key, this.title = '', this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [if (actions != null) actions!(context)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onQueryChange;
  final Function(String) onSearch;

  final VoidCallback onFilterClick;
  final List<CharacterModel> characters;

  AppSearchBar(
      {Key? key,
      required this.onQueryChange,
      required this.onSearch,
      required this.onFilterClick,
      required this.characters})
      : super(key: key);

  @override
  _AppSearchBarState createState() => _AppSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _AppSearchBarState extends State<AppSearchBar> {
  final SearchController _controller = SearchController();
  String? _searchingWithQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: paddingSmall),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: SearchBar(
                      controller: _controller,
                      hintText: AppLocalizations.of(context)!.search_hint,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: paddingMedium)),
                      onChanged: (text) {
                        widget.onSearch(text);
                        _controller.text = text;
                      },
                      onSubmitted: (text) {
                        widget.onSearch(text);
                        _controller.text = text;
                      },
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      leading: const Icon(Icons.search),
                      trailing: _controller.text.isNotEmpty
                          ? <Widget>[
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _controller.clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  widget.onSearch(_controller.text);
                                },
                              ),
                            ]
                          : null)),
              SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: widget.onFilterClick,
                  ))
            ]));
  }
}
