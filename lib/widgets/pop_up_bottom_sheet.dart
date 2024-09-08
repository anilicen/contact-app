import 'package:contact_app/constants.dart';
import 'package:contact_app/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future popUpBottomSheet(BuildContext context, String text) {
  Size size = MediaQuery.of(context).size;

  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
          color: cpWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ]),
      height: 84,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          SvgPicture.asset('assets/tick_mark.svg'),
          const SizedBox(width: 15),
          Text(
            text,
            style: getBold16(color: cpGreen),
          ),
        ],
      ),
    ),
  );
}
