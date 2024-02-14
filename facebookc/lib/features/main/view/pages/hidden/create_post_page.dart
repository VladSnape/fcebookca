import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_post_cubit.dart';
import 'package:facebookc/features/main/view/widgets/post_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  String? postImage;

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
    final Reference ref =
        FirebaseStorage.instance.ref("postsImages/$imageName");

    await ref.putFile(imageFile);

    final String url = await ref.getDownloadURL();
    return url;
  }

  TextEditingController postcontroller = TextEditingController();
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final XFile? imagePicked = await pickImage();
                if (imagePicked == null) return;
                final CroppedFile? croppedImage = await cropImage(imagePicked);
                if (croppedImage == null) return;
                final String avatarImage = await uploadImage(croppedImage);
                setState(() {
                  postImage = avatarImage;
                });
              },
              icon: const Icon(Icons.photo)),
          BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserSuccess) {
                return PostButtonWidget(
                  isEmpty: isEmpty,
                  onTap: () {
                    BlocProvider.of<AddPostCubit>(context).addPost(PostModel(
                        authorAvatar: state.userModel.avatarImage,
                        authorUserName: state.userModel.userName,
                        image: postImage,
                        timeStamp: Timestamp.now(),
                        author: state.userModel.id,
                        text: postcontroller.text));

                    Navigator.pop(context);
                  },
                );
              }
              return PostButtonWidget(
                isEmpty: isEmpty,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Text('no user brother');
                    },
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
        title: Text(
          "Create post",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetUserCubit, GetUserState>(
                builder: (context, state) {
                  if (state is GetUserSuccess) {
                    return Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            radius: 30,
                            child: ClipOval(
                              child: state.userModel.avatarImage != null
                                  ? Image.network(
                                      state.userModel.avatarImage!,
                                      fit: BoxFit
                                          .cover, // Ensure the image covers the entire CircleAvatar
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4, // Adjust width as needed
                                      height: MediaQuery.sizeOf(context).width *
                                          0.4, // Adjust height as needed
                                    )
                                  : null, // Set child to null if avatarImage is null
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            child: Text(
                              "${state.userModel.name} ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          child: Text(
                            "user name ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: TextField(
                  maxLines: null,
                  style: Theme.of(context).textTheme.displayMedium,
                  onChanged: (text) {
                    setState(() {
                      isEmpty = text.trim().isEmpty;
                    });
                  },
                  controller: postcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Whats on your mind ?",
                      hintStyle: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                width: MediaQuery.sizeOf(context).width,
                child: postImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          postImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
