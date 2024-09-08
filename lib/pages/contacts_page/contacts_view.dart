import 'package:contact_app/constants.dart';
import 'package:contact_app/data/repositories/contact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/pages/contacts_page/contacts_controller.dart';
import 'package:contact_app/text_styles.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart' hide View;
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactsView extends View {
  @override
  State<StatefulWidget> createState() {
    return _ContactsViewState(
      ContactsController(
        DataContactRepository(),
      ),
    );
  }
}

class _ContactsViewState extends ViewState<ContactsView, ContactsController> {
  _ContactsViewState(ContactsController controller) : super(controller);
  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: ControlledWidgetBuilder<ContactsController>(builder: (context, controller) {
            return Container(
              padding: EdgeInsets.only(top: padding.top + 20, left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contacts",
                        style: getBold24(),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset('assets/add.svg'),
                        onTap: () {
                          controller.showAddBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: cpWhite,
                        prefixIcon: Icon(
                          Icons.search,
                          color: controller.isSearching ? cpBlack : cpGray,
                        ),
                        hintText: 'Search by name',
                        hintStyle: getBold16(color: cpGray),
                      ),
                      onChanged: (val) {
                        EasyDebounce.debounce("debouncer", Duration(milliseconds: 250), () {
                          controller.searchContacts(val);
                        });
                      },
                    ),
                  ),
                  controller.contacts == null
                      ? CircularProgressIndicator()
                      : controller.contacts!.isEmpty
                          ? Column(
                              children: [
                                const SizedBox(height: 200),
                                SvgPicture.asset(
                                  'assets/contact.svg',
                                  height: 60,
                                  width: 60,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "No Contacts",
                                  style: getBold24(),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  "Contacts you’ve added will appear here.",
                                  textAlign: TextAlign.center,
                                  style: getBold16(),
                                ),
                                const SizedBox(height: 7),
                                TextButton(
                                  onPressed: () => controller.showAddBottomSheet(context),
                                  child: Text(
                                    'Create New Contact',
                                    style: getBold16(color: cpBlue),
                                  ),
                                ),
                              ],
                            )
                          : Expanded(
                              child: controller.isSearching
                                  ? ListView(
                                      children: [
                                        for (Contact searchedContact in controller.searchedContacts)
                                          Column(
                                            children: [
                                              GestureDetector(
                                                child: ContactContainer(
                                                  contact: searchedContact,
                                                ),
                                                onTap: () =>
                                                    controller.showProfileBottomSheet(context, searchedContact),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                      ],
                                    )
                                  : ListView(
                                      children: [
                                        for (Contact contact in controller.contacts!)
                                          Column(
                                            children: [
                                              GestureDetector(
                                                child: ContactContainer(
                                                  contact: contact,
                                                ),
                                                onTap: () => controller.showProfileBottomSheet(context, contact),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                      ],
                                    ),
                            ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ContactContainer extends StatelessWidget {
  final Contact contact;
  const ContactContainer({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: cpWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipOval(
            child: contact.profileImageUrl != null
                ? Image.network(
                    contact.profileImageUrl!,
                    height: 34,
                    width: 34,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    'assets/contact.svg',
                    height: 34,
                    width: 34,
                  ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${contact.firstName} ${contact.lastName}',
                style: getBold16(),
              ),
              Text(
                contact.phoneNumber!,
                style: getBold16(color: cpGray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
