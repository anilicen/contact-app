import 'dart:convert';
import 'dart:io';

import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/repositories/contact_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class DataContactRepository implements ContactRepository {
  List<Contact> contactList = [];
  List<Contact> searchList = [];
  @override
  Future<void> createContact(Contact contact) async {
    contactList.add(contact);
    final url = 'http://146.59.52.68:11235/api/User';

    final String jsonBody = jsonEncode(contact.toJson());

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'ApiKey': '34ccb4bc-ef75-44d0-9bb3-f067aae12a1b',
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      print('Contact created successfully');
      print('Response body: ${response.body}');
    } else {
      print('Failed to create contact. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Future<List<Contact>> getContacts() async {
    try {
      final Uri url = Uri.parse('http://146.59.52.68:11235/api/User?&skip=0&take=10');

      final Map<String, String> headers = {
        'accept': 'text/plain',
        'ApiKey': '34ccb4bc-ef75-44d0-9bb3-f067aae12a1b',
      };

      var response = await http.get(url, headers: headers);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse['data']);
      jsonResponse['data']['users'].forEach((contact) {
        contactList.add(Contact.fromJson(contact));
      });
      return contactList;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<Contact>> searchContacts(String param) async {
    try {
      searchList.clear();
      final Uri url = Uri.parse('http://146.59.52.68:11235/api/User?search=$param&skip=0&take=100');

      final Map<String, String> headers = {
        'accept': 'text/plain',
        'ApiKey': '34ccb4bc-ef75-44d0-9bb3-f067aae12a1b',
      };

      var response = await http.get(url, headers: headers);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse['data']);
      print("SEARCHED CONTACTS");
      jsonResponse['data']['users'].forEach((contact) {
        searchList.add(Contact.fromJson(contact));
      });
      return searchList;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> editContact(String id, Contact contact) async {
    contactList.removeWhere((contact) => contact.id == id);
    contactList.add(contact);
    final Uri url = Uri.parse('http://146.59.52.68:11235/api/User/$id');

    final Map<String, String> headers = {
      'accept': 'text/plain',
      'ApiKey': '34ccb4bc-ef75-44d0-9bb3-f067aae12a1b',
      'Content-Type': 'application/json'
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 200) {
    } else {
      print('Failed to edit contact. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> deleteContact(String id) async {
    contactList.removeWhere((contact) => contact.id == id);
    final Uri url = Uri.parse('http://146.59.52.68:11235/api/User/$id');
    try {
      await http.delete(
        url,
        headers: {
          'accept': 'text/plain',
          'ApiKey': '34ccb4bc-ef75-44d0-9bb3-f067aae12a1b',
        },
      );
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Future<String> uploadPhoto(File file) async {
    const url = 'http://146.59.52.68:11235/api/User/UploadImage';
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.headers['accept'] = 'text/plain';
    request.headers['ApiKey'] = '34ccb4bc-ef75-44d0-9bb3-f067aae12a1b';
    request.headers['Content-Type'] = 'multipart/form-data';

    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: path.basename(file.path),
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();

    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

    String imageUrl = jsonResponse['data']['imageUrl'];
    return imageUrl;
  }
}
