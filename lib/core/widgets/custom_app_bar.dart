import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.title, this.showLeading = true, this.actions, this.titleWidget});

  final String? title;
  final Widget? titleWidget;
  final bool showLeading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leading: showLeading
          ? GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: const Icon(Icons.arrow_back, color: Colors.black)),
              ),
            )
          : null,
      title: title != null && title != ''
          ? Align(
        alignment: Alignment.centerLeft,
            child: Text(
                title!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              ),
          )
          : titleWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
