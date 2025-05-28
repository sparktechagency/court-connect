import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  late final StreamSubscription<ConnectivityResult> _subscription;

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initializeConnectivity() async {
    final status = await _connectivity.checkConnectivity();
    isConnected.value = status != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
