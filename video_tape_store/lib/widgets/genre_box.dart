import 'package:flutter/material.dart';
import 'package:video_tape_store/style/style.dart';

class GenreBox extends StatelessWidget {
  final String? genre;
  final bool isSelected;

  const GenreBox({super.key, this.genre, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
        color: isSelected ? Colors.red : Theme.of(context).colorScheme.primary,
      ),
      padding: const EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Text(
        genre ?? '',
        style: AppTextStyle.small2(context),
      ),
    );
  }
}
