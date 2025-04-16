
import 'package:flutter_dotenv/flutter_dotenv.dart';
class PaymentKeys {
 static String get publishAbleKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
 static String get secretKey => dotenv.env['STRIPE_SECRET_KEY'] ?? '';
}
