class ApiUrls {
  static const String baseUrl = "https://courtconnect-asifur-rahman.sarv.live/api/v1";
  static const String imageBaseUrl = "https://courtconnect-asifur-rahman.sarv.live";

  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String login = '/auth/login';
  static const String forgetPassword = '/auth/forget-password';
  static  const String  resendOtp = '/auth/resend-otp';
  static  const String  resetPassword = '/auth/reset-password';
  static  const String  myProfile = '/auth/my-profile';
  static  const String  updateProfile = '/auth/profile-update';
  static  const String  getBanner = '/banner';
  static  const String  terms = '/terms';
  static  const String  about = '/about';
  static  const String  privacy = '/privacy';
  static  const String  changePassword = '/user/change-password';
  static  const String  paymentConfirm = '/payment/confirm';
  static  const String  sessionCreate = '/session/create';
  static  const String  charge = '/charge';
  static  const String  booking = '/booking';
  static   String  session (String? type,price,date)=> '/session?type=$type&price=$price&date=$date';
  static   String  user (String id)=> '/session/registered-users?sessionId=$id';
  static   String  bookmark (String id)=> '/booking/add?sessionId=$id';
  static   String  deleteBooking (String id)=> '/booking/delete?bookingId=$id';
}
