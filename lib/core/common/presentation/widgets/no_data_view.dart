import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small_no_tap.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView(
      {super.key,
      required this.errorMessage,
      this.onActionClicked,
      this.buttonLabel});

  final String errorMessage;
  final Function()? onActionClicked;
  final String? buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              'assets/images/nodata.jpg',
              height: 120,
              width: 120,
            ),
          ),
        ),
        AppTextViewSubtitleSmall(
          text: errorMessage,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: app_padding,
        ),
        onActionClicked != null
            ? ElevatedButton(
                onPressed: onActionClicked,
                child: AppTextViewSubtitleSmallNoTap(
                    text: buttonLabel ?? 'Try Again',
                    textAlign: TextAlign.center))
            : const SizedBox.shrink(),
        const SizedBox(
          height: app_padding,
        ),
      ],
    );
  }
}
