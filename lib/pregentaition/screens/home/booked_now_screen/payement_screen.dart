import 'package:country_picker/country_picker.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentController paymentController = Get.put(PaymentController());

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final countriesController = TextEditingController();
  final zipController = TextEditingController();

  CardFieldInputDetails? cardDetails;
  String selectedCountry = 'United States';

  final List<String> countries = ['United States', 'Canada', 'United Kingdom'];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const Text('Card information'),
            const SizedBox(height: 8),
            CardField(
              onCardChanged: (card) => setState(() => cardDetails = card),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Cardholder name'),
            ),
            const SizedBox(height: 16),
            const Text('Country or region'),
            const SizedBox(height: 8),
            CustomTextField(
              onTap: (){
                showCountryPicker(
                  context: context,
                  countryListTheme: const CountryListThemeData(
                    flagSize: 25,
                    //backgroundColor: Colors.white,
                    //textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    bottomSheetHeight: 500,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  onSelect: (Country country) {
                    print('Selected country: ${country.displayName}');
                    countriesController.text = country.name;
                    setState(() {

                    });
                  },
                );
              },
              controller: countriesController,
              hintText: "Select a country",
              readOnly: true, // Optional: makes intention more explicit
            ),

            const SizedBox(height: 12),
            TextField(
              controller: zipController,
              decoration: const InputDecoration(labelText: 'ZIP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Pay', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 16),
            const Text(
              'By clicking Pay, you agree to the Link Terms and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}




