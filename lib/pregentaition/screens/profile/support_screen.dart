import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Support'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Assets.images.supportLogo.image(width: 250.w, height: 220.h),
            CustomText(
              top: 20.h,
              bottom: 20.h,
              maxline: 2,
              text:
                  "If you face any kind of problem with\nour service feel free to contact us.",
              fontsize: 16.sp,
            ),
            SizedBox(height: 20.h),
            TextButton.icon(
              onPressed: () async {
                final Uri url = Uri.parse('tel:(609)327-7992');
                if (await launchUrl(url)) {
                  await launchUrl(url);
                } else {
                  debugPrint('Could not launch phone dialer');
                }
              },
              label: CustomText(
                text: '(609)327-7992',
                color: Colors.black,
              ),
              icon: Icon(
                Icons.phone,
                size: 24.r,
                color: Colors.black,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final Uri emailUrl = Uri(
                  scheme: 'mailto',
                  path: 'exmple@gmail.com',
                  query:
                      'subject=Support Inquiry&body=Hello, I need assistance with...',
                );
                if (await launchUrl(emailUrl)) {
                  await launchUrl(emailUrl);
                } else {
                  debugPrint('Could not launch email client');
                }
              },
              label: CustomText(
                text: 'exmple@gmail.com',
                color: Colors.black,
              ),
              icon: Icon(
                Icons.mail_outline,
                size: 24.r,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
