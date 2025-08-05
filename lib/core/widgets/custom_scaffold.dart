import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.paddingSide});

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final double? paddingSide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSide ?? 16.w),
        child: body,
      )),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
