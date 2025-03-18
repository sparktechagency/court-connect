
import 'package:courtconnect/pregentaition/screens/auth/login/log_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/prefs_helper.dart';
import '../../pregentaition/screens/auth/forget/forget_screen.dart';
import '../../pregentaition/screens/auth/otp/otp_screen.dart';
import '../../pregentaition/screens/auth/reset_pass/reset_password_screen.dart';
import '../../pregentaition/screens/auth/sign_up/sign_up_screen.dart';
import '../../pregentaition/screens/bottom_nav_bar/customtom_bottom_nav.dart';
import '../../pregentaition/screens/profile/profile_screen.dart';
import '../../pregentaition/screens/splash_screen/splash_screen.dart';
import '../utils/app_constants.dart';



class AppRoutes {
  ///===================routes Path===================>>>

  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/LoginScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String forgetScreen = "/ForgetScreen";
  static const String otpScreen = "/OtpScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String customBottomNavBar = "/CustomBottomNavBar";
  static const String profileScreen = "/ProfileScreen";




  static final GoRouter goRouter = GoRouter(
      initialLocation: splashScreen,


      routes: [
        ///===================Splash Screen=================>>>
        GoRoute(
          path: splashScreen,
          name: splashScreen,
          builder: (context, state) =>const SplashScreen(),
          redirect: (context, state) {
            Future.delayed(const Duration(seconds: 3), ()async{
              // String role = await PrefsHelper.getString(AppConstants.role);
              // String token = await PrefsHelper.getString(AppConstants.bearerToken);
              // if(token.isNotEmpty){
              //     // AppRoutes.goRouter.replaceNamed(AppRoutes.managerHomeScreen);
              // }else{
                AppRoutes.goRouter.replaceNamed(AppRoutes.loginScreen);
              // }


            });
            return null;
          },
        ),



        ///=========Log in Screen========>>

        GoRoute(
          path: loginScreen,
          name: loginScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( LoginScreen(), state),
        ),



        ///=========Sign Up Screen========>>

        GoRoute(
          path: signUpScreen,
          name: signUpScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( SignUpScreen(), state),
        ),



        ///=========ForgetScreen Screen========>>

        GoRoute(
          path: forgetScreen,
          name: forgetScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( ForgetScreen(), state),
        ),


    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: otpScreen,
          name: otpScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( OtpScreen(), state),
        ),



    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: resetPasswordScreen,
          name: resetPasswordScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( ResetPasswordScreen(), state),
        ),


    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: customBottomNavBar,
          name: customBottomNavBar,
          pageBuilder: (context, state) =>  _customTransitionPage( CustomBottomNavBar(), state),
        ),


    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: profileScreen,
          name: profileScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( ProfileScreen(), state),
        ),




      ]
  );


 static Page<dynamic> _customTransitionPage(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

}