import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterBottomSheet extends StatefulWidget {
  final bool open;
  late StatusFilter selected;
  final void Function(StatusFilter) onSubmitClick;
  final VoidCallback onDismissRequest;

  FilterBottomSheet({
    Key? key,
    required this.open,
    required this.selected,
    required this.onSubmitClick,
    required this.onDismissRequest,
  }) : super(key: key);

  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<StatusFilter> listOptions = [
    StatusFilter.all,
    StatusFilter.unknown,
    StatusFilter.dead,
    StatusFilter.alive
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.status,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: paddingMedium),
            RadioListTile<StatusFilter>(
              title: Text("all"),
              value: StatusFilter.all,
              groupValue: widget.selected,
              onChanged: (value) {
                setState(() {
                  widget.selected = value!;
                });
              },
            ),
            RadioListTile<StatusFilter>(
              title: Text("unknown"),
              value: StatusFilter.unknown,
              groupValue: widget.selected,
              onChanged: (value) {
                setState(() {
                  widget.selected = value!;
                });
              },
            ),
            RadioListTile<StatusFilter>(
              title: Text("alive"),
              value: StatusFilter.alive,
              groupValue: widget.selected,
              onChanged: (value) {
                setState(() {
                  widget.selected = value!;
                });
              },
            ),
            RadioListTile<StatusFilter>(
              title: Text("dead"),
              value: StatusFilter.dead,
              groupValue: widget.selected,
              onChanged: (value) {
                setState(() {
                  widget.selected = value!;
                });
              },
            ),

            const SizedBox(height: paddingMedium),
            ElevatedButton(
              onPressed: () {
                widget.onSubmitClick(widget.selected);
                widget.onDismissRequest();
              },
              child: const Text('Submit'),
            ),
          ],
        ));
  }
}
