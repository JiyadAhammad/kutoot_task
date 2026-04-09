part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(false) bool isFetchingLocation,
    String? currentLocation,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _DashboardState;
}
