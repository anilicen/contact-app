import 'dart:async';

import 'package:contact_app/constants.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/text_styles.dart';
import 'package:contact_app/widgets/delete_account_bottom_sheet.dart';
import 'package:contact_app/widgets/edit_contact_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<Widget> showProfileModalBottomSheet(
  BuildContext context,
  Contact contact,
  Function(String) deleteContact,
  Function(XFile) setImage,
  Function(String, Contact) editContact,
) async {
  Size size = MediaQuery.of(context).size;
  final padding = MediaQuery.of(context).padding;
  return await showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Container(
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
          height: size.height - padding.top - padding.bottom - 20,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: getMedium16(color: cpBlue),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showEditContactBottomSheet(
                        context,
                        setImage,
                        contact,
                        editContact,
                      );
                    },
                    child: Text(
                      "Edit",
                      style: getBold16(color: cpBlue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              contact.profileImageUrl == null
                  ? SvgPicture.asset(
                      'assets/contact.svg',
                      height: 195,
                      width: 195,
                    )
                  : ClipOval(
                      child: Image.network(
                        contact.profileImageUrl!,
                        height: 195,
                        width: 195,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 65),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (contact.firstName != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.firstName!,
                          style: getBold16(),
                        ),
                        const SizedBox(height: 30, child: Divider()),
                      ],
                    ),
                  if (contact.lastName != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.lastName!,
                          textAlign: TextAlign.center,
                          style: getBold16(),
                        ),
                        const SizedBox(height: 30, child: Divider()),
                      ],
                    ),
                  if (contact.phoneNumber != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.phoneNumber!,
                          style: getBold16(),
                        ),
                        const SizedBox(height: 30, child: Divider()),
                      ],
                    ),
                  GestureDetector(
                    child: Text(
                      "Delete Contact",
                      style: getBold16(color: cpRed),
                    ),
                    onTap: () async {
                      await deleteAccountBottomSheet(context, deleteContact, contact.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
