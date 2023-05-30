import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/modules/post_ad/controller/postad_repository.dart';

import '../../../../core/error/failure.dart';
import '../../home/model/ad_model.dart';
import '../../home/model/category_model.dart';

part 'postad_event.dart';
part 'postad_state.dart';

class PostAdBloc extends Bloc<PostAdEvent, PostAdModalState> {
  final PostAdRepository _postAdRepository;
  final HomeControllerCubit _homeControllerCubit;
  final basicFormKey = GlobalKey<FormState>();
  final featureFormKey = GlobalKey<FormState>();

  List<Category> get categoryList => _homeControllerCubit.homeModel.categories;

  List<Brand> subCategoryList = [];
  Brand? subCategory;

  var nameController = TextEditingController(text: "");
  var priceController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var backupPhoneController = TextEditingController(text: "");
  var weChatController = TextEditingController(text: "");
  var descriptionController = TextEditingController(text: "");
  var locationController = TextEditingController(text: "");

  PostAdBloc({
    required PostAdRepository postAdRepository,
    required HomeControllerCubit homeControllerCubit,
  })  : _postAdRepository = postAdRepository,
        _homeControllerCubit = homeControllerCubit,
        super(const PostAdModalState()) {
    on<PostAdEventName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<PostAdEventPrice>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<PostAdEventCategory>((event, emit) {
      Category category = categoryList.singleWhere((element) => element.id == int.parse(event.category));
      subCategoryList = category.subCategoryList.toSet().toList();
      if (subCategoryList.isNotEmpty) {
        subCategory = subCategoryList[0];
        emit(state.copyWith(subCategory: '${subCategory?.id.toString()}'));
      } else {
        emit(state.copyWith(subCategory: ''));
      }
      emit(state.copyWith(category: event.category));
    });
    on<PostAdEventSubCategory>((event, emit) {
      subCategory = event.subCategoryData;
      emit(state.copyWith(subCategory: event.subCategory));
    });
    on<PostAdEventPhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<PostAdEventShowPhone>((event, emit) {
      emit(state.copyWith(isShowPhone: event.isShowPhone));
    });
    on<PostAdEventBackupPhone>((event, emit) {
      emit(state.copyWith(backupPhone: event.backupPhone));
    });
    on<PostAdEventWeChat>((event, emit) {
      emit(state.copyWith(weChat: event.weChat));
    });
    on<PostAdEventDescription>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<PostAdEventFeature>((event, emit) {
      emit(state.copyWith(features: event.features));
    });
    on<PostAdEventLocation>((event, emit) {
      emit(state.copyWith(location: event.location));
    });
    on<PostAdEventImages>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
    on<PostAdEventBrand>((event, emit) {
      emit(state.copyWith(brand: event.brand));
    });
    on<PostAdEventSubmit>(_submitPostAdForm);

  }


  Future<void> _submitPostAdForm(
      PostAdEventSubmit event,
      Emitter<PostAdModalState> emit,
      ) async {
    if (!featureFormKey.currentState!.validate()) return;

    emit(state.copyWith(state: const PostAdStateLoading()));
    final bodyData = state.toMap();
    print(event.token);

    final result = await _postAdRepository.postAdSubmit(state,event.token);

    result.fold(
          (Failure failure) {
        final error = PostAdStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
          (message) async {
        final loadedData = PostAdStateLoaded(message);
        nameController.text = '';
        priceController.text = '';
        phoneController.text = '';
        backupPhoneController.text = '';
        weChatController.text = '';
        descriptionController.text = '';
        locationController.text = '';
        emit(state.copyWith(
            name: "",
            price: "",
            category: "",
            subCategory: "",
            phone: "",
            isShowPhone: false,
            backupPhone: "",
            weChat: "",
            description: "",
            features: [],
            location: "",
            images: [],
            brand: "",
            state: loadedData));
        // await Future.delayed(const Duration(seconds: 1)).then((value) {
        //   emit(state.copyWith(
        //       name: "",
        //       price: "",
        //       category: "",
        //       subCategory: "",
        //       phone: "",
        //       isShowPhone: false,
        //       backupPhone: "",
        //       weChat: "",
        //       description: "",
        //       features: [],
        //       location: "",
        //       images: [],
        //       brand: "",
        //       state: const PostAdStateInitial()
        //   ));
        // });
      },
    );
  }



}
