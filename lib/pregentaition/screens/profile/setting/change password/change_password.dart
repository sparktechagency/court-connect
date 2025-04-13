import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/change%20password/controller/change_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ChangePassController _controller = Get.put(ChangePassController());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Change Password'),
      body: Form(
        key: _globalKey,
        child: Column(
          spacing: 10.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
            ),
            CustomTextField(
              controller: _controller.oldPassTEController,
              hintText: "Old Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (_controller.oldPassTEController.text.length < 8) {
                  return 'Password must be 8+ chars';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _controller.passTEController,
              hintText: "New Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (_controller.passTEController.text.length < 8) {
                  return 'Password must be 8+ chars';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _controller.rePassTEController,
              hintText: "Confirm Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm password is required';
                } else if (value != _controller.passTEController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const Spacer(),
            Obx(
              () => _controller.isLoading.value
                  ? const CustomLoader()
                  : CustomButton(
                      label: "Change Password",
                      onPressed: _onChangePassword,
                    ),
            ),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }

  void _onChangePassword() {
    if (!_globalKey.currentState!.validate()) return;
    _controller.changePass(context);
  }
}
