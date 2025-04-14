import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PriceListBottomSheet extends StatefulWidget {
  const PriceListBottomSheet({super.key});

  @override
  State<PriceListBottomSheet> createState() => _PriceListBottomSheetState();
}

class _PriceListBottomSheetState extends State<PriceListBottomSheet> {
  String _selectedSort = '';
  DateTime? _selectedDate;

  final TextEditingController _monthController = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _monthController.text = "${picked.month}-${picked.day}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      horizontalPadding: 16.w,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50.w,
              child: const Divider(thickness: 3),
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
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.clear, color: Colors.black),
                ),
              ],
            ),
            Divider(thickness: 0.4, color: Colors.grey.shade200),
        
            // Sort Options
            _buildSortTile(label: 'Price: Low to High'),
            _buildSortTile(label: 'Price: High to Low'),
        
            // Month Filter with Date Picker
            _buildSortTile(
              label: 'Month',
              titleWidget: GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_outlined),
                    controller: _monthController,
                    hintText: "MM-DD-YYYY",
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Cancel Button
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      _monthController.clear();
                      context.pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: CustomText(
                      text: 'Clear all',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 44.w),
                // Confirm Button
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      context.pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: CustomText(
                      text: 'Apply',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSortTile({required String label,Widget? titleWidget}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<String>(
        value: label,
        groupValue: _selectedSort,
        onChanged: (value) {
          setState(() {
            _selectedSort = value!;
          });
        },
        activeColor: Colors.black,
      ),
      title: Row(
        children: [
          CustomText(textAlign: TextAlign.left, text: label ?? ''),
          if (titleWidget != null) ...[
            const SizedBox(width: 10),
            SizedBox(
                width: 150.w,
                child: titleWidget),
          ],
        ],
      ),
    );
  }
}


