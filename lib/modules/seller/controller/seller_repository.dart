import 'package:dartz/dartz.dart';
import 'package:ekayzone/modules/seller/model/seller_response_model.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';

abstract class SellerRepository {
  Future<Either<Failure, SellerResponseModel>> sellers(Uri uri);
}

class SellerRepositoryImp extends SellerRepository {
  final RemoteDataSource _remoteDataSource;

  SellerRepositoryImp({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SellerResponseModel>> sellers(Uri uri) async {
    try {
      final result = await _remoteDataSource.sellers(uri);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}
