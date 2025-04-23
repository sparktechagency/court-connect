import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<String> items;
  final Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert,color: Colors.white,),
      //constraints: BoxConstraints(maxHeight: 200.h),
      color: Colors.white,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((String item) {
          return PopupMenuItem<String>(
            height: 32.h,
            value: item,
            child: CustomText(text: item, fontsize: 12.sp),
          );
        }).toList();
      },
    );
  }
}
