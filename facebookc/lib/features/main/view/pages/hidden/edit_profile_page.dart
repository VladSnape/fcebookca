// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/main/view/bloc/profile/cubit/edit_profile_cubit.dart';
import 'package:facebookc/features/main/view/widgets/comment_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? coverImageUrl;
  String? avatarImageUrl;

  final TextEditingController usernameConroller = TextEditingController();
  final TextEditingController nameConroller = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  Future<XFile?> pickImage() async {
    final XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return imagePicked;
  }

  Future<CroppedFile?> cropImage(XFile? imagePicked) async {
    final CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imagePicked!.path);
    return croppedImage;
  }

  Future<String> uploadImage(CroppedFile? croppedImage) async {
    final String imageName = basename(croppedImage!.path);
    final File imageFile = File(croppedImage.path);
    final Reference ref = FirebaseStorage.instance.ref("images/$imageName");

    await ref.putFile(imageFile);

    final String url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserSuccess) {
                UserModel userModel = state.userModel;
                return IconButton(
                    onPressed: () async {
                      await BlocProvider.of<EditProfileCubit>(context)
                          .editProfile(
                              id: userModel.id,
                              name: nameConroller.text,
                              bio: bioController.text,
                              userName: usernameConroller.text,
                              coverUrl: coverImageUrl,
                              photoUrl: avatarImageUrl);
                      BlocProvider.of<GetUserCubit>(context).getuser();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.done));
              }
              return IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Text(' no user Detected');
                      },
                    );
                  },
                  icon: const Icon(Icons.done));
            },
          )
        ],
        title: Text(
          "Edit profile",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile picture",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () async {
                          final XFile? imagePicked = await pickImage();
                          if (imagePicked == null) return;
                          final CroppedFile? croppedImage =
                              await cropImage(imagePicked);
                          if (croppedImage == null) return;
                          final String avatarImage =
                              await uploadImage(croppedImage);
                          setState(() {
                            avatarImageUrl = avatarImage;
                          });
                        },
                        child: const Text("Edit"),
                      )
                    ],
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: const Color.fromARGB(
                          0, 147, 147, 147), // Set a transparent background
                      child: avatarImageUrl != null
                          ? ClipOval(
                              child: Image.network(
                                avatarImageUrl!,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 75, child: Text('no image')),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cover photo",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () async {
                          final XFile? imagePicked = await pickImage();
                          final CroppedFile? croppedImage =
                              await cropImage(imagePicked);
                          final String coverurl =
                              await uploadImage(croppedImage);
                          setState(() {
                            coverImageUrl = coverurl;
                          });
                        },
                        child: const Text("Edit"),
                      )
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        height: 200,
                        child: coverImageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  coverImageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Text('no image'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "name",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  BlocBuilder<GetUserCubit, GetUserState>(
                    builder: (context, state) {
                      if (state is GetUserSuccess) {
                        return CommentTextField(
                          controller: nameConroller,
                          text: '${state.userModel.name}',
                        );
                      } else if (state is GetUserFailed) {
                        return CommentTextField(text: 'failed state ');
                      }

                      return CommentTextField(text: 'name');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "user_name",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  BlocBuilder<GetUserCubit, GetUserState>(
                    builder: (context, state) {
                      if (state is GetUserSuccess) {
                        return CommentTextField(
                          controller: usernameConroller,
                          text: '${state.userModel.userName}',
                        );
                      } else if (state is GetUserFailed) {
                        return CommentTextField(text: 'failed state ');
                      }

                      return CommentTextField(text: 'user_name');
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bio",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  BlocBuilder<GetUserCubit, GetUserState>(
                    builder: (context, state) {
                      if (state is GetUserSuccess) {
                        return CommentTextField(
                          controller: bioController,
                          text: '${state.userModel.bio}',
                        );
                      } else if (state is GetUserFailed) {
                        return CommentTextField(text: 'failed state ');
                      }

                      return CommentTextField(text: 'bio');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
