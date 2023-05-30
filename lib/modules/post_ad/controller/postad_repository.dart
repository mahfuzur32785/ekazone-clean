import 'package:dartz/dartz.dart';
import 'package:ekayzone/core/error/failure.dart';
import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/post_ad/controller/postad_bloc.dart';

import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../ads/new_ad_edit/controller/new_ad_edit_bloc.dart';
import '../../new_post_ad/controller/new_posted_bloc.dart';

abstract class PostAdRepository {
  Future<Either<Failure,String>> postAdSubmit(PostAdModalState state,String token);
  Future<Either<Failure,AdDetails>> newPostAdSubmit(NewPostAdModalState state,String token);

  Future<Either<Failure,String>> newAdEditSubmit(NewEditAdModalState state,String token,String id);

}

class PostAdRepositoryImp extends PostAdRepository {
  final RemoteDataSource remoteDataSource;
  PostAdRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> postAdSubmit(PostAdModalState state,String token) async {
    try {
      final result = await remoteDataSource.postAdSubmit(state,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AdDetails>> newPostAdSubmit(NewPostAdModalState state,String token) async {
    try {
      final result = await remoteDataSource.newPostAdSubmit(state,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  @override
  Future<Either<Failure, String>> newAdEditSubmit(NewEditAdModalState state,String token,String id) async {
    try {
      final result = await remoteDataSource.newAdEditSubmit(state,token,id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}