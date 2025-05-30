import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.title, this.showLeading = true, this.actions, this.titleWidget, this.backAction});

  final String? title;
  final Widget? titleWidget;
  final bool showLeading;
  final List<Widget>? actions;
  final VoidCallback? backAction;

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
                if(backAction != null){
                  backAction!();
                  context.pop();
                }else{
                  context.pop();
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Container(
                  padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child:  Icon(Icons.arrow_back, color: Colors.black,size: 20.r,)),
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
