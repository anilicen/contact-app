import 'package:contact_app/constants.dart';
import 'package:contact_app/text_styles.dart';
import 'package:contact_app/widgets/pop_up_bottom_sheet.dart';
import 'package:contact_app/widgets/small_sheet_text_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future deleteAccountBottomSheet(BuildContext context, Function(String) deleteAccount, String id) {
  Size size = MediaQuery.of(context).size;

  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: cpWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      height: 250,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Delete Account?",
            style: getBold24(color: cpRed),
          ),
          SizedBox(height: 25),
          SmallSheetTextButton(
            text: "Yes",
            textColor: cpBlack,
            onTap: () async {
              await deleteAccount(id);
              Navigator.pop(context);
              Navigator.pop(context);
              popUpBottomSheet(context, "Account Deleted!");
            },
          ),
          SizedBox(height: 15),
          SmallSheetTextButton(text: "No", textColor: cpBlack, onTap: () => Navigator.pop(context)),
        ],
      ),
    ),
  );
}
