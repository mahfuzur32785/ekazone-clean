import 'package:dartz/dartz.dart';
import 'package:ekayzone/core/data/datasources/remote_data_source.dart';
import 'package:ekayzone/core/error/failure.dart';
import 'package:ekayzone/modules/chat/model/chat_model.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';

import '../../../core/error/exception.dart';
import '../model/message_model.dart';

abstract class ChatRepository {
  Future<Either<Failure,ChatModel>> getUsers(String token,{String user = ''});
  Future<Either<Failure,List<MessageModel>>> sendMessage(String token,String body,String user);
}

class ChatRepositoryImp extends ChatRepository {
  ChatRepositoryImp({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, ChatModel>> getUsers(String token,{String user = ''}) async {
    try {
      final result = await remoteDataSource.getChatUsers(token,user: user);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> sendMessage(String token,String body,String user) async {
    try {
      final result = await remoteDataSource.postSendMessage(token,body,user,);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}