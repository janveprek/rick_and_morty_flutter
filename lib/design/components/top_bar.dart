import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';

var logger = Logger();

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget Function(BuildContext)? actions;

  const TopBar({Key? key, this.title = '', this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(title),
      ),
      actions: [if (actions != null) actions!(context)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onQueryChange;
  final Function(String) onSearch;

  // final Widget searchListContent;
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppSearchBarState extends State<AppSearchBar> {
  // final SearchController _controller = SearchController();
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
        return SearchBar(
            hintText: "Search characters",
            onTap: () {
              controller.openView();
            },
            onChanged: (text) {
              widget.onQueryChange(text);
              controller.openView();
            },
            onSubmitted: (text) {
              widget.onSearch(text);
              controller.closeView(text);
            },
            leading: const Icon(Icons.search),
            trailing: controller.text.isNotEmpty
                ? <Widget>[
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        widget.onSearch(controller.text);
                      },
                    ),
                  ]
                : null);
      },
      suggestionsBuilder:
          (BuildContext context, SearchController controller) async {
        _searchingWithQuery = controller.text;
        final List<String> options =
            widget.characters.map((e) => e.name).toList();
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

//
// @override
// Widget build(BuildContext context) {
//   return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SearchAnchor(
//         builder: (BuildContext context) {
//           return SearchBar(
//                   controller: controller,
//                   padding: const MaterialStatePropertyAll<EdgeInsets>(
//                       EdgeInsets.all(16.0)),
//                   hintText: AppLocalizations.of(context)!.search_hint,
//                   onTap: () {
//                     controller.openView();
//                   },
//                   onChanged: (query) {
//                     // setState(() => _isActive = query.isNotEmpty);
//                     logger.d("changed: $query");
//                     widget.onQueryChange(query);
//                     controller.openView();
//                   },
//                   onSubmitted: (query) {
//                     logger.d("submitted: $query");
//                     widget.onQueryChange(query);
//                     controller.closeView(query);
//                   },
//                   leading: const Icon(Icons.search),
//                   trailing: controller.text.isNotEmpty
//                       ? <Widget>[
//                           Tooltip(
//                               child: IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               controller.clear();
//                               widget.onSearch(controller.text);
//                             },
//                           )),
//                         ]
//                       : null,
//                 );
//                 // IconButton(
//                 //   icon: Icon(Icons.tune),
//                 //   onPressed: widget.onFilterClick,
//                 // ),
//         },
//         suggestionsBuilder:
//             (BuildContext context, SearchController controller) {
//             return ListView<ListTile>.builder(itemBuilder: (context, index) {
//               var character = state.characters[index];
//               return Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: CharacterCard(
//                     character: character,
//                     onCharacterClick: (index) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               CharacterDetailScreen(id: character.id),
//                         ),
//                       );
//                     },
//                     onCharacterLongClick: (character) =>
//                         onCharacterLongClick(character),
//                   ));
//             },
//
//               //   .builder(
//               //   itemCount: state.characters.length,
//               //   itemBuilder: (context, index) {
//               //     var character = state.characters[index];
//               //     return Padding(
//               //         padding: const EdgeInsets.all(4.0),
//               //         child: CharacterCard(
//               //           character: character,
//               //           onCharacterClick: (index) {
//               //             Navigator.push(
//               //               context,
//               //               MaterialPageRoute(
//               //                 builder: (context) =>
//               //                     CharacterDetailScreen(id: character.id),
//               //               ),
//               //             );
//               //           },
//               //           onCharacterLongClick: (character) =>
//               //               onCharacterLongClick(character),
//               //         ));
//               //   },
//               // ),
//
//           // return [
//           //   CharacterSearchList(
//           //       characters: widget.characters, onCharacterClick: (int) {})
//           // ];
//         },
//       ));
//
// ,
//
// suggestionsBuilder
//
//     :
//
// (BuildContext context, SearchController controller) {
// return List<ListTile>.generate(5, (int index) {
// final String item = 'item $index';
// return ListTile(
// title: Text(item),
// onTap: () {
// setState(() {
// controller.closeView(item);
// });
// },
// );
// });
// })
//
// ,
//
// Row
//
// (
//
// children: [
// Expanded(
// child: TextField(
// controller: _controller,
// onChanged: (value) {
// setState(() => _isActive = value.isNotEmpty);
// widget.onQueryChange(value);
// },
// decoration: InputDecoration(
// hintText: 'Search...',
// prefixIcon: IconButton(
// icon: _isActive
// ? const Icon(Icons.arrow_back_ios_new)
//     : const Icon(Icons.search),
// onPressed: () {
// setState(() => _isActive = false);
// widget.onSearch(_controller.text);
// },
// ),
// suffixIcon: _controller.text.isNotEmpty
// ? IconButton(
// icon: const Icon(Icons.close),
// onPressed: () => setState(() {
// _controller.clear();
// widget.onSearch('');
// }),
// )
//     : null,
// ),
// ),
// ),
// IconButton(
// icon: const Icon(Icons.tune),
// onPressed: widget.onFilterClick,
// )
//
// ,
//
// ]
//
// ,
//
// );
// }
// }
