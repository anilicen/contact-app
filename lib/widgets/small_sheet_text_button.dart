import 'package:contact_app/constants.dart';
import 'package:contact_app/text_styles.dart';
import 'package:flutter/material.dart';

class SmallSheetTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function() onTap;
  const SmallSheetTextButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: getBold24(color: textColor)),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
