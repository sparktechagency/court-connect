import 'package:courtconnect/env/config.dart';
import 'package:courtconnect/helpers/dependancy_injaction.dart';
import 'package:courtconnect/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app_themes/app_themes.dart';
import 'core/app_routes/app_routes.dart';
import 'core/widgets/no_inter_net_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  Stripe.publishableKey = Config.publishableKey;
  Stripe.merchantIdentifier = 'MerchantIdentifier';
  await Stripe.instance.applySettings();


  SocketServices socketServices = SocketServices();
  socketServices.init();


  DependencyInjection di = DependencyInjection();
  di.dependencies();
  di.lockDevicePortrait();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MaterialApp.router(
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
