import 'package:dartz/dartz.dart';
import 'package:ekayzone/modules/home/model/country_model.dart';
import 'package:ekayzone/modules/setting/model/setting_model.dart';

import '../../../../core/data/datasources/local_data_source.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

abstract class AppSettingRepository {
  Future<Either<Failure, SettingModel>> websiteSetup();
  Future<Either<Failure, List<TopCountry>>> getCountry();
  Either<Failure, SettingModel> getCachedWebsiteSetup();

  Either<Failure, bool> checkOnBoarding();
  Future<Either<Failure, bool>> cacheOnBoarding();
}

class AppSettingRepositoryImp extends AppSettingRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AppSettingRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      final result = localDataSource.checkOnBoarding();

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheOnBoarding() async {
    try {
      return Right(await localDataSource.cacheOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SettingModel>> websiteSetup() async {
    try {
      final result = await remoteDataSource.websiteSetup();
      localDataSource.cacheWebsiteSetting(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, List<TopCountry>>> getCountry() async {
    try {
      final result = await remoteDataSource.getCountry();
      // localDataSource.cacheCountryData(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, SettingModel> getCachedWebsiteSetup() {
    try {
      final result = localDataSource.getWebsiteSetting();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
