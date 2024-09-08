import 'dart:async';
import 'dart:io';

import 'package:contact_app/constants.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/text_styles.dart';
import 'package:contact_app/widgets/bottom_sheet_text_field.dart';
import 'package:contact_app/widgets/photo_bottom_sheet.dart';
import 'package:contact_app/widgets/pop_up_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<Widget> showEditContactBottomSheet(
  BuildContext context,
  Function(XFile) setImage,
  Contact contact,
  Function(String, Contact) editContact,
) async {
  Size size = MediaQuery.of(context).size;
  final padding = MediaQuery.of(context).padding;
  XFile? image;
  bool isJustAdded = false;

  return await showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        setImageForEditContactBottomSheet(XFile value) {
          setState(() {
            image = value;
          });
        }

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
                    onPressed: () async {
                      if (!(contact.firstName!.isEmpty && contact.lastName!.isEmpty && contact.phoneNumber!.isEmpty)) {
                        print("First NAme ${contact.firstName}");
                        print("Last Name ${contact.lastName}");
                        print("Phone Number ${contact.phoneNumber}");
                        await editContact(contact.id, contact);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        popUpBottomSheet(context, "Changes have been applied!");
                      }
                    },
                    child: Text(
                      "Done",
                      style: (contact.firstName!.isEmpty && contact.lastName!.isEmpty && contact.phoneNumber!.isEmpty)
                          ? getMedium16(color: cpGray)
                          : getBold16(color: cpBlue),
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
                  : isJustAdded
                      ? ClipOval(
                          child: Image.file(
                            File(contact.profileImageUrl!),
                            height: 195,
                            width: 195,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            contact.profileImageUrl!,
                            height: 195,
                            width: 195,
                            fit: BoxFit.cover,
                          ),
                        ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: () async {
                  await showPhotoBottomSheet(context, setImage, setImageForEditContactBottomSheet);
                  contact = contact.copyWith(profileImageUrl: image!.path);
                  isJustAdded = true;
                  setState(() {});
                },
                child: Text(
                  "Add Photo",
                  style: getBold16(),
                ),
              ),
              const SizedBox(height: 20),
              EditBottomSheetTextField(
                hintText: "First Name",
                onChanged: (val) {
                  contact = contact.copyWith(firstName: val);
                  setState(() {});
                },
                initialValue: contact.firstName!,
                index: 0,
              ),
              const SizedBox(height: 20),
              EditBottomSheetTextField(
                index: 1,
                hintText: "Last Name",
                onChanged: (val) {
                  contact = contact.copyWith(lastName: val);
                  setState(() {});
                },
                initialValue: contact.lastName!,
              ),
              const SizedBox(height: 20),
              EditBottomSheetTextField(
                index: 2,
                hintText: "Phone Number",
                onChanged: (val) {
                  contact = contact.copyWith(phoneNumber: val);
                  setState(() {});
                },
                initialValue: contact.phoneNumber!,
              ),
            ],
          ),
        );
      },
    ),
  );
}
