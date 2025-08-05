import 'dart:io';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/create_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final CreateGroupController _controller = Get.put(CreateGroupController());

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
                controller: _controller.nameController,
                hintText: 'Write name here...',
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
                child: _controller.coverImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          _controller.coverImage!,
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
                controller: _controller.descriptionController,
                maxLength: 400,
                maxLine: 8,
                hintText: 'Write here about this communities Roles and details',
              ),

              ///<=========== Submit button form ==============>

              SizedBox(height: 60.h),
              Obx(() {
                return _controller.isLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onPressed: () {
                          if (!_globalKey.currentState!.validate()) return;
                          _controller.createGroup(context);
                        },
                        label: 'Submit',
                      );
              }),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
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
                        _controller.profileImage = File(image.path);
                      } else {
                        _controller.coverImage = File(image.path);
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
                        _controller.profileImage = File(image.path);
                      } else {
                        _controller.coverImage = File(image.path);
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
}
