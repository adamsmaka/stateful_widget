import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stateful_widget/repositories/fake_repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._fakeRepository) : super(const HomeState());

  final FakeRepository _fakeRepository;

  Future<void> fetchData() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final results = await _fakeRepository.fetchData();
      emit(
        state.copyWith(
          isLoading: false,
          results: results,
          number: state.number + 1,
        ),
      );
    } catch (exception) {
      emit(
        state.copyWith(
          isLoading: false,
          number: state.number - 5,
          errorMessage: exception.toString(),
        ),
      );
    }
  }
}
