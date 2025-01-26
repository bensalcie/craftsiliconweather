
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_subtitle.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';

class AppRatingBar extends StatelessWidget {
  final int rating;
  const AppRatingBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(elements_padding),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            if (index < rating) {
              return const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              );
            } else {
              return const Icon(
                Icons.star_border,
                color: Colors.yellow,
                size: 15,
              );
            }
          }),
        ),
        AppTextViewSubtitle(
          text: '(102)',
          paddingleft: 2,
          fontSize: 10,
          textColor: kRatingCountTextColor,
          textAlign: TextAlign.start,
          weight: FontWeight.w400,
        )
      ]),
    );
  }
}
