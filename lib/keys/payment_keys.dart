class PaymentKeys {
 static String _publishAbleKey = 'pk_test_51RE5CTBAXOk4i1N0dYYtBsgGU6XH1EstVgeHWzodeWvXGyDZyjQVkHlPqIdgjukTl4AxCKfjzCEeCYFRXkivBlXQ00Ve6spk6T';
 static String _secretKey = 'sk_test_51RE5CTBAXOk4i1N0R115qs3PWDQOpHZM8ynCK2dWhvgF4d1iE6UmpomEvXkLBpkCXDK4NlilZffRYRhRlrgU56XB008quQlIBa';



 static setPublishableKey(String key){
  _publishAbleKey = key;
 }

 static setSecretKey(String key){
  _secretKey = key;
 }

 static String get publishAbleKey => _publishAbleKey;
 static String get secretKey => _secretKey;
}
