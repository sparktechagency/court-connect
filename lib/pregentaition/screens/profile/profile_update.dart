import 'dart:io';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/pregentaition/screens/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final ImagePicker _picker = ImagePicker();
  final ProfileController _controller = Get.put(ProfileController());



  @override
  void initState() {
    _controller.nameTEController.text = _controller.profileData.name ?? '';
    _controller.phoneTEController.text = _controller.profileData.phone ?? '';
    _controller.addressTEController.text = _controller.profileData.address ?? '';
    _controller.bioTEController.text = _controller.profileData.bio ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CustomImageAvatar(
                    radius: 60.r,
                    image: _controller.profileData.image ?? '',
                    fileImage: _controller.profileImage.value,
                  ),
                  Positioned(
                    bottom: 6.h,
                    right: 8.w,
                    child: CustomContainer(
                      onTap: _pickImage,
                      height: 32.h,
                      width: 32.w,
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      child: Center(
                          child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18.r,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.h),
            CustomTextField(
              controller: _controller.nameTEController,
              hintText: "User Name",
              filColor: Colors.transparent,
              borderColor: Colors.black,
            ),
        
            SizedBox(height: 10.h),
        
            CustomTextField(
              controller: _controller.phoneTEController,
              hintText: "Phone",
              filColor: Colors.transparent,
              borderColor: Colors.black,
            ),
        
            SizedBox(height: 10.h),
        
            CustomTextField(
              controller: _controller.addressTEController,
              hintText: "Address",
              filColor: Colors.transparent,
              borderColor: Colors.black,
            ),
        
            SizedBox(height: 10.h),
        
            CustomTextField(
              maxLine: 5,
              controller: _controller.bioTEController,
              hintText: "Bio",
              filColor: Colors.transparent,
              borderColor: Colors.black,
            ),
            const Spacer(),
            Obx(() => _controller.isLoading.value
                ? const CustomLoader()
                : CustomButton(
                    label: 'Update Profile',
                    onPressed: () =>
                             _controller.editProfile(context)
        
                  )),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
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
                    _controller.profileImage.value = File(image.path);
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
                    _controller.profileImage.value = File(image.path);
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
}
