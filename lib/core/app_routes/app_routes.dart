import 'package:courtconnect/pregentaition/screens/auth/login/log_in_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/create_group_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/group_details_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/post/create_post_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/post/post_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/booked_now_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/create_session_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/payement_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/home_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/registered_users_screen/registered_users_screen.dart';
import 'package:courtconnect/pregentaition/screens/message/chat_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/my_booking_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/profile_update.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/about_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/change%20password/change_password.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/privacy_policy_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/setting_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/terms_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/support_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../pregentaition/screens/auth/forget/forget_screen.dart';
import '../../pregentaition/screens/auth/otp/otp_screen.dart';
import '../../pregentaition/screens/auth/reset_pass/reset_password_screen.dart';
import '../../pregentaition/screens/auth/sign_up/sign_up_screen.dart';
import '../../pregentaition/screens/bottom_nav_bar/customtom_bottom_nav.dart';
import '../../pregentaition/screens/profile/profile_screen.dart';
import '../../pregentaition/screens/splash_screen/splash_screen.dart';



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
  static const String homeScreen = "/homeScreen";
  static const String bookedNowScreen = "/bookedNowScreen";
  static const String createSessionScreen = "/createSessionScreen";
  static const String registeredUsersScreen = "/registeredUsersScreen";
  static const String profileUpdate = "/profileUpdate";
  static const String supportScreen = "/supportScreen";
  static const String settingScreen = "/settingScreen";
  static const String changePassword = "/changePassword";
  static const String termsScreen = "/termsScreen";
  static const String privacyPolicyScreen = "/privacyPolicyScreen";
  static const String aboutScreen = "/aboutScreen";
  static const String myBookingScreen = "/myBookingScreen";
  static const String groupDetailsScreen = "/groupDetailsScreen";
  static const String createGroupScreen = "/createGroupScreen";
  static const String postScreen = "/postScreen";
  static const String createPostScreen = "/createPostScreen";
  static const String chatScreen = "/chatScreen";
  static const String paymentScreen = "/paymentScreen";




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
          pageBuilder: (context, state) =>  _customTransitionPage( const LoginScreen(), state),
        ),



        ///=========Sign Up Screen========>>

        GoRoute(
          path: signUpScreen,
          name: signUpScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const SignUpScreen(), state),
        ),



        ///=========ForgetScreen Screen========>>

        GoRoute(
          path: forgetScreen,
          name: forgetScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const ForgetScreen(), state),
        ),


    ///=========ForgetScreen Screen========>>
        GoRoute(
          path: '$otpScreen/:screenType',
          name: otpScreen,
          builder: (context, state) {
            final String screenType = state.pathParameters['screenType']!;
            return OtpScreen(screenType: screenType);
          },
        ),



    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: resetPasswordScreen,
          name: resetPasswordScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const ResetPasswordScreen(), state),
        ),


    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: customBottomNavBar,
          name: customBottomNavBar,
          pageBuilder: (context, state) =>  _customTransitionPage(  CustomBottomNavBar(), state),
        ),


    ///=========ForgetScreen Screen========>>

        GoRoute(
          path: profileScreen,
          name: profileScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const ProfileScreen(), state),
        ),

        ///=========ForgetScreen Screen========>>

        GoRoute(
          path: homeScreen,
          name: homeScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const HomeScreen(), state),
        ),


        ///=========ForgetScreen Screen========>>

        GoRoute(
          path: bookedNowScreen,
          name: bookedNowScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const BookedNowScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: '$registeredUsersScreen/:sessionId',
          name: registeredUsersScreen,
          pageBuilder: (context, state) {
            final String sessionId = state.pathParameters['sessionId']!;

            return
            _customTransitionPage(
                 RegisteredUsersScreen(sessionId : sessionId), state);}
  ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: profileUpdate,
          name: profileUpdate,
          pageBuilder: (context, state) =>  _customTransitionPage( const ProfileUpdate(), state),
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: supportScreen,
          name: supportScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const SupportScreen(), state),
        ),

 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: settingScreen,
          name: settingScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const SettingScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: changePassword,
          name: changePassword,
          pageBuilder: (context, state) =>  _customTransitionPage( const ChangePassword(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: termsScreen,
          name: termsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const TermsScreen(), state),
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: privacyPolicyScreen,
          name: privacyPolicyScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const PrivacyPolicyScreen(), state),
        ),




 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: aboutScreen,
          name: aboutScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const AboutScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: myBookingScreen,
          name: myBookingScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const MyBookingScreen(), state),
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: groupDetailsScreen,
          name: groupDetailsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const GroupDetailsScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: createGroupScreen,
          name: createGroupScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const CreateGroupScreen(), state),
        ),

 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: postScreen,
          name: postScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const PostScreen(), state),
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: createPostScreen,
          name: createPostScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const CreatePostScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: chatScreen,
          name: chatScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const ChatScreen(), state),
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: createSessionScreen,
          name: createSessionScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const CreateSessionScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: paymentScreen,
          name: paymentScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const PaymentScreen(), state),
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