import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'app_themes/app_themes.dart';
import 'core/app_routes/app_routes.dart';
import 'core/widgets/no_inter_net_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  SocketServices socketServices = SocketServices();

  socketServices.init();

  Get.put(ChatController());


  await dotenv.load(fileName: ".env");
  print(' ==================>>   ${dotenv.env['STRIPE_PUBLISHABLE_KEY']}');


  // Initialize Stripe
  //Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  //await Stripe.instance.applySettings();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) =>  MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
        darkTheme: Themes().lightTheme,
        routeInformationParser: AppRoutes.goRouter.routeInformationParser,
        routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
        routerDelegate: AppRoutes.goRouter.routerDelegate,
        builder: (context, child) {
          return Scaffold(body: NoInterNetScreen(child: child!));
        },
      ),
    );
  }
}
