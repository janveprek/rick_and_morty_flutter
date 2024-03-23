import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';

class FavouriteIcon extends StatelessWidget {
  final bool isFavourite;
  final VoidCallback onClick;

  const FavouriteIcon({
    Key? key,
    required this.isFavourite,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          size: iconSizeSmall,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}