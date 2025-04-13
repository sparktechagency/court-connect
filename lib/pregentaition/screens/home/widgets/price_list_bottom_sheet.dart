import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceListBottomSheet extends StatefulWidget {
  const PriceListBottomSheet({super.key});

  @override
  State<PriceListBottomSheet> createState() => _PriceListBottomSheetState();
}

class _PriceListBottomSheetState extends State<PriceListBottomSheet> {
  final TextEditingController _monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      horizontalPadding: 16.w,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: 50.w,
            child: const Divider(
              thickness: 3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Sort By',
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  )),
            ],
          ),
          Divider(
            thickness: 0.4,
            color: Colors.grey.shade200,
          ),
          _buildListTile(
              checked: true,
              label: 'Price: Low to High',
              onChanged: (value) {}),
          _buildListTile(
              checked: true,
              label: 'Price: High to Low',
              onChanged: (value) {}),
          _buildListTile(
              checked: true,
              label: 'Month',
              onChanged: (value) {},
              titleWidget: CustomTextField(controller: _monthController)),
        ],
      ),
    );
  }

  ListTile _buildListTile(
      {bool checked = false,
      String? label,
      ValueChanged<bool?>? onChanged,
      Widget? titleWidget}) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Checkbox(
            shape: const CircleBorder(), value: checked, onChanged: onChanged),
        title: Row(
          children: [
            CustomText(
              textAlign: TextAlign.left,
              text: label ?? '',
            ),
            if (titleWidget != null) Expanded(child: titleWidget)
          ],
        ));
  }
}
