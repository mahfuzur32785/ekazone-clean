import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/home/model/product_model.dart';
import '../../../../../core/error/failure.dart';
import '../../../authentication/controllers/login/login_bloc.dart';
import '../../model/wish_list_model.dart';
import '../../repository/profile_repository.dart';
part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(const WishListStateInitial());

  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;

  List<AdModel> adList = [];

  List<int> selectedId = [];

  Future<void> getWishList(bool isLoading) async {
    if (_loginBloc.userInfo == null) {
      emit(const WishListStateError("Please login first", 1000));
      return;
    }

    if (isLoading) {
      emit(const WishListStateLoading());
    }

    final result =
        await _profileRepository.wishList(_loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(WishListStateError(failure.message, failure.statusCode));
      },
      (adList) {
        this.adList = adList;
        emit(WishListStateLoaded(adList));
      },
    );
  }

  Future<Either<Failure, String>> addWishList(int id) async {
    if (_loginBloc.userInfo == null) {
      return left(const ServerFailure("Please login first", 1000));
    }
    final result = await _profileRepository.addWishList(
        id, _loginBloc.userInfo!.accessToken);

    return result;
  }
}
