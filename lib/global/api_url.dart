

class ApiUrl {

  static const String baseUrl = "http://192.168.10.18:3000" ;


  static const String signUp = "$baseUrl/api/users/sign-up" ;
  static const String allTransactions = "$baseUrl/api/transactions" ;
  static const String createPasscode = "$baseUrl/api/users/passcode" ;
  static const String signIn = "$baseUrl/api/users/sign-in" ;
  static const String verifyPasscode = "$baseUrl/api/users/verify-passcode" ;
  static const String forgetPassword = "$baseUrl/api/users/forget-password" ;
  static const String verifyOtp = "$baseUrl/api/users/verify-otp" ;
  static const String resetPassword = "$baseUrl/api/users/reset-password" ;


}