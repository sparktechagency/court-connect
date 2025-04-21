import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_session_card.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/profile/controller/my_booking_controller.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/pdf_helper.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  final MyBookingController _controller = Get.put(MyBookingController());

  @override
  void initState() {
    _controller.getMyBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'My Booking List'),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const CustomLoader();
        }
        if (_controller.myBookings.isEmpty) {
          return const Center(child: Text("No bookings found"));
        }
        return ListView.builder(
          itemCount: _controller.myBookings.length,
          itemBuilder: (context, index) {
            final sessionData = _controller.myBookings[index];
            final data = TimeFormatHelper.formatDate(
                DateTime.parse(sessionData.date ?? ''));
            return CustomSessionCard(
              image: '${ApiUrls.imageBaseUrl}${sessionData.image}',
              title: sessionData.name ?? '',
              subtitles: [
                '\$ ${sessionData.price ?? ''}',
                sessionData.location ?? '',
                '$data  |  ${sessionData.time}',
              ],
              onTap: () => createInvoicePDF(
                items: {
                  'name': '${sessionData.name}',
                  'price': '${sessionData.price}',
                  'location': '${sessionData.location}',
                  'date': data,
                },
              ),
              buttonLabel: 'Download Receipt',
              removeAction: () => _controller.deleteMyBooking(sessionData.sId!),
            );
          },
        );
      }),
    );
  }
}
