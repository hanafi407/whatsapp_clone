import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information-screen';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      print('not empty');
      ref.read(authControllerProvider).saveUserDataToFirebase(
            name,
            image,
            context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'),
                          radius: 50,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 50,
                        ),
                  Positioned(
                      bottom: 0,
                      right: -10,
                      child:
                          IconButton(onPressed: selectImage, icon: const Icon(Icons.add_a_photo)))
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.85,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Enter your name'),
                  ),
                ),
                IconButton(onPressed: storeUserData, icon: Icon(Icons.done))
              ],
            )
          ],
        )),
      ),
    );
  }
}
