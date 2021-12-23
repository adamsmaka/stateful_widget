import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stateful_widget/cubit/home_cubit.dart';
import 'package:stateful_widget/repositories/fake_repository.dart';

class MockFakeRepository extends Mock implements FakeRepository {}

void main() {
  late FakeRepository _fakeRepository;
  late HomeCubit _sut;

  setUp(() {
    _fakeRepository = MockFakeRepository();
    _sut = HomeCubit(_fakeRepository);
  });

  group('HomeCubit', () {
    test('has expected initial state', () {
      expect(_sut.state, const HomeState());
    });

    group('fetchData', () {
      blocTest<HomeCubit, HomeState>('should emit Loading and Success State',
          build: () => _sut,
          act: (cubit) => cubit.fetchData(),
          verify: (_) {
            verify(() => _fakeRepository.fetchData()).called(1);
          });

      group('successful repository respond', () {
        setUp(() {
          when(_fakeRepository.fetchData).thenAnswer(
            (_) async => 'test-string',
          );
        });

        blocTest<HomeCubit, HomeState>(
          'should emit Loading and Success State',
          build: () => _sut,
          act: (cubit) => cubit.fetchData(),
          expect: () => [
            const HomeState(isLoading: true),
            const HomeState(
              number: 2,
              results: 'test-string',
            ),
          ],
        );
      });

      group('exception repository respond', () {
        setUp(() {
          when(_fakeRepository.fetchData).thenThrow(
            Exception('test-exception'),
          );
        });

        blocTest<HomeCubit, HomeState>(
          'should emit Loading and Success State',
          build: () => _sut,
          act: (cubit) => cubit.fetchData(),
          expect: () => [
            const HomeState(isLoading: true),
            const HomeState(
                number: -4, errorMessage: 'Exception: test-exception'),
          ],
        );
      });
    });
  });
}
