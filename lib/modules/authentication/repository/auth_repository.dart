import 'package:dartz/dartz.dart';

import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../core/data/datasources/local_data_source.dart';
import '../models/set_password_model.dart';
import '../models/user_login_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLoginResponseModel>> login(
      Map<String, dynamic> body);
  Either<Failure, UserLoginResponseModel> getCashedUserInfo();
  Either<Failure, bool> saveCashedUserInfo(UserLoginResponseModel userLoginResponseModel);
  Future<Either<Failure, String>> signUp(Map<String, dynamic> body);
  Future<Either<Failure, UserLoginResponseModel>> socialLogin(Map<String, dynamic> body);
  Future<Either<Failure, String>> sendForgotPassCode(Map<String, dynamic> body);
  Future<Either<Failure, String>> setPassword(Map<String, dynamic> body);
  Future<Either<Failure, String>> logOut(String token);
}

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserLoginResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> logOut(String token) async {
    try {
      // final result = await remoteDataSource.logOut(token);
      Future.delayed(const Duration(seconds: 1)).then((value) {
        localDataSource.clearUserProfile();
        return const Right("Logout done");
      });
      return const Right("Logout done");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, UserLoginResponseModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> saveCashedUserInfo(UserLoginResponseModel userLoginResponseModel) {
    try {
      localDataSource.cacheUserResponse(userLoginResponseModel);
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.userRegister(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserLoginResponseModel>> socialLogin(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.socialLogin(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> sendForgotPassCode(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.sendForgotPassCode(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> setPassword(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.setPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
