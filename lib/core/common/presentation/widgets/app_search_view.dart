import 'dart:async';

import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSearchView extends StatelessWidget {
  final String? searchHint;
  final double? padding;
  final searchController = TextEditingController();
  final Function(String searchTerm) onSearchTermChanged;
  final Function()? onCancel;
  final Function()? onTap;
  final bool? autoFocus;
  final Color? textInputBackground;
  final double? borderRadius;
  final String? cancelLabel;

  AppSearchView(
      {super.key,
      this.searchHint,
      required this.onSearchTermChanged,
      this.onCancel,
      this.borderRadius,
      this.textInputBackground,
      this.autoFocus,
      this.onTap,
      this.cancelLabel,
      this.padding});

  @override
  Widget build(BuildContext context) {
    Timer? debounce;

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.only(
              left: padding ?? 24,
              right: padding ?? 24,
            ),
            child: TextFormField(
              onTap: onTap,
              textInputAction:
                  TextInputAction.done, // Set it to TextInputAction.done

              controller: searchController,
              onChanged: (changedText) {
                if (debounce?.isActive ?? false) {
                  debounce?.cancel(); // Cancel any previous timer
                }
                debounce = Timer(const Duration(milliseconds: 500), () {
                  if (changedText.length > 2) {
                    onSearchTermChanged(changedText);
                  }
                });
              },
              autofocus: autoFocus ?? false,

              keyboardType: TextInputType.text,
              maxLines: 1,

              style: const TextStyle(
                  fontSize: 17.0,
                  fontFamily: app_font,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: searchHint,
                prefixIcon: const Icon(CupertinoIcons.search),
                fillColor: textInputBackground ?? kTextInputBackgroundColor,
                contentPadding: const EdgeInsets.all(10.0),
                labelStyle: const TextStyle(
                  color: Color(0xff979797),
                  fontSize: 17.0,
                  fontFamily: app_font,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  borderRadius ?? 16,
                )).copyWith(
                    borderSide: const BorderSide(
                  width: 2.0,
                )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        onCancel != null
            ? Expanded(
                flex: 1,
                child: AppTextViewSubtitleSmall(
                  fontSize: 15,
                  weight: FontWeight.w400,
                  onTap: () {
                    searchController.text = '';
                    onCancel!();
                  },
                  text: cancelLabel ?? 'Cancel',
                  textAlign: TextAlign.start,
                ))
            : const SizedBox.shrink(),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
