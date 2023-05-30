part of 'new_posted_bloc.dart';

class NewPostAdModalState extends Equatable {
  final String id;
  final String name;
  final String price;
  final String category;
  final String subCategory;
  final String phone;
  final bool isShowPhone;
  final String email;
  final bool isShowEmail;
  final String backupPhone;
  final String whatsapp;
  final bool isShowWhatsapp;
  final String description;
  final List<String> features;
  final String location;
  final String lat;
  final String long;
  final String website;
  final List<String> images;
  final String thumbnail;
  final String employerLogo;
  // final Map customFields;
  final String service_type_id;
  final String experience;
  final String educations;
  final String application_received;
  final String employerEmail;
  final String employerPhone;
  final String designation;
  final String designation_id;
  final String salary_from;
  final String salary_to;
  final String deadline;
  final String employer_name;
  final String employment_type;
  final String job_type;
  final String employer_website;
  final String employer_logo;
  final String condition;
  final String brandId;
  final String authenticity;
  final String textBookType;
  final String ram;
  final String model;
  final String processor;
  final String edition;
  final String vehicle_manufacture;
  final String vehicle_engine_capacity;
  final String transmission;
  final String registration_year;
  final String vehicle_body_type;
  final List<String> vehicle_fule_type;
  final String property_type;
  final String bedroom;
  final String size;
  final String size_type;
  final String property_location;
  final String price_type;
  final String animal_type;
  final NewPostAdState state;

  final bool receiveIsEmail;
  final bool receiveIsPhone;
  final bool isPaymentChecked;

  const NewPostAdModalState({
    this.id = '',
    this.name = '',
    this.price = '',
    this.email = '',
    this.isShowPhone = false,
    this.receiveIsEmail = false,
    this.receiveIsPhone = false,
    this.category = '',
    this.subCategory = '',
    this.phone = '',
    this.isShowEmail = false,
    this.backupPhone = '',
    this.whatsapp = '',
    this.isShowWhatsapp = false,
    this.description = '',
    this.features = const [],
    this.location = '',
    this.lat = '',
    this.long = '',
    this.website = '',
    this.images = const [],
    this.thumbnail = '',
    this.employerLogo = '',
    // this.customFields = const {},
    this.service_type_id = '',
    this.experience = '',
    this.educations = '',
    this.application_received = '',
    this.employerEmail = '',
    this.employerPhone = '',
    this.designation = '',
    this.designation_id = '',
    this.salary_from = '',
    this.salary_to = '',
    this.deadline = '',
    this.employer_name = '',
    this.employment_type = '',
    this.job_type = '',
    this.employer_website = '',
    this.employer_logo = '',
    this.condition = '',
    this.authenticity = '',
    this.textBookType = '',
    this.ram = '',
    this.model = '',
    this.brandId = '',
    this.processor = '',
    this.edition = '',
    this.vehicle_manufacture = '',
    this.vehicle_engine_capacity = '',
    this.transmission = '',
    this.registration_year = '',
    this.vehicle_body_type = '',
    this.vehicle_fule_type = const [],
    this.property_type = '',
    this.bedroom = '',
    this.size = '',
    this.size_type = 'sqft',
    this.property_location: '',
    this.price_type: 'total price',
    this.animal_type = '',
    this.state = const NewPostAdStateInitial(),
    this.isPaymentChecked = false,

  });

  NewPostAdModalState copyWith({
    String? id,
    String? name,
    String? price,
    String? category,
    String? subCategory,
    String? phone,
    bool? isShowPhone,
    bool? receiveIsEmail,
    bool? receiveIsPhone,
    String? email,
    bool? isShowEmail,
    String? backupPhone,
    String? whatsapp,
    bool? isShowWhatsapp,
    String? description,
    List<String>? features,
    String? location,
    String? lat,
    String? long,
    String? website,
    List<String>? images,
    String? thumbnail,
    String? employerLogo,
    // Map? customFields,
    String? service_type_id,
    String? experience,
    String? educations,
    String? application_received,
    String? designation,
    String? designation_id,
    String? salary_from,
    String? salary_to,
    String? deadline,
    String? employer_name,
    String? employerEmail,
    String? employerPhone,
    String? employment_type,
    String? job_type,
    String? employer_website,
    String? employer_logo,
    String? condition,
    String? authenticity,
    String? textBookType,
    String? ram,
    String? model,
    String? brandId,
    String? processor,
    String? edition,
    String? vehicle_manufacture,
    String? vehicle_engine_capacity,
    String? transmission,
    String? registration_year,
    String? vehicle_body_type,
    List<String>? vehicle_fule_type,
    String? property_type,
    String? bedroom,
    String? size,
    String? size_type,
    String? property_location,
    String? price_type,
    String? animal_type,
    NewPostAdState? state,
    bool? isPaymentChecked,
  }) {
    return NewPostAdModalState(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      phone: phone ?? this.phone,
      isShowPhone: isShowPhone ?? this.isShowPhone,
      receiveIsPhone: receiveIsPhone ?? this.receiveIsPhone,
      receiveIsEmail: receiveIsEmail ?? this.receiveIsEmail,
      email: email ?? this.email,
      isShowEmail: isShowEmail ?? this.isShowEmail,
      backupPhone: backupPhone ?? this.backupPhone,
      whatsapp: whatsapp ?? this.whatsapp,
      isShowWhatsapp: isShowWhatsapp ?? this.isShowWhatsapp,
      description: description ?? this.description,
      features: features ?? this.features,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      website: website ?? this.website,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      employerLogo: employerLogo ?? this.employerLogo,
      // customFields: customFields ?? this.customFields,
      service_type_id: service_type_id ?? this.service_type_id,
      experience: experience ?? this.experience,
      educations: educations ?? this.educations,
      application_received: application_received ?? this.application_received,
      employerEmail: employerEmail ?? this.employerEmail,
      employerPhone: employerPhone ?? this.employerPhone,
      designation: designation ?? this.designation,
      designation_id: designation_id ?? this.designation_id,
      salary_from: salary_from ?? this.salary_from,
      salary_to: salary_to ?? this.salary_to,
      deadline: deadline ?? this.deadline,
      employer_name: employer_name ?? this.employer_name,
      employment_type: employment_type ?? this.employment_type,
      job_type: job_type ?? this.job_type,
      employer_website: employer_website ?? this.employer_website,
      employer_logo: employer_logo ?? this.employer_logo,
      condition: condition ?? this.condition,
      authenticity: authenticity ?? this.authenticity,
      textBookType: textBookType ?? this.textBookType,
      ram: ram ?? this.ram,
      model: model ?? this.model,
      brandId: brandId ?? this.brandId,
      processor: processor ?? this.processor,
      edition: edition ?? this.edition,
      vehicle_manufacture: vehicle_manufacture ?? this.vehicle_manufacture,
      vehicle_engine_capacity:
          vehicle_engine_capacity ?? this.vehicle_engine_capacity,
      transmission: transmission ?? this.transmission,
      registration_year: registration_year ?? this.registration_year,
      vehicle_body_type: vehicle_body_type ?? this.vehicle_body_type,
      vehicle_fule_type: vehicle_fule_type ?? this.vehicle_fule_type,
      property_type: property_type ?? this.property_type,
      bedroom: bedroom ?? this.bedroom,
      size: size ?? this.size,
      size_type: size_type ?? this.size_type,
      property_location: property_location ?? this.property_location,
      price_type: price_type ?? this.price_type,
      animal_type: animal_type ?? this.animal_type,
      state: state ?? this.state,
      isPaymentChecked: isPaymentChecked ?? this.isPaymentChecked,

    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': name.trim()});
    result.addAll({'price': price.trim()});
    result.addAll({'category_id': category});
    result.addAll({'subcategory_id': subCategory});
    result.addAll({'phone': phone.trim()});
    result.addAll({'show_phone': isShowPhone ? '1' : '0'});
    result.addAll({'receive_is_phone': receiveIsPhone ? '1' : '0'});
    result.addAll({'receive_is_email': receiveIsEmail ? '1' : '0'});
    result.addAll({'email': email.trim()});
    result.addAll({'show_email': isShowEmail ? '1' : '0'});
    result.addAll({'phone_2': backupPhone.trim()});
    result.addAll({'whatsapp': whatsapp.trim()});
    result.addAll({'show_whatsapp': isShowWhatsapp ? '1' : '0'});
    result.addAll({'description': description.trim()});
    result.addAll({'features': features.map((e) => e).toList()});

    result.addAll({'address': location.trim()});
    result.addAll({'lat': lat.trim()});
    result.addAll({'long': long.trim()});
    result.addAll({'website': website.trim()});
    result.addAll({'featured': '0'});
    // result.addAll({'custom_fields': json.encode(customFields)});
    result.addAll({'service_type_id': service_type_id.trim()});
    result.addAll({'experience': experience.trim()});
    result.addAll({'required_education': educations.trim()});
    result.addAll({'application_receive': application_received.trim()});
    result.addAll({'employer_email': employerEmail.trim()});
    result.addAll({'employer_phone': employerPhone.trim()});
    result.addAll({'designation': designation.trim()});
    result.addAll({'designation_id': designation_id.trim()});
    result.addAll({'salary_from': salary_from.trim()});
    result.addAll({'salary_to': salary_to.trim()});
    result.addAll({'deadline': deadline.trim()});
    result.addAll({'employer_name': employer_name.trim()});
    result.addAll({'employment_type': employment_type.trim()});
    result.addAll({'job_type': job_type.trim()});
    result.addAll({'employer_website': employer_website.trim()});
    result.addAll({'employer_logo': employer_logo.trim()});
    result.addAll({'condition': condition.trim()});
    result.addAll({'authenticity': authenticity.trim()});
    result.addAll({'textbook_type': textBookType.trim()});
    result.addAll({'ram': ram.trim()});
    result.addAll({'model': model.trim()});
    result.addAll({'brand_id': brandId.trim()});
    result.addAll({'processor': processor.trim()});
    result.addAll({'edition': edition.trim()});
    result.addAll({'vehicle_manufacture': vehicle_manufacture.trim()});
    result.addAll({'vehicle_engine_capacity': vehicle_engine_capacity.trim()});
    result.addAll({'vehicle_transmission': transmission.trim()});
    result.addAll({'registration_year': registration_year.trim()});
    result.addAll({'vehicle_body_type': vehicle_body_type.trim()});
    result.addAll({'vehicle_fule_type': vehicle_fule_type.map((e) => e).toList()});
    result.addAll({'property_type': property_type.trim()});
    result.addAll({'bedroom': bedroom.trim()});
    result.addAll({'property_size': size.trim()});
    result.addAll({'property_unit': size_type.trim()});
    result.addAll({'property_location': property_location.trim()});
    result.addAll({'property_price_type': price_type.trim()});
    result.addAll({'animal_type': animal_type.trim()});
    result.addAll({'images': images.map((e) => e).toList()});
    result.addAll({'thumbnail': thumbnail.trim()});
    result.addAll({'employer_logo': employerLogo.trim()});

    // result.addAll({'state': state});
    return result;
  }

  factory NewPostAdModalState.fromMap(Map<String, dynamic> map) {
    return NewPostAdModalState(
      id: map['id'] ?? '',
      name: map['title'] ?? '',
      price: map['price'] ?? '',
      category: map['category_id'] ?? '',
      subCategory: map['subcategory_id'] ?? '',
      phone: map['phone'] ?? '',
      isShowPhone: map['show_phone'] ?? false,
      receiveIsPhone: map['receive_is_phone'] ?? false,
      receiveIsEmail: map['receive_is_email'] ?? false,
      email: map['email'] ?? '',
      isShowEmail: map['show_email'] ?? false,
      backupPhone: map['phone_2'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      isShowWhatsapp: map['show_whatsapp'] ?? false,
      description: map['description'] ?? '',
      features: map['features[]'] ?? [],
      location: map['address'] ?? '',
      lat: map['lat'] ?? '',
      long: map['long'] ?? '',
      website: map['website'] ?? '',
      images: map['images[]'] ?? [],
      thumbnail: map['thumbnail'] ?? '',
      employerLogo: map['employer_logo'] ?? '',
      // customFields: map['custom_fields'] ?? {},
      service_type_id: map['service_type_id'] ?? '',
      experience: map['experience'] ?? '',
      educations: map['required_education'] ?? '',
      application_received: map['application_receive'] ?? '',
      employerEmail: map['employer_email'] ?? '',
      employerPhone: map['employer_phone'] ?? '',
      designation: map['designation'] ?? '',
      designation_id: map['designation_id'] ?? '',
      salary_from: map['salary_from'] ?? '',
      salary_to: map['salary_to'] ?? '',
      deadline: map['deadline'] ?? '',
      employer_name: map['employer_name'] ?? '',
      employment_type: map['employment_type'] ?? '',
      job_type: map['job_type'] ?? '',
      employer_website: map['employer_website'] ?? '',
      employer_logo: map['employer_logo'] ?? '',
      condition: map['condition'] ?? '',
      authenticity: map['authenticity'] ?? '',
      textBookType: map['textbook_type'] ?? '',
      ram: map['ram'] ?? '',
      model: map['model'] ?? '',
      brandId: map['brand_id'] ?? '',
      processor: map['processor'] ?? '',
      edition: map['edition'] ?? '',
      vehicle_manufacture: map['vehicle_manufacture'] ?? '',
      vehicle_engine_capacity: map['vehicle_engine_capacity'] ?? '',
      transmission: map['vehicle_transmission'] ?? '',
      registration_year: map['registration_year'] ?? '',
      vehicle_body_type: map['vehicle_body_type'] ?? '',
      vehicle_fule_type: map['vehicle_fule_type'] ?? [],
      property_type: map['property_type'] ?? '',
      bedroom: map['bedroom'] ?? '',
      size: map['property_size'] ?? '',
      size_type: map['property_unit'] ?? '',
      property_location: map['property_location'] ?? '',
      price_type: map['property_price_type'] ?? '',
      animal_type: map['animal_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewPostAdModalState.fromJson(String source) =>
      NewPostAdModalState.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewPostAdModalState(id: $id,title: $name, price: $price, category_id: $category, subcategory_id: $subCategory, authenticity:$authenticity, textBookType:$textBookType, thumbnail: $thumbnail,employerLogo: $employerLogo, phone: $phone, phone_2: $backupPhone, whatsapp: $whatsapp, description: $description, address: $location, lat:$lat, long:$long website: $website,features[]:$features, images[]: $images, state: $state)';

  @override
  List<Object> get props => [
        id,
        name,
        price,
        category,
        subCategory,
        phone,
        isShowPhone,
    receiveIsEmail,
    receiveIsPhone,
        email,
        isShowEmail,
        backupPhone,
        whatsapp,
        isShowWhatsapp,
        description,
        features,
        location,
        website,
        images,
        thumbnail,
    employerLogo,
        // customFields,
        service_type_id,
        experience,
        educations,
    application_received,
    employerEmail,
    employerPhone,
        designation,
        designation_id,
    salary_from,
    salary_to,
        deadline,
        employer_name,
        employment_type,
        job_type,
        employer_website,
        employer_logo,
        condition,
        authenticity,
        textBookType,
        ram,
        model,
        brandId,
        processor,
        edition,
        vehicle_manufacture,
        vehicle_engine_capacity,
        transmission,
        registration_year,
        vehicle_body_type,
        vehicle_fule_type,
        property_type,
        bedroom,
        size,
        size_type,
        property_location,
        price_type,
        animal_type,
        state,
    isPaymentChecked,
      ];
}

abstract class NewPostAdState extends Equatable {
  const NewPostAdState();

  @override
  List<Object> get props => [];
}

class NewPostAdStateInitial extends NewPostAdState {
  const NewPostAdStateInitial();
}

class NewPostAdStateLoading extends NewPostAdState {
  const NewPostAdStateLoading();
}

class NewPostAdStateError extends NewPostAdState {
  final String errorMsg;
  final int statusCode;

  const NewPostAdStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class NewPostAdStateLoaded extends NewPostAdState {
  final String message;
  final AdDetails adDetails;
  const NewPostAdStateLoaded({required this.message, required this.adDetails});

  @override
  List<Object> get props => [message, adDetails];
}

///.................. custom fields data load ..................
// class NewPostAdStateCustomFiledDataLoading extends NewPostAdState {
//   const NewPostAdStateCustomFiledDataLoading();
// }
//
// class NewPostAdStateCustomFiledDataError extends NewPostAdState {
//   final String errorMsg;
//   final int statusCode;
//
//   const NewPostAdStateCustomFiledDataError(this.errorMsg, this.statusCode);
//
//   @override
//   List<Object> get props => [errorMsg, statusCode];
// }

// class NewPostAdStateCustomFiledDataLoaded extends NewPostAdState {
//   final CustomFieldDataModel customFieldDataModel;
//   const NewPostAdStateCustomFiledDataLoaded(this.customFieldDataModel);
//
//   @override
//   List<Object> get props => [customFieldDataModel];
// }
