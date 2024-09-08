import 'dart:async';
import 'dart:io';

import 'package:contact_app/constants.dart';
import 'package:contact_app/text_styles.dart';
import 'package:contact_app/widgets/photo_bottom_sheet.dart';
import 'package:contact_app/widgets/pop_up_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<Widget> showAddContactBottomSheet(
  BuildContext context,
  Function(String) setName,
  Function(String) setSurname,
  Function(String) setPhoneNumber,
  Function(XFile) setImage,
  Function() createContact,
  Function() isValidToCreate,
) async {
  Size size = MediaQuery.of(context).size;
  final padding = MediaQuery.of(context).padding;
  XFile? image;

  return await showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        setImageForAddContactBottomSheet(XFile value) {
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
                  Text(
                    "New Contact",
                    style: getBold16(),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (isValidToCreate()) {
                        await createContact();
                        Navigator.pop(context);
                        popUpBottomSheet(context, "User Added!");
                      }
                    },
                    child: Text(
                      "Done",
                      style: getBold16(color: isValidToCreate() ? cpBlue : cpGray),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              image == null
                  ? SvgPicture.asset(
                      'assets/contact.svg',
                      height: 195,
                      width: 195,
                    )
                  : ClipOval(
                      child: Image.file(
                        File(image!.path),
                        height: 195,
                        width: 195,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: () async {
                  showPhotoBottomSheet(context, setImage, setImageForAddContactBottomSheet);
                },
                child: Text(
                  "Add Photo",
                  style: getBold16(),
                ),
              ),
              const SizedBox(height: 20),
              AddBottomSheetTextField(
                hintText: "First Name",
                onChanged: setName,
              ),
              const SizedBox(height: 20),
              AddBottomSheetTextField(
                hintText: "Last Name",
                onChanged: setSurname,
              ),
              const SizedBox(height: 20),
              AddBottomSheetTextField(
                hintText: "Phone Number",
                onChanged: setPhoneNumber,
              ),
            ],
          ),
        );
      },
    ),
  );
}

class AddBottomSheetTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  const AddBottomSheetTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: backgroundColor,
          hintText: hintText,
          hintStyle: getBold16(color: cpGray),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
