import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_flutter/design/components/favorite_icon.dart';

void main() {
  testWidgets('FavouriteIcon changes icon', (WidgetTester tester) async {
    final favorite = ValueNotifier<bool>(true);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder<bool>(
            valueListenable: favorite,
            builder: (context, isFavourite, child) {
              return FavouriteIcon(
                isFavourite: isFavourite,
                onClick: () {
                  favorite.value = !favorite.value;
                },
              );
            },
          ),
        ),
      ),
    );
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
