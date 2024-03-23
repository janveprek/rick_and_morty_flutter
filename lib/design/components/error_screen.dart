import 'package:flutter/material.dart';

import '../dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback tryAgain;

  const ErrorScreen({Key? key, required this.tryAgain}) : super(key: key);

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
              AppLocalizations.of(context)!.error_title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: paddingExtraLarge),
            Icon(
              Icons.error_outline,
              size: iconSizeLarge,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: paddingExtraLarge),
            Text(
              AppLocalizations.of(context)!.error_text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: paddingExtraLarge),
            ElevatedButton(
              onPressed: tryAgain,
              // style: ElevatedButton.styleFrom(
              //   foregroundColor: Theme.of(context).colorScheme.onPrimary, backgroundColor: Theme.of(context).colorScheme.primary,
              // ),
              child: Text(
                AppLocalizations.of(context)!.try_again,
              ),
            ),
          ],
        )));
  }
}
