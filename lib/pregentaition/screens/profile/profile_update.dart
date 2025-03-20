import 'dart:io';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  File? _profileImage;

  final TextEditingController _nameTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                CustomImageAvatar(
                  radius: 60.r,
                  image: '',
                  fileImage: _profileImage,
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
                    child: Center(child: Icon(Icons.camera_alt, color: Colors.white,size: 18.r,)),
                  ),
                ),
              ],
            ),
          ),


          SizedBox(height: 60.h,),
          CustomTextField(
            controller: _nameTEController,
            hintText: "User Name",
            filColor: Colors.transparent,
            borderColor: Colors.black,
          ),



          const Spacer(),
          CustomButton(
            label: 'Update Profile',
            onPressed: () {},
          ),
          SizedBox(height: 100.h),
        ],
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
  void dispose() {
    _nameTEController.dispose();
    super.dispose();
  }
}
