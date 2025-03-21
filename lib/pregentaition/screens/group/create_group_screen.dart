import 'dart:io';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  File? _profileImage;
  File? _coverImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Create Community',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///<=========== Community Name text form ==============>

              CustomText(
                text: 'Community Name',
                bottom: 10.h,
                top: 10.h,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Write name here...',
              ),

              ///<=========== Profile Photo  form ==============>

              CustomText(
                text: 'Profile Photo',
                bottom: 10.h,
                top: 20.h,
              ),
              CustomContainer(
                verticalPadding: 10.h,
                width: double.infinity,
                radiusAll: 12.r,
                color: Colors.grey.shade300,
                child: Column(
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    CustomText(
                      text: _profileImage == null
                          ? 'Drop your image here'
                          : 'Please Upload...',
                      fontsize: 8.sp,
                      bottom: 6.h,
                      top: 6.h,
                    ),
                    if (_profileImage == null)
                      CustomContainer(
                        onTap: () => _pickImage('profile'),
                        bordersColor: Colors.grey,
                        verticalPadding: 2.h,
                        horizontalPadding: 10.h,
                        radiusAll: 10.r,
                        color: Colors.blue.withOpacity(0.1),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.upload_outlined,
                              size: 18.r,
                            ),
                            CustomText(
                              text: 'Click to browse',
                              fontsize: 8.sp,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              ///<=========== Cover Photo  form ==============>
              CustomText(
                text: 'Cover Photo',
                bottom: 10.h,
                top: 20.h,
              ),
              CustomContainer(
                bordersColor: Colors.grey,
                height: 170.h,
                width: double.infinity,
                radiusAll: 12.r,
                color: Colors.grey.shade300,
                child: _coverImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          _coverImage!,
                          fit: BoxFit.cover,
                        ))
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => _pickImage('cover'),
                              icon: Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 54.r,
                              ),
                            ),
                            CustomText(
                              text: 'Upload Image',
                              top: 10.h,
                            ),
                          ],
                        ),
                      ),
              ),

              ///<=========== description text form ==============>
              CustomText(
                text: 'Description',
                bottom: 10.h,
                top: 20.h,
              ),
              CustomTextField(
                controller: _descriptionController,
                maxLength: 400,
                maxLine: 8,
                hintText: 'Write here about this communities Roles and details',
              ),

              ///<=========== Submit button form ==============>

              SizedBox(height: 32.h),
              CustomButton(
                onPressed: _onSubmit,
                label: 'Submit',
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_globalKey.currentState!.validate()) return;
  }

  Future<void> _pickImage(String type) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final ImagePicker picker = ImagePicker();

        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pick from Gallery"),
                onTap: () async {
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      if (type == 'profile') {
                        _profileImage = File(image.path);
                      } else {
                        _coverImage = File(image.path);
                      }
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
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      if (type == 'profile') {
                        _profileImage = File(image.path);
                      } else {
                        _coverImage = File(image.path);
                      }
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }
}
