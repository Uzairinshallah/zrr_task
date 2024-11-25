import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final Color? background;
  final Function()? onPressed;
  final bool? isEnable;

  const CustomButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.textSize,
    this.background,
    this.onPressed,
    required this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (isEnable == true) ? onPressed : null,
        child: Tooltip(
          message: text,
          child: Container(
            width: double.infinity,
            height: 54,
            decoration: ShapeDecoration(
              color: (background != null)
                  ? background
                  : (isEnable == true)
                      ? AppColors.primaryColor
                      : AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: text,
                        size: textSize ?? 17,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
