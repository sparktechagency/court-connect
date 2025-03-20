import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_session_card.dart';
import 'package:flutter/material.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'My Booking List'),
      body: ListView.builder(
        itemCount: 6,
          itemBuilder: (context, index) {
        return CustomSessionCard(
          image: '',
            title: 'Sailing Komodo',
            subtitles: const [
              '\$ 100',
              'Bonosree, Dhaka, Bangladeh',
              'Jun 20,2025 | 10:30PM'
            ],
            onTap: (){},
            buttonLabel: 'Download Receipt');
      }),
    );
  }
}
