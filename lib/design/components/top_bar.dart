import 'package:flutter/material.dart';
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
      title:  Text(title),
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
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingSmall),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: SearchBar(
                          hintText: AppLocalizations.of(context)!.search_hint,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: paddingMedium)),
                          onTap: () {
                            _controller.openView();
                          },
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
      },
      suggestionsBuilder:
          (BuildContext context, SearchController controller) async {
        _searchingWithQuery = controller.text;
        final List<String> options = widget.characters.map((e) => e.name).toList();
        if (_searchingWithQuery != controller.text) {
          return _lastOptions;
        }
        _lastOptions = List<ListTile>.generate(options.length, (int index) {
          final String item = options[index];
          return ListTile(
            title: Text(item),
          );
        });
        return _lastOptions;
      },
    );
  }
}