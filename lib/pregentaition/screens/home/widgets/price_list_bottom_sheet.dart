import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PriceListBottomSheet extends StatefulWidget {
  const PriceListBottomSheet({super.key});

  @override
  State<PriceListBottomSheet> createState() => _PriceListBottomSheetState();
}

class _PriceListBottomSheetState extends State<PriceListBottomSheet> {
  final HomeController _controller = Get.put(HomeController());
  final TextEditingController _monthController = TextEditingController();
  DateTime? _selectedDate;

  // Method to pick the date
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        final formatted = "${picked.month}-${picked.day}-${picked.year}";
        _monthController.text = formatted;
        _controller.date.value = formatted;
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
            // Divider for visual separation
            SizedBox(width: 50.w, child: const Divider(thickness: 3)),

            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: 'Sort By',
                    fontWeight: FontWeight.w500,
                    fontsize: 18.sp),
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
            Divider(thickness: 0.4, color: Colors.grey.shade200),

            // Sort Options
            _buildSortTile('Price: Low to High', 'low'),
            _buildSortTile('Price: High to Low', 'high'),


            // Month Filter with Date Picker
            GestureDetector(
              onTap: () => _pickDate(context),
              child: AbsorbPointer(
                child: CustomTextField(
                  controller: _monthController,
                  hintText: "MM-DD-YYYY",
                  suffixIcon: const Icon(Icons.date_range_outlined),
                ),
              ),
            ),

            // Action Buttons
            SizedBox(height: 24.w),
            Row(
              children: [
                _buildActionButton(
                    'Clear all', Colors.grey.shade300, Colors.black, () {
                  _controller.date.value = '';
                  _controller.price.value = '';
                  _monthController.clear();
                  _controller.getSession();
                  context.pop();
                }),
                SizedBox(width: 16.w),
                _buildActionButton(
                    'Apply', AppColors.primaryColor, Colors.white, () {
                  _controller.getSession();
                  context.pop();
                }),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  ///Helper method to build the sort options list tile
  Widget _buildSortTile(String label, String value, {Widget? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<String>(
        value: value,
        groupValue: _controller.price.value,
        onChanged: (val) => setState(() {
          _controller.price.value = val!;
        }),
        activeColor: Colors.black,
      ),
      title: Row(
        children: [
          CustomText(text: label),
          if (trailing != null) ...[
            const SizedBox(width: 10),
            SizedBox(width: 150.w, child: trailing),
          ],
        ],
      ),
    );
  }

  /// Helper method to build action buttons (Clear and Apply)
  Widget _buildActionButton(
      String label, Color bgColor, Color textColor, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: CustomText(
          text: label,
          fontWeight: FontWeight.w500,
          fontsize: 14.sp,
          color: textColor,
        ),
      ),
    );
  }
}
