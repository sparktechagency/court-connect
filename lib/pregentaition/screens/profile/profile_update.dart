import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jotter/Controller/profile_controller.dart';
import 'dart:io';

import 'package:jotter/global_widgets/custom_text.dart';
import 'package:jotter/global_widgets/custom_text_button.dart';
import 'package:jotter/global_widgets/custom_text_field.dart';
import 'package:jotter/utils/app_colors.dart';
import 'package:jotter/utils/app_icons.dart';

import '../../Controller/auth_controller.dart';
import '../../routes/exports.dart';
import '../widgets/custom_network_image.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController imageCtrl = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    // Initialize controllers with default values
    nameTEController.text = Get.arguments["name"];
    emailTEController.text = Get.arguments["email"];
    imageCtrl.text = Get.arguments["image"];
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pick from Gallery"),
              onTap: () async {
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _profileImage = File(image.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () async {
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  setState(() {
                    _profileImage = File(image.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(
          text: 'Profile Update',
          fontSize: 18.sp,
          color: AppColors.textColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // spacing: 10.h,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120.r,
                      height: 120.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10.r,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          width: 2.w,
                        ),
                      ),
                      child: _profileImage != null
                          ? Container(
                              height: 120.h,
                              width: 120.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Image.file(_profileImage!, fit: BoxFit.cover))
                          : CustomNetworkImage(
                              boxShape: BoxShape.circle,
                              imageUrl: Get.arguments["image"].toString(),
                              height: 120.h,
                              width: 120.w)
                    ),



                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: _pickImage,
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               CustomTextTwo(text: "User Name", bottom: 8.h),
              CustomTextField(
                controller: nameTEController,
                hintText: "Enter your name",
                filColor: Colors.transparent,
                borderColor: Colors.black,
              ),

              SizedBox(height: 20.h),

               CustomTextTwo(text: "E-mail", bottom: 8.h),
              CustomTextField(
                readOnly: true,
                controller: emailTEController,
                hintText: "Enter your email address",
                filColor: Colors.transparent,
                borderColor: Colors.black,
              ),

              SizedBox(
                height: 50.h,
              ),
              // Edit Profile Button
              CustomTextButton(
                text: 'Update Profile',
                onTap: () async {
                  profileController.profileUpdate(
                    name: nameTEController.text,
                    image: _profileImage
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
