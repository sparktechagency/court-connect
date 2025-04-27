import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/pregentaition/screens/auth/login/log_in_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/create_group_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/edit_group_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/group_details_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/members_screen.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/booked_now_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/create_session_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/payement_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/home_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/registered_users_screen/registered_users_screen.dart';
import 'package:courtconnect/pregentaition/screens/home/session_edit/session_edit_screen.dart';
import 'package:courtconnect/pregentaition/screens/message/chat_profile_view_screen.dart';
import 'package:courtconnect/pregentaition/screens/message/chat_screen.dart';
import 'package:courtconnect/pregentaition/screens/notification/notification_screen.dart';
import 'package:courtconnect/pregentaition/screens/post/create_post_screen.dart';
import 'package:courtconnect/pregentaition/screens/post/edit_post_screen.dart';
import 'package:courtconnect/pregentaition/screens/post/models/post_data.dart';
import 'package:courtconnect/pregentaition/screens/post/post_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/my_booking_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/other_profile/other_profile_screen.dart';
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
  static const String editSessionScreen = "/EditSessionScreen";
  static const String membersScreen = "/membersScreen";
  static const String editGroupScreen = "/EditGroupScreen";
  static const String otherProfileScreen = "/OtherProfileScreen";
  static const String editPostScreen = "/editPostScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String chatProfileViewScreen = "/chatProfileViewScreen";




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
               String token = await PrefsHelper.getString(AppConstants.bearerToken);
              if(token.isNotEmpty){
                AppRoutes.goRouter.replaceNamed(AppRoutes.customBottomNavBar);
              }else{
                AppRoutes.goRouter.replaceNamed(AppRoutes.loginScreen);
              }


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
          path: createGroupScreen,
          name: createGroupScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const CreateGroupScreen(), state),
        ),

 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: postScreen,
          name: postScreen,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final id = extra['id']! as String;
            return _customTransitionPage(  PostScreen(id: id,), state);
  }  ,
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: createPostScreen,
          name: createPostScreen,
          pageBuilder: (context, state) {
            final userInfo = state.extra as Map<String, dynamic>;

            return _customTransitionPage( CreatePostScreen(userInfo: userInfo,), state);

  }
        ),


 ///  =========  ForgetScreen Screen  ========>>

        GoRoute(
          path: chatScreen,
          name: chatScreen,
          pageBuilder: (context, state) {
  final groupParams = state.extra as Map<String, dynamic>;
  return _customTransitionPage( ChatScreen(chatData: groupParams,), state);
  }  ,
        ),



 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: createSessionScreen,
          name: createSessionScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const CreateSessionScreen(), state),
        ),

///=========ForgetScreen Screen========>>

        GoRoute(
          path: chatProfileViewScreen,
          name: chatProfileViewScreen,
          pageBuilder: (context, state) {
            final chatData = state.extra as Map<String, dynamic>;
            return _customTransitionPage( ChatProfileViewScreen(chatData: chatData,), state);
  }  ,
        ),


///=========ForgetScreen Screen========>>

        GoRoute(
          path: editPostScreen,
          name: editPostScreen,
          pageBuilder: (context, state) {
            final Map<String, dynamic> postData = state.extra as Map<String, dynamic>;
            final List<Media> media = postData['media'] as List<Media>;

            return _customTransitionPage(
              EditPostScreen(
                media: media,
                postData: postData,
              ),
              state,
            );
          },
        ),



        ///=========ForgetScreen Screen========>>

        GoRoute(
          path: paymentScreen,
          name: paymentScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const PaymentScreen(), state),
        ),

        ///=========ForgetScreen Screen========>>

        GoRoute(
          path: notificationScreen,
          name: notificationScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( const NotificationScreen(), state),
        ),


 ///=========ForgetScreen Screen========>>

        GoRoute(
          path: editSessionScreen,
          name: editSessionScreen,
          pageBuilder: (context, state) {
            // Extract the session data from 'extra'
            final session = state.extra as Map<String, dynamic>;

            return _customTransitionPage(
              EditSessionScreen(sessionData: session),  // Pass the entire session data
              state,
            );
          },
        ),     GoRoute(
          path: editGroupScreen,
          name: editGroupScreen,
          pageBuilder: (context, state) {
            // Extract the session data from 'extra'
            final groupParams = state.extra as Map<String, dynamic>;

            return _customTransitionPage(
              EditGroupScreen(groupParams: groupParams),  // Pass the entire session data
              state,
            );
          },
        ),

        GoRoute(
          path: groupDetailsScreen,
          name: groupDetailsScreen,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final id = extra['id']! as String;
            return _customTransitionPage( GroupDetailsScreen(id: id,), state);
  } ,
        ),



        GoRoute(
          path: otherProfileScreen,
          name: otherProfileScreen,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final id = extra['id']! as String;
            return _customTransitionPage( OtherProfileScreen(id: id,), state);
  } ,
        ),



        GoRoute(
          path: AppRoutes.membersScreen,
          name: AppRoutes.membersScreen,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final members = extra['members'] as List<Members>;
            final communityId = extra['communityId'] as String;

            return _customTransitionPage(
              MembersScreen(
                members: members,
                communityId: communityId,
              ),
              state,
            );
          },
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