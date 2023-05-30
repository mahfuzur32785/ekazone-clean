import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/dashboard/model/overview_model.dart';

import '../../authentication/controllers/login/login_bloc.dart';
import '../../profile/repository/profile_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required ProfileRepository profileRepository,
    required LoginBloc loginBloc,
  })  : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(const DashboardStateInitial());

  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;

  Future<void> getDashboardData() async {
    if (_loginBloc.userInfo == null) {
      emit(const DashboardStateError('Please sign in',401));
      return;
    }

    emit(const DashboardStateLoading());

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _profileRepository.dashboardOverview(token);

    result.fold(
          (failure) {
        emit(DashboardStateError(failure.message, failure.statusCode));
      },
          (success) {
        final currentState = DashboardStateLoaded(success);
        emit(currentState);
      },
    );
  }
}
