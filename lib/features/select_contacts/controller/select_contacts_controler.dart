import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/select_contacts/repository/select_contact_repository.dart';
import 'package:flutter_contacts/contact.dart';

final getContactProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);

  return selectContactRepository.getContact();
});

final selectContactControllerProvider = Provider(
  (ref) {
    var selectContactRepository = ref.watch(selectContactRepositoryProvider);

    return SelectContactController(ref: ref, selectContactRepository: selectContactRepository);
  },
);

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContactController({required this.ref, required this.selectContactRepository});

  void selectContact(Contact contact, BuildContext context) {
    selectContactRepository.selectContact(contact, context);
  }
}
