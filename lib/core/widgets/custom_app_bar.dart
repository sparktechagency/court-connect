import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.showLeading = true, this.actions});

  final String? title;
  final bool showLeading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leading:
          showLeading
              ? GestureDetector(
            onTap: (){
              context.pop();
            },
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)
                ),
                child: Padding(
                  padding:  EdgeInsets.all(5.r),
                  child: const Icon(Icons.arrow_back),
                )),
          )
              : null,
      title:
          title != null && title != ''
              ? Text(
                title!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              )
              : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
