class PaymentKeys {




 static setPublishableKey(String key){
  _publishAbleKey = key;
 }

 static setSecretKey(String key){
  _secretKey = key;
 }

 static String get publishAbleKey => _publishAbleKey;
 static String get secretKey => _secretKey;
}
