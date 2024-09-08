import 'package:contact_app/constants.dart';
import 'package:contact_app/text_styles.dart';
import 'package:contact_app/widgets/small_sheet_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showPhotoBottomSheet(
    BuildContext context, Function(XFile image) setImage, Function(XFile image) setImageForAddContactBottomSheet) {
  Size size = MediaQuery.of(context).size;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  XFile? prevImage;

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
      ),
      height: 250,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
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
                  SvgPicture.asset('assets/camera.svg'),
                  const SizedBox(width: 15),
                  Text("Camera", style: getBold24()),
                ],
              ),
            ),
            onTap: () async {
              prevImage = image;
              image = await picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                setImage(image!);
                setImageForAddContactBottomSheet(image!);
                Navigator.pop(context);
              } else {
                image = prevImage;
              }
            },
          ),
          const SizedBox(height: 15),
          GestureDetector(
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
                  SvgPicture.asset('assets/picture.svg'),
                  const SizedBox(width: 15),
                  Text("Gallery", style: getBold24()),
                ],
              ),
            ),
            onTap: () async {
              prevImage = image;
              image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setImage(image!);
                setImageForAddContactBottomSheet(image!);
                Navigator.pop(context);
              } else {
                image = prevImage;
              }
            },
          ),
          const SizedBox(height: 15),
          SmallSheetTextButton(
            text: 'Cancel',
            textColor: cpBlue,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    ),
  );
}
