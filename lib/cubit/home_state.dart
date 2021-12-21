part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(1) int number,
    String? errorMessage,
    String? results,
    @Default(false) bool isLoading,
  }) = _HomeState;
}
