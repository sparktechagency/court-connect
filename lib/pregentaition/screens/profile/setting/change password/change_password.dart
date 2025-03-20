import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../core/widgets/custom_text_field.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  final TextEditingController _oldPassTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _rePassTEController = TextEditingController();
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
              controller: _oldPassTEController,
              hintText: "Old Password",
              isPassword: true,
            ),
            CustomTextField(
              controller: _passTEController,
              hintText: "New Password",
              isPassword: true,
            ),
            CustomTextField(
              controller: _rePassTEController,
              hintText: "Confirm Password",
              isPassword: true,
            ),


            const Spacer(),
            CustomButton(
                label: "Change Password",
                onPressed: _onChangePassword,
                ),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }


  void _onChangePassword(){
    if(!_globalKey.currentState!.validate()) return;
    context.goNamed(AppRoutes.customBottomNavBar);

  }


  @override
  void dispose() {
    _oldPassTEController.dispose();
    _passTEController.dispose();
    _rePassTEController.dispose();
    super.dispose();
  }
}
