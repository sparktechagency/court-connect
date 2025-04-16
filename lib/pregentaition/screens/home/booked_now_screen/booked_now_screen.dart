import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookedNowScreen extends StatefulWidget {
  const BookedNowScreen({super.key});

  @override
  State<BookedNowScreen> createState() => _BookedNowScreenState();
}

class _BookedNowScreenState extends State<BookedNowScreen> {
  double amount = 200;
  PaymentController paymentController = PaymentController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Pay to Create Session'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: 'Create Your Session for Only \$5!',
              fontWeight: FontWeight.w600,
              fontsize: 18.sp,
              color: AppColors.primaryColor,
            ),
            CustomText(
              top: 10.h,
              text: 'To kickstart your session, a small fee is required.',
              fontsize: 10.sp,
              color: Colors.grey,
            ),
            Assets.images.coin.image(height: 215.h, width: 190.w),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    text: 'Powered by ',
                    children: const [
                      TextSpan(
                        text: 'Stripe',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      TextSpan(
                        text:
                            ' for a seamless, secure transaction. Proceed to Payment',
                      ),
                    ])),
            SizedBox(height: 54.h),
            CustomButton(
              onPressed: () async{
                await paymentController.initPaymentSheet(
                    amount: amount.round().toString(), currency: 'USD',context: context);
              },
              label: 'Proceed to Payment',
            ),
          ],
        ),
      ),
    );
  }
}
