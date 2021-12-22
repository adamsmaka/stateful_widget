import 'package:flutter_test/flutter_test.dart';
import 'package:stateful_widget/datasources/remote_data_source.dart';
import 'package:stateful_widget/repositories/fake_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late RemoteDataSource _remoteDataSource;
  late FakeRepository _sut;

  setUp(() {
    _remoteDataSource = MockRemoteDataSource();
    _sut = FakeRepository(_remoteDataSource);
    when(_remoteDataSource.fetchData).thenAnswer((_) async => 'test-string');
  });

  group('fetchData', () {
    test('should add -super postfix', () async {
      final result = await _sut.fetchData();
      expect(result, 'test-string-super');
    });

    test('should call .fetchData() method on remote data souce', () async {
      await _sut.fetchData();
      verify(() => _remoteDataSource.fetchData()).called(1);
    });
  });

  group('fetchDataForNetworkStatus', () {
    group('is connected to the internet', () {
      test('should return data from data source', () async {
        final result = await _sut.fetchDataForNetworkStatus(isConnected: true);
        expect(result, 'test-string');
      });

      test('should call .fetchData() method on remote data souce', () async {
        await _sut.fetchDataForNetworkStatus(isConnected: true);
        verify(() => _remoteDataSource.fetchData()).called(1);
      });
    });

    group('is NOT connected to the internet', () {
      test('should return mocked data', () async {
        final result = await _sut.fetchDataForNetworkStatus(isConnected: false);
        expect(result, 'Offline');
      });

      test('should never call .fetchData() method on remote data souce', () async {
        await _sut.fetchDataForNetworkStatus(isConnected: false);
        verifyNever(() => _remoteDataSource.fetchData());
      });
    });
  });
}
