import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(paddingMedium),
        child: Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.empty_title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: paddingExtraLarge),
            Icon(
              Icons.error,
              size: iconSizeLarge,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: paddingExtraLarge),
            Text(
              AppLocalizations.of(context)!.empty_text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )));
  }
}
