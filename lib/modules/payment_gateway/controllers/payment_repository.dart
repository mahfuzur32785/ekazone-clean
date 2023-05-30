import 'package:dartz/dartz.dart';
import 'package:ekayzone/modules/payment_gateway/paypal/paypal_service.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> cashOnDelivery(Uri uri);
  Future<Either<Failure, Map<String, String>>> createPaypalPayment(PaypalServices paypalServices,Map<String, dynamic> body);
  Future<Either<Failure, dynamic>> createPayfastPayment(Map<String, dynamic> body, String token);
  Future<Either<Failure, String>> stripePay(
      String token, Map<String, String> body);
  Future<Either<Failure, String>> paymentConfirmation(
      String token, Map<String, String> body);
}

class PaymentRepositoryImp extends PaymentRepository {
  final RemoteDataSource remoteDataSource;

  PaymentRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, Map<String, String>>> createPaypalPayment(PaypalServices paypalServices,Map<String, dynamic> body) async {
    try {
      final accessToken = (await paypalServices.getAccessToken());
      final res = await paypalServices.createPaypalPayment(body, accessToken);
      return Right(res);
    } on ServerException catch (e) {
      print("Error is $e");
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure,dynamic>> createPayfastPayment(Map<String, dynamic> body, String token) async {
    try {
      final res = await remoteDataSource.createPayfastPayment(body, token);
      return Right(res);
    } on ServerException catch (e) {
      print("Error is ${e.message}");
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> cashOnDelivery(Uri uri) async {
    try {
      // final result = await remoteDataSource.cashOnDeliveryPayment(uri);
      const result = '';
      return const Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> stripePay(
    String token,
    Map<String, String> body,
  ) async {
    try {
      final result = await remoteDataSource.stripePay(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  @override
  Future<Either<Failure, String>> paymentConfirmation(
    String token,
    Map<String, String> body,
  ) async {
    try {
      final result = await remoteDataSource.paymentConfirmation(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }



}
