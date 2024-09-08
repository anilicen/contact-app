import 'dart:io';

import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/repositories/contact_repository.dart';
import 'package:contact_app/widgets/add_contact_bottom_sheet.dart';
import 'package:contact_app/widgets/contact_profile_bottom_sheet.dart';
import 'package:contact_app/widgets/pop_up_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';

class ContactsController extends Controller {
  ContactsController(ContactRepository contactRepository) : _contactRepository = contactRepository;

  ContactRepository _contactRepository;
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  XFile? image;
  List<Contact>? contacts;
  bool isSearching = false;
  List<Contact> searchedContacts = [];
  @override
  void initListeners() {}

  @override
  Future<void> onInitState() async {
    super.onInitState();

    contacts = await _contactRepository.getContacts();
    refreshUI();
  }

  bool isValidToCreate() {
    return firstName.isNotEmpty || lastName.isNotEmpty || phoneNumber.isNotEmpty;
  }

  void setImage(XFile value) {
    image = value;
    refreshUI();
  }

  void setFirstName(String value) {
    firstName = value;
    refreshUI();
  }

  void setLastName(String value) {
    lastName = value;
    refreshUI();
  }

  void setPhoneNumber(String value) {
    phoneNumber = value;
    refreshUI();
  }

  Future<String> uploadPhoto(File file) async {
    return await _contactRepository.uploadPhoto(file);
  }

  Future<void> createContact() async {
    String? imageUrl;

    if (image != null) {
      imageUrl = await uploadPhoto(File(image!.path));
    }
    Contact contact = Contact(
      id: '0',
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profileImageUrl: imageUrl,
    );
    _contactRepository.createContact(contact);

    firstName = '';
    lastName = '';
    phoneNumber = '';
    image = null;

    refreshUI();
  }

  Future<void> editContact(String id, Contact contact) async {
    String? imageUrl;
    if (image != null) {
      imageUrl = await uploadPhoto(File(image!.path));
    }
    contact = contact.copyWith(profileImageUrl: imageUrl);
    _contactRepository.editContact(
      id,
      contact,
    );
    refreshUI();
  }

  Future<void> searchContacts(String param) async {
    if (param.isEmpty) {
      isSearching = false;
    } else {
      isSearching = true;
      searchedContacts = await _contactRepository.searchContacts(param);
    }
    refreshUI();
  }

  void getContacts() {
    _contactRepository.getContacts();
    refreshUI();
  }

  Future<void> deleteContact(String id) async {
    await _contactRepository.deleteContact(id);
    refreshUI();
  }

  Future<void> showAddBottomSheet(BuildContext context) async {
    await showAddContactBottomSheet(
      context,
      setFirstName,
      setLastName,
      setPhoneNumber,
      setImage,
      createContact,
      isValidToCreate,
    );
  }

  Future<void> popupSheet(BuildContext context, String text) async {
    await popUpBottomSheet(context, text);
  }

  Future<void> showProfileBottomSheet(BuildContext context, Contact contact) async {
    await showProfileModalBottomSheet(
      context,
      contact,
      deleteContact,
      setImage,
      editContact,
    );
  }
}
