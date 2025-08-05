import 'dart:io';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_network_image.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/edit_group_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/session_edit/controller/session_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({super.key, required this.groupParams});

  final Map<String, dynamic> groupParams;

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final EditGroupController _controller = Get.put(EditGroupController());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final data = widget.groupParams;
    _controller.nameController.text = data['name'] ?? '';
    _controller.desController.text = data['des'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.groupParams;
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Edit Community',
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
                hintText: 'name',
              ),





              ///<=========== Cover Photo  form ==============>
              CustomText(
                text: 'Upload an image',
                bottom: 10.h,
                top: 20.h,
              ),
              Stack(
                children: [
                  CustomContainer(
                    bordersColor: Colors.grey,
                    height: 170.h,
                    width: double.infinity,
                    radiusAll: 12.r,
                    color: Colors.grey.shade300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: _controller.coverImage != null
                          ? Image.file(_controller.coverImage!,
                          fit: BoxFit.cover)
                          : CustomNetworkImage(imageUrl: data['image']),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => _pickImage('cover'),
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white.withOpacity(0.8),
                            size: 40.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),





              ///<=========== price text form ==============>
              CustomText(
                text: 'Description',
                bottom: 10.h,
                top: 20.h,
              ),
              CustomTextField(
                enabled: false,
                controller: _controller.desController,
                maxLength: 400,
                maxLine: 8,
                hintText: 'Write here about this communities Roles and details',
              ),





              ///<=========== Submit button form ==============>

              SizedBox(height: 60.h),
              Obx(
                    () => _controller.isLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                  onPressed: () {
                    if (!_globalKey.currentState!.validate()) return;
                    _controller.editMyGroup(context, data['id']!);
                  },
                  label: 'Submit',
                ),
              ),
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
                      _controller.coverImage = File(image.path);
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
                      _controller.coverImage = File(image.path);
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
