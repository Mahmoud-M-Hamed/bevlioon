import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get hasInternet;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get hasInternet async {
    final status = await _connectivity.checkConnectivity();
    if (status.contains(ConnectivityResult.none)) return false;
    return true;
  }
}
