import 'package:dartz/dartz.dart';
import 'package:ekayzone/modules/dashboard/model/overview_model.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/profile/model/public_profile_model.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/data/datasources/local_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../setting/model/user_with_country_response.dart';
import '../controller/change_password/change_password_cubit.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserWithCountryResponse>> userProfile(String token);
  Future<Either<Failure, PublicProfileModel>> publicProfile(String username, String sortBy, String token);
  Future<Either<Failure, String>> postSellerReview(Map<String, dynamic> body,String seller,String token);
  Future<Either<Failure, DOverViewModel>> dashboardOverview(String token);

  Future<Either<Failure, List<AdModel>>> compareList(List<dynamic> adsId);

  Future<Either<Failure, String>> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  );

  // ........ This method use for Classified Application Profile update .......
  Future<Either<Failure, Map<String, dynamic>>> editProfile(
      Map<String,String> body,
    String token,
  );
  Future<Either<Failure, String>> changePassword(
      Map<String,String> body,
    String token,
  );
  Future<Either<Failure, String>> deleteAccount(String data, String token, String text);

  Future<Either<Failure, List<AdModel>>> wishList(String token);
  Future<Either<Failure, String>> addWishList(int id, String token);
}

class ProfileRepositoryImp extends ProfileRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  ProfileRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserWithCountryResponse>> userProfile(
      String token) async {
    try {
      final result = await remoteDataSource.userProfile(token);
      localDataSource.cacheUserProfile(result.user);
      return Right(result);
    } on ServerException catch (e) {
      if (e.statusCode == 401) localDataSource.clearUserProfile();
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PublicProfileModel>> publicProfile(
      String username, String sortBy, String token) async {
    try {
      final result = await remoteDataSource.publicProfile(username, sortBy, token);
      // localDataSource.cacheUserProfile(result.user);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> postSellerReview(Map<String, dynamic> body, String seller, String token) async {
    try {
      final result = await remoteDataSource.postSellerReview(body,seller,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, DOverViewModel>> dashboardOverview(
      String token) async {
    try {
      final result = await remoteDataSource.dashboardOverview(token);
      // localDataSource.cacheUserProfile(result.user);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  ) async {
    try {
      final result =
          await remoteDataSource.passwordChange(changePassData, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> editProfile(
      Map<String,String> body,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.editProfile(body, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      Map<String,String> body,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.changePassword(body, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount(String data, String token, String text) async {
    try {
      final result = await remoteDataSource.deleteAccount(data, token, text);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<AdModel>>> wishList(String token) async {
    try {
      final result = await remoteDataSource.wishList(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<AdModel>>> compareList(List<dynamic> adsId) async {
    try {
      final result = await remoteDataSource.compareList(adsId);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addWishList(int id, String token) async {
    try {
      final result = await remoteDataSource.addWishList(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
