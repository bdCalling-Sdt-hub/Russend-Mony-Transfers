

class ApiUrl {


  ///========================================> exchangeApi <==================================

  static const String exchangeApi = "http://api.exchangeratesapi.io/v1/latest?access_key=1b5a060773c6744333b2898be0a8c826" ;


  ///========================================> exchangeApi <==================================




  static const String baseUrl = "http://192.168.10.18:3000" ;


  static const String signUp = "$baseUrl/api/users/sign-up" ;
  static const String allTransactions = "$baseUrl/api/transactions" ;
  static const String createPasscode = "$baseUrl/api/users/passcode" ;
  static const String signIn = "$baseUrl/api/users/sign-in" ;
  static const String verifyPasscode = "$baseUrl/api/users/verify-passcode" ;
  static const String forgetPassword = "$baseUrl/api/users/forget-password" ;
  static const String verifyOtp = "$baseUrl/api/users/verify-otp" ;
  static const String resetPassword = "$baseUrl/api/users/reset-password" ;
  static const String signInWithPasscode = "$baseUrl/api/users/sign-in-with-passcode" ;
  static const String transaction = "$baseUrl/api/transactions" ;
  static const String countries = "$baseUrl/api/countries" ;
  static const String hiddenFee = "$baseUrl/api/hidden-fees" ;


}