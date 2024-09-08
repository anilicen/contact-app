import 'dart:io';

import 'package:contact_app/domain/entities/contact.dart';

abstract class ContactRepository {
  void createContact(Contact contact);
  Future<List<Contact>> getContacts();
  Future<String> uploadPhoto(File file);
  Future<void> deleteContact(String id);
  Future<void> editContact(String id, Contact contact);
  Future<List<Contact>> searchContacts(String param);
}
