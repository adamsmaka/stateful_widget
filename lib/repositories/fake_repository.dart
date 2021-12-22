import 'package:injectable/injectable.dart';
import 'package:stateful_widget/datasources/remote_data_source.dart';

@lazySingleton
class FakeRepository {
  final RemoteDataSource _remoteDataSource;

  FakeRepository(this._remoteDataSource);

  Future<String> fetchData() async {
    final results = await _remoteDataSource.fetchData();
    return '$results-super';
  }

  Future<String> fetchDataForNetworkStatus({required bool isConnected}) async {
    if (isConnected) {
      return await _remoteDataSource.fetchData();
    } else {
      return 'Offline';
    }
  }
}
