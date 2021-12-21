

import 'package:injectable/injectable.dart';
import 'package:stateful_widget/datasources/remote_data_source.dart';

@lazySingleton 
class FakeRepository {
  final RemoteDataSource _remoteDataSource;

  FakeRepository(this._remoteDataSource);

  Future<String> fetchData() async {
    const isNetworkOnline = true;
    if (isNetworkOnline) {
      final results = _remoteDataSource.fetchData();
      // _localDataSource.save(results);
      return results;
    } else {
      return 'Offline';
    }
  }
}
