import 'package:dartz/dartz.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomeData(String countryCode, String token);
}

class HomeRepositoryImp extends HomeRepository {
  final RemoteDataSource remoteDataSource;
  HomeRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, HomeModel>> getHomeData(String countryCode, String token) async {
    try {
      final result = await remoteDataSource.getHomeData(countryCode, token);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
