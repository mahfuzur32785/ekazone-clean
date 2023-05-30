import 'package:dartz/dartz.dart';
import 'package:ekayzone/modules/ads/model/adlist_response_model.dart';
import 'package:ekayzone/modules/ads/model/customer_adlist_response_model.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';

abstract class SearchAdsRepository {
  Future<Either<Failure, AdListResponseModel>> searchAds(Uri uri);
  Future<Either<Failure, CustomerAdListResponseModel>> customerAds(Uri uri,String token);
  Future<Either<Failure, String>> deleteMyAd(int id,String token);
}

class SearchAdsRepositoryImp extends SearchAdsRepository {
  final RemoteDataSource _remoteDataSource;

  SearchAdsRepositoryImp({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;


  @override
  Future<Either<Failure, AdListResponseModel>> searchAds(Uri uri) async {
    try {
      final result = await _remoteDataSource.searchAds(uri);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CustomerAdListResponseModel>> customerAds(Uri uri,String token) async {
    try {
      final result = await _remoteDataSource.customerAds(uri,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteMyAd(int id,String token) async {
    try {
      final result = await _remoteDataSource.deleteMyAd(id,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
