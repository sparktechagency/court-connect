class ApiConstants{
  static const String baseUrl = "https://vibeznightlife.com/api/v1";
  static const String imageBaseUrl = "https://vibeznightlife.com/";
  //
  // static const String baseUrl = "https://vibez-asifur-rahman.sarv.live/api/v1";
  // static const String imageBaseUrl = "https://vibez-asifur-rahman.sarv.live";


  static const String signUpEndPoint = "/auth/register";
  static const String verifyEmailEndPoint = "/auth/verify-otp";
  static const String signInEndPoint = "/auth/login";
  static const String forgotPasswordPoint = "/auth/forget-password";
  static const String setPasswordEndPoint = "/auth/register";
  static const String resendOtpEndPoint = "/auth/resend-otp";
  static const String changePassword = "/auth/change-password";
  static const String updateProfile = "/auth/profile-update";


  ///user
  static const String eventEndPoint = "/event";
  static const String reviewRating = "/review/submit";
  static  String eventDetailsEndPoint(String id) => "/event/details?id=$id";
}