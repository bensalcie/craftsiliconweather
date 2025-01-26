
import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  bool _isConnected = false; // Cached internet status
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Completer<void>? _initializationCompleter;

  InternetChecker() {
    _initialize();
  }

  // Initialize and start monitoring connectivity changes
  void _initialize() {
    _initializationCompleter = Completer<void>();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _handleConnectivityChange(results);
    });
    _checkInitialStatus();
  }

  // Handle connectivity changes
  void _handleConnectivityChange(List<ConnectivityResult> results) async {
    if (results.contains(ConnectivityResult.none)) {
      _isConnected = false;
    } else {
      _isConnected = await _checkInternetAccess();
    }
    // Mark initialization complete if it's the first check
    _initializationCompleter?.complete();
    _initializationCompleter = null;
  }

  // Check the initial connectivity status
  Future<void> _checkInitialStatus() async {
    final result = await _connectivity.checkConnectivity();
    _handleConnectivityChange(result); // Wrap result in a list
  }

  // Verify internet access by performing a DNS lookup
  Future<bool> _checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Public method to get the current internet status with a fallback
  Future<bool> isInternetAvailable() async {
    // Wait for the initial status check to complete
    if (_initializationCompleter != null) {
      await _initializationCompleter!.future;
    }
    return _isConnected;
  }

  // Dispose the subscription to prevent memory leaks
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
