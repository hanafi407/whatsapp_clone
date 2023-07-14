import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_chat_screen.dart';

final selectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance),
);

class SelectContactRepository {
  FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContact() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
          withProperties: true,
        );
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return contacts;
  }

  void selectContact(Contact contact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        print(contact);
        var selectedPhoneNumber = contact.phones[0].normalizedNumber.replaceAll(' ', '');

        if (selectedPhoneNumber == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName);
        }

        if (!isFound) {
          showSnacbar(context: context, content: 'This number don\'t have whatsapp!');
        }
      }
    } catch (err) {
      showSnacbar(context: context, content: err.toString());
    }
  }
}
