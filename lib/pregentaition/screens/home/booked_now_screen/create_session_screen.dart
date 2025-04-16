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

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  File? _coverImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

  // Method to pick the date
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        final formatted = "${picked.month}-${picked.day}-${picked.year}";
        _monthController.text = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Create Session',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///<=========== Community Name text form ==============>

              CustomText(
                text: 'Session Name',
                bottom: 10.h,
                top: 10.h,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Write name here...',
              ),

              ///<=========== Cover Photo  form ==============>
              CustomText(
                text: 'Upload an image',
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

              ///<=========== price text form ==============>
              CustomText(
                text: 'Price',
                bottom: 10.h,
                top: 10.h,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: '\$',
              ),

              CustomText(
                text: 'Location',
                bottom: 10.h,
                top: 10.h,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Write location here...',
              ),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Date',
                          bottom: 10.h,
                          top: 10.h,
                        ),
                        GestureDetector(
                          onTap: () => _pickDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: _monthController,
                              hintText: "MM-DD-YYYY",
                              suffixIcon: const Icon(Icons.date_range_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Time',
                          bottom: 10.h,
                          top: 10.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (pickedTime != null) {
                              final formattedTime = pickedTime.format(context);
                              _timeController.text = formattedTime;
                            }
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: _timeController,
                              hintText: "--:---",
                              suffixIcon: const Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                      _coverImage = File(image.path);
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
                      _coverImage = File(image.path);
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
    _monthController.dispose();
    _timeController.dispose();
    _priceController.dispose();
    _locationController.dispose();
  }
}
