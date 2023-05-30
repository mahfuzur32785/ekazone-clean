import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../ad_details/model/ad_details_model.dart';
import '../../../home/controller/cubit/home_controller_cubit.dart';
import '../../../home/model/brand_model.dart';
import '../../../home/model/category_model.dart';
import '../../../home/model/model_model.dart';
import '../../../post_ad/controller/postad_repository.dart';

part 'new_ad_edit_event.dart';
part 'new_ad_edit_state.dart';

class NewEditAdBloc extends Bloc<NewEditAdEvent, NewEditAdModalState> {
  final PostAdRepository _postAdRepository;
  final HomeControllerCubit _homeControllerCubit;
  final featureFormKey = GlobalKey<FormState>();

  List<Category> get categoryList =>
      _homeControllerCubit.homeModel.categories.reversed.toList();
  // List<BrandModel> get brandList => _homeControllerCubit.homeModel.brandList.where((element) => element.categoryId.toString() == state.category).toList();
  // List<Model> get designationList => _homeControllerCubit.homeModel.designations;

  List<Model> modelList = [];
  Model? model;
  List<Model> get serviceTypeList =>
      _homeControllerCubit.homeModel.serviceTypeList;
  List<Model> get designationList =>
      _homeControllerCubit.homeModel.designations;

  // CustomFieldDataModel? customFieldDataModel;

  Category? category;
  List<Brand> subCategoryList = [];
  Brand? subCategory;
  List<BrandModel> brandList = [];
  BrandModel? brandModel;

  var titleController = TextEditingController(text: "");
  var priceController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var backupPhoneController = TextEditingController(text: "");
  var webSiteController = TextEditingController(text: "");
  var descriptionController = TextEditingController(text: "");
  var locationController = TextEditingController(text: "");
  var whatsappController = TextEditingController(text: "");
  var modelController = TextEditingController(text: "");

  var experienceController = TextEditingController(text: "");
  var employerNameController = TextEditingController(text: "");
  var deadlineController = TextEditingController(text: "");
  var salaryFromController = TextEditingController(text: "");
  var salaryToController = TextEditingController(text: "");

  var trimEditionController = TextEditingController(text: "");
  var yearOfManuController = TextEditingController(text: "");
  var enginCapacityController = TextEditingController(text: "");
  var registrationYearController = TextEditingController(text: "");

  NewEditAdBloc({
    required PostAdRepository postAdRepository,
    required HomeControllerCubit homeControllerCubit,
  })  : _postAdRepository = postAdRepository,
        _homeControllerCubit = homeControllerCubit,
        super(const NewEditAdModalState()) {
    on<NewEditAdEventEmpty>(_clearAll);

    on<NewEditAdEventName>((event, emit) {
      emit(state.copyWith(title: event.name));
    });
    on<NewEditAdEventPrice>((event, emit) {
      emit(state.copyWith(price: event.price));
    });

    on<NewEditAdEventCategory>((event, emit) {
      Category category = categoryList
          .singleWhere((element) => element.id == int.parse(event.category));
      subCategoryList = category.subCategoryList.toSet().toList();
      if (subCategoryList.isNotEmpty) {
        subCategory = subCategoryList[0];
        emit(state.copyWith(subCategory: '${subCategory?.id.toString()}'));
      } else {
        emit(state.copyWith(subCategory: ''));
      }

      // brandList = category.brandList.toSet().toList();
      // if (brandList.isNotEmpty) {
      //   brandModel = brandList[0];
      //   emit(state.copyWith(brandId: '${brandModel?.id.toString()}'));
      // } else {
      //   emit(state.copyWith(brandId: ''));
      // }
      emit(state.copyWith(category: event.category));
    });

    on<NewEditAdEventSubCategory>((event, emit) {
      subCategory = event.subCategoryData;
      emit(state.copyWith(subCategory: event.subCategory));
    });
    on<NewEditAdEventPhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<NewEditAdEventShowPhone>((event, emit) {
      emit(state.copyWith(isShowPhone: event.isShowPhone));
    });

    on<NewEditAdEventReceivedEmail>((event, emit) {
      emit(state.copyWith(isReceivedEmail: event.isReceivedEmail));
    });
    on<NewEditAdEventReceivedPhone>((event, emit) {
      emit(state.copyWith(isReceivedPhone: event.isReceivedPhone));
    });

    on<NewEditAdEventEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<NewEditAdEventShowEmail>((event, emit) {
      emit(state.copyWith(isShowEmail: event.isShowEmail));
    });
    on<NewEditAdEventBackupPhone>((event, emit) {
      emit(state.copyWith(backupPhone: event.backupPhone));
    });
    on<NewEditAdEventWhatsapp>((event, emit) {
      emit(state.copyWith(whatsapp: event.whatsapp));
    });
    on<NewEditAdEventShowWhatsapp>((event, emit) {
      emit(state.copyWith(isShowWhatsapp: event.isShowWhatsapp));
    });
    on<NewEditAdEventWebsiteValue>((event, emit) {
      emit(state.copyWith(employerWebsite: event.websiteString));
    });
    on<NewEditAdEventDescription>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<NewEditAdEventFeature>((event, emit) {
      emit(state.copyWith(features: event.features));
    });
    on<NewEditAdEventLocation>((event, emit) {
      locationController.text = event.location;
      emit(state.copyWith(location: event.location));
    });
    on<NewEditAdEventImages>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
    on<NewEditAdEventFeatureImage>((event, emit) {
      emit(state.copyWith(thumbnail: event.thumbnail));
    });
    on<NewEditAdEventDeleteImage>((event, emit) {
      emit(state.copyWith(deleteImage: event.imageIds));
    });
    on<NewEditAdEventServiceTypeId>((event, emit) {
      emit(state.copyWith(service_type_id: event.value1));
    });
    on<NewEditAdEventExperience>((event, emit) {
      emit(state.copyWith(experience: event.value1));
    });
    on<NewEditAdEventEducations>((event, emit) {
      emit(state.copyWith(educations: event.value1));
    });
    on<NewEditAdEventDesignation>((event, emit) {
      emit(state.copyWith(designation: event.value1));
    });
    on<NewEditAdEventSalaryFrom>((event, emit) {
      emit(state.copyWith(salary_from: event.value1));
    });
    on<NewEditAdEventSalaryTo>((event, emit) {
      emit(state.copyWith(salary_to: event.value1));
    });
    on<NewEditAdEventDeadline>((event, emit) {
      emit(state.copyWith(deadline: event.value1));
    });
    on<NewEditAdEventEmployerName>((event, emit) {
      emit(state.copyWith(employerName: event.value1));
    });
    on<NewEditAdEventEmploymentType>((event, emit) {
      emit(state.copyWith(jobType: event.value1));
    });
    on<NewEditAdEventStatusType>((event, emit) {
      emit(state.copyWith(status: event.value1));
    });
    on<NewEditAdEventEmployerWebsite>((event, emit) {
      emit(state.copyWith(employerWebsite: event.value1));
    });
    on<NewEditAdEventEmployeeLogo>((event, emit) {
      emit(state.copyWith(employerLogo: event.value1));
    });
    on<NewEditAdEventCondition>((event, emit) {
      emit(state.copyWith(condition: event.value1));
    });
    on<NewEditAdEventTextBookType>((event, emit) {
      emit(state.copyWith(textbookType: event.value1));
    });
    on<NewEditAdEventAuthenticity>((event, emit) {
      emit(state.copyWith(authenticity: event.value1));
    });
    on<NewEditAdEventRam>((event, emit) {
      emit(state.copyWith(ram: event.value1));
    });
    on<NewEditAdEventEdition>((event, emit) {
      emit(state.copyWith(edition: event.value1));
    });
    on<NewEditAdEventProductModel>((event, emit) {
      // model = event.model;
      emit(state.copyWith(model: event.value1));
    });
    on<NewEditAdEventProductBrandId>((event, emit) {
      emit(state.copyWith(brandId: event.value1));
    });

    on<NewEditAdEventProcessor>((event, emit) {
      emit(state.copyWith(processor: event.value1));
    });
    on<NewEditAdEventTrimEdition>((event, emit) {
      emit(state.copyWith(edition: event.value1));
    });
    on<NewEditAdEventYearOfManufacture>((event, emit) {
      emit(state.copyWith(year_of_manufacture: event.value1));
    });
    on<NewEditAdEventEngineCapacity>((event, emit) {
      emit(state.copyWith(engine_capacity: event.value1));
    });
    on<NewEditAdEventTransmission>((event, emit) {
      emit(state.copyWith(transmission: event.value1));
    });
    on<NewEditAdEventRegistrationYear>((event, emit) {
      emit(state.copyWith(registration_year: event.value1));
    });
    on<NewEditAdEventBodyType>((event, emit) {
      emit(state.copyWith(body_type: event.value1));
    });
    on<NewEditAdEventFuelType>((event, emit) {
      emit(state.copyWith(vehicleFuleType: event.value1));
    });
    on<NewEditAdEventPropertyType>((event, emit) {
      emit(state.copyWith(property_type: event.value1));
    });
    on<NewEditAdEventSize>((event, emit) {
      emit(state.copyWith(size: event.value1));
    });
    on<NewEditAdEventSizeType>((event, emit) {
      emit(state.copyWith(size_type: event.value1));
    });
    on<NewEditAdEventPropertyLocation>((event, emit) {
      emit(state.copyWith(property_location: event.value1));
    });
    on<NewEditAdEventPriceType>((event, emit) {
      emit(state.copyWith(price_type: event.value1));
    });
    on<NewEditAdEventAnimalType>((event, emit) {
      emit(state.copyWith(animal_type: event.value1));
    });

    on<NewEditAdEventLoadOldData>(_loadOldData);
    on<NewEditAdEventSubmit>(_submitPostAdForm);
  }

  Future<void> _submitPostAdForm(
    NewEditAdEventSubmit event,
    Emitter<NewEditAdModalState> emit,
  ) async {
    if (!featureFormKey.currentState!.validate()) return;
    featureFormKey.currentState!.save();
    // print("logo"+ state.employer_logo);
    // print("data : ${state.toMap()}");
    // return;
    emit(state.copyWith(state: const NewEditAdStateLoading()));
    final bodyData = state.toMap();
    print(event.token);
    print(event.id);
    print('Edit BodyData $bodyData');

    final result = await _postAdRepository.newAdEditSubmit(
        state, event.token, event.id.toString());

    result.fold(
      (Failure failure) {
        final error = NewEditAdStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (message) async {
        final loadedData = NewEditAdStateLoaded(message, true);
        titleController.text = '';
        priceController.text = '';
        phoneController.text = '';
        backupPhoneController.text = '';
        emailController.text = '';
        webSiteController.text = '';
        descriptionController.text = '';
        locationController.text = '';
        emit(state.copyWith(
            title: "",
            price: "",
            category: "",
            subCategory: "",
            phone: "",
            isShowPhone: false,
            backupPhone: "",
            whatsapp: "",
            description: "",
            features: [],
            location: "",
            thumbnail: "",
            images: [],
            deleteImage: [],
            service_type_id: '',
            experience: '',
            educations: '',
            designation: '',
            salary_from: '',
            salary_to: '',
            deadline: '',
            employerName: '',
            jobType: '',
            status: '',
            employerWebsite: '',
            employerLogo: '',
            condition: '',
            textbookType: '',
            authenticity: '',
            ram: '',
            edition: '',
            model: '',
            brandId: '',
            processor: '',
            year_of_manufacture: '',
            engine_capacity: '',
            transmission: '',
            registration_year: '',
            body_type: '',
            vehicleFuleType: [],
            property_type: '',
            size: '',
            size_type: 'sqft',
            property_location: '',
            price_type: 'total price',
            animal_type: '',
            state: loadedData));
      },
    );
  }

  void _loadOldData(NewEditAdEventLoadOldData event,
      Emitter<NewEditAdModalState> emit) async {
    print("Ad Model Data Is: ${event.adModel.toMap().toString()}");

    titleController.text = event.adModel.title;
    priceController.text = event.adModel.price.toString();
    phoneController.text = event.adModel.phone;
    emailController.text = event.adModel.email;
    backupPhoneController.text = event.adModel.phone2;
    webSiteController.text = event.adModel.website ?? '';
    whatsappController.text = event.adModel.whatsapp ?? '';
    descriptionController.text = event.adModel.description;
    locationController.text = event.adModel.address ?? '';
    modelController.text = event.adModel.model ?? '';
    subCategory = null;

    experienceController.text = event.adModel.experience ?? '';
    employerNameController.text = event.adModel.employerName ?? '';
    deadlineController.text = event.adModel.deadline ?? '';
    salaryFromController.text = event.adModel.salaryFrom ?? '';
    salaryToController.text = event.adModel.salaryTo ?? '';

    trimEditionController.text = event.adModel.edition ?? '';
    yearOfManuController.text = event.adModel.vehicleManufacture ?? '';
    enginCapacityController.text = event.adModel.vehicleEngineCapacity ?? '';
    registrationYearController.text = event.adModel.registrationYear ?? '';

    if (event.adModel.categoryId != 0) {
      Category category = categoryList
          .singleWhere((element) => element.id == event.adModel.categoryId);
      this.category = category;
      subCategoryList = category.subCategoryList.toSet().toList();
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        if (subCategoryList.isNotEmpty && event.adModel.subcategoryId != 0) {
          Brand brand = subCategoryList.singleWhere(
              (element) => element.id == event.adModel.subcategoryId);
          subCategory = brand;
        } else {
          subCategory = null;
        }
      });
    }

    ///load country
    if (event.adModel.categoryId != 0) {
      Category category = categoryList
          .singleWhere((element) => element.id == event.adModel.categoryId);
      this.category = category;
      brandList = category.brandList.toSet().toList();
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        if (brandList.isNotEmpty) {
          BrandModel brand = brandList.singleWhere(
              (element) => element.id == int.parse(event.adModel.brandId));
          brandModel = brand;
        } else {
          brandModel = null;
        }
      });
    }

    List<String> features = [];

    features.addAll(event.adModel.adFeatures.map((e) => e.name).toList());

    emit(state.copyWith(
      title: event.adModel.title,
      isShowPhone: event.adModel.showPhone,
      backupPhone: event.adModel.phone2,
      category: '${event.adModel.categoryId}',
      subCategory:
          event.adModel.categoryId != 0 ? '${event.adModel.subcategoryId}' : '',
      description: event.adModel.description,
      features: features,
      thumbnail: event.adModel.thumbnail,
      images: [],
      location: event.adModel.address,
      phone: event.adModel.phone,
      email: event.adModel.email,
      isShowEmail: event.adModel.showEmail == '1' ? true : false,
      isShowWhatsapp: event.adModel.showWhatsapp == '1' ? true : false,
      price: event.adModel.price.toString(),
      whatsapp: event.adModel.whatsapp,

      // service_type_id: event.adModel.serviceTypeId ?? '',
      experience: event.adModel.experience ?? '',
      educations: event.adModel.required_education ?? '',
      designation: event.adModel.designation ?? '',
      salary_from: event.adModel.salaryFrom ?? '',
      salary_to: event.adModel.salaryTo ?? '',
      deadline: event.adModel.deadline ?? '',
      employerName: event.adModel.employerName ?? '',
      jobType: event.adModel.jobType ?? '',
      // status: event.adModel.status ?? '',
      employerLogo: event.adModel.employerLogo ?? '',
      condition: event.adModel.condition ?? '',
      textbookType: event.adModel.textbookType ?? '',

      authenticity: event.adModel.authenticity ?? '',
      // ram: event.adModel.ram ?? '',
      edition: event.adModel.edition ?? '',
      // product_model_id: event.adModel.productModelId ?? '',
      brandId:
          event.adModel.brandId == null ? '' : event.adModel.brandId.toString(),
      // processor: event.adModel.processor ?? '',
      year_of_manufacture: event.adModel.vehicleManufacture ?? '',
      engine_capacity: event.adModel.vehicleEngineCapacity ?? '',
      transmission: event.adModel.vehicleTransmission ?? '',
      registration_year: event.adModel.registrationYear ?? '',
      body_type: event.adModel.vehicleBodyType ?? '',
      vehicleFuleType: event.adModel.vehicleFuleType ?? [],
      // property_type: event.adModel.pr ?? '',
      // bedroom: event.adModel.bedroom == null ? '' : event.adModel.bedroom.toString(),
      size: event.adModel.propertySize ?? '',
      size_type: event.adModel.propertyUnit ?? '',
      property_location: event.adModel.address ?? '',
      price_type: event.adModel.propertyPriceType ?? '',
      // animal_type: event.adModel.animalType ?? '',
      website: event.adModel.website,

      state: const NewEditAdStateLoaded("", false),
    ));
  }

  void _clearAll(
    NewEditAdEventEmpty event,
    Emitter<NewEditAdModalState> emit,
  ) async {
    titleController.text = '';
    priceController.text = '';
    phoneController.text = '';
    backupPhoneController.text = '';
    emailController.text = '';
    webSiteController.text = '';
    descriptionController.text = '';
    locationController.text = '';
    modelController.text = '';

    experienceController.text = '';
    employerNameController.text = '';
    deadlineController.text = '';
    salaryFromController.text = '';
    salaryToController.text = '';

    trimEditionController.text = '';
    yearOfManuController.text = '';
    enginCapacityController.text = '';
    registrationYearController.text = '';

    emit(state.copyWith(
        title: '',
        thumbnail: '',
        isShowWhatsapp: false,
        price: '',
        category: '',
        subCategory: '',
        phone: '',
        isShowPhone: false,
        email: '',
        isShowEmail: false,
        backupPhone: '',
        website: '',
        whatsapp: '',
        description: '',
        features: [],
        location: '',
        images: [],
        service_type_id: '',
        experience: '',
        educations: '',
        designation: '',
        salary_from: '',
        salary_to: '',
        deadline: '',
        employerName: '',
        jobType: '',
        status: '',
        employerWebsite: '',
        employerLogo: '',
        condition: '',
        textbookType: '',
        authenticity: '',
        ram: '',
        edition: '',
        model: '',
        brandId: '',
        processor: '',
        year_of_manufacture: '',
        engine_capacity: '',
        transmission: '',
        registration_year: '',
        body_type: '',
        vehicleFuleType: [],
        property_type: '',
        size: '',
        size_type: 'sqft',
        property_location: '',
        price_type: 'total price',
        animal_type: '',
        state: const NewEditAdStateInitial()));
  }
}
