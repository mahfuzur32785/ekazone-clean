part of 'new_ad_edit_bloc.dart';

class NewEditAdModalState extends Equatable {
  final String title;
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
  final List<String> images;
  final String thumbnail;
  final List<String> deleteImage;
  final String service_type_id;
  final String model;
  final String experience;
  final String educations;
  final String designation;
  final String salary_from;
  final String salary_to;
  final String deadline;
  final String employerName;
  final String jobType;
  final String website;
  final String employerWebsite;
  final String employerLogo;
  final String condition;
  final String textbookType;
  final String brandId;
  final String authenticity;
  final String ram;
  final String edition;
  final String processor;
  final String year_of_manufacture;
  final String engine_capacity;
  final String transmission;
  final String registration_year;
  final String body_type;
  final List<String> vehicleFuleType;
  final String property_type;
  final String size;
  final String size_type;
  final String property_location;
  final String price_type;
  final String animal_type;
  final String status;

  final dynamic isReceivedEmail;
  final dynamic isReceivedPhone;

  final NewEditAdState state;
  const NewEditAdModalState({
    this.title = '',
    this.price = '',
    this.isReceivedEmail = false,
    this.isReceivedPhone = false,
    this.email = '',
    this.isShowEmail = false,
    this.category = '',
    this.subCategory = '',
    this.phone = '',
    this.isShowPhone = false,
    this.backupPhone = '',
    this.whatsapp = '',
    this.isShowWhatsapp = false,
    this.description = '',
    this.features = const [],
    this.location = '',
    this.images = const [],
    this.thumbnail = '',
    this.deleteImage = const [],
    this.service_type_id = '',
    this.experience = '',
    this.educations = '',
    this.designation = '',
    this.salary_from = '',
    this.salary_to = '',
    this.deadline = '',
    this.employerName = '',
    this.jobType = '',
    this.website = '',
    this.employerWebsite = '',
    this.employerLogo = '',
    this.condition = '',
    this.textbookType = '',
    this.authenticity = '',
    this.ram = '',
    this.edition = '',
    this.model = '',
    this.brandId = '',
    this.processor = '',
    this.year_of_manufacture = '',
    this.engine_capacity = '',
    this.transmission = '',
    this.registration_year = '',
    this.body_type = '',
    this.vehicleFuleType = const [],
    this.property_type = '',
    this.size = '',
    this.size_type = 'sqft',
    this.property_location:'',
    this.price_type: 'total price',
    this.animal_type = '',
    this.status = '',
    this.state = const NewEditAdStateInitial(),
  });

  NewEditAdModalState copyWith({
    String? title,
    String? price,
    String? category,
    String? subCategory,
    String? phone,
    bool? isShowPhone,
    String? email,
    bool? isShowEmail,
    String? backupPhone,
    String? whatsapp,
    bool? isShowWhatsapp,
    String? description,
    List<String>? features,
    String? location,
    List<String>? images,
    String? thumbnail,
    List<String>? deleteImage,
    String? service_type_id,
    String? experience,
    String? educations,
    String? designation,
    String? salary_from,
    String? salary_to,
    String? deadline,
    String? employerName,
    String? jobType,
    String? website,
    String? employerWebsite,
    String? employerLogo,
    String? condition,
    String? textbookType,
    String? authenticity,
    String? ram,
    String? edition,
    String? model,
    String? brandId,
    String? processor,
    String? year_of_manufacture,
    String? engine_capacity,
    String? transmission,
    String? registration_year,
    String? body_type,
    List<String>? vehicleFuleType,
    String? property_type,
    String? size,
    String? size_type,
    String? property_location,
    String? price_type,
    String? animal_type,
    dynamic isReceivedEmail,
    dynamic isReceivedPhone,
    String? status,
    NewEditAdState? state,
  }) {
    return NewEditAdModalState(
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      phone: phone ?? this.phone,
      isShowPhone: isShowPhone ?? this.isShowPhone,
      email: email ?? this.email,
      isShowEmail: isShowEmail ?? this.isShowEmail,
      backupPhone: backupPhone ?? this.backupPhone,
      whatsapp: whatsapp ?? this.whatsapp,
      isShowWhatsapp: isShowWhatsapp ?? this.isShowWhatsapp,
      description: description ?? this.description,
      features: features ?? this.features,
      location: location ?? this.location,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      deleteImage: deleteImage ?? this.deleteImage,
      service_type_id: service_type_id ?? this.service_type_id,
      experience: experience ?? this.experience,
      educations: educations ?? this.educations,
      designation: designation ?? this.designation,
      salary_from: salary_from ?? this.salary_from,
      salary_to: salary_to ?? this.salary_to,
      deadline: deadline ?? this.deadline,
      employerName: employerName ?? this.employerName,
      jobType: jobType ?? this.jobType,
      website: website ?? this.website,
      employerWebsite: employerWebsite ?? this.employerWebsite,
      employerLogo: employerLogo ?? this.employerLogo,
      condition: condition ?? this.condition,
      textbookType: textbookType ?? this.textbookType,
      authenticity: authenticity ?? this.authenticity,
      ram: ram ?? this.ram,
      edition: edition ?? this.edition,
      model: model ?? this.model,
      brandId: brandId ?? this.brandId,
      isReceivedEmail: isReceivedEmail ?? this.isReceivedEmail,
      isReceivedPhone: isReceivedPhone ?? this.isReceivedPhone,
      processor: processor ?? this.processor,
      year_of_manufacture: year_of_manufacture ?? this.year_of_manufacture,
      engine_capacity: engine_capacity ?? this.engine_capacity,
      transmission: transmission ?? this.transmission,
      registration_year: registration_year ?? this.registration_year,
      body_type: body_type ?? this.body_type,
      vehicleFuleType: vehicleFuleType ?? this.vehicleFuleType,
      property_type: property_type ?? this.property_type,
      size: size ?? this.size,
      size_type: size_type ?? this.size_type,
      property_location: property_location ?? this.property_location,
      price_type: price_type ?? this.price_type,
      animal_type: animal_type ?? this.animal_type,
      status: status ?? this.status,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title.trim()});
    result.addAll({'price': price.trim()});
    result.addAll({'category_id': category});
    result.addAll({'subcategory_id': subCategory});
    result.addAll({'phone': phone.trim()});
    result.addAll({'show_phone': isShowPhone ? '1' : '0'});
    result.addAll({'email': email.trim()});
    result.addAll({'show_email': isShowEmail ? '1' : '0'});
    result.addAll({'phone_2': backupPhone.trim()});
    result.addAll({'whatsapp': whatsapp.trim()});
    result.addAll({'show_whatsapp': isShowWhatsapp ? '1' : '0'});
    result.addAll({'description': description.trim()});
    result.addAll({'features': features.map((e) => e).toList()});
    result.addAll({'address': location.trim()});
    result.addAll({'featured': '0'});

    result.addAll({'receive_is_email': isReceivedEmail ? '1' : '0'});
    result.addAll({'receive_is_phone': isReceivedEmail ? '1' : '0'});

    result.addAll({'service_type_id': service_type_id.trim()});
    result.addAll({'experience': experience.trim()});
    result.addAll({'required_education': educations.trim()});
    result.addAll({'designation': designation.trim()});
    result.addAll({'salary_from': salary_from.trim()});
    result.addAll({'salary_to': salary_to.trim()});
    result.addAll({'deadline': deadline.trim()});
    result.addAll({'employer_name': employerName.trim()});
    result.addAll({'job_type': jobType.trim()});
    result.addAll({'website': website.trim()});
    result.addAll({'website': employerWebsite.trim()});
    result.addAll({'employer_logo': employerLogo.trim()});
    result.addAll({'condition': condition.trim()});
    result.addAll({'textbook_type': textbookType.trim()});
    result.addAll({'authenticity': authenticity.trim()});
    result.addAll({'ram': ram.trim()});
    result.addAll({'edition': edition.trim()});
    result.addAll({'model': model.trim()});
    result.addAll({'brand_id': brandId.trim()});
    result.addAll({'processor': processor.trim()});
    result.addAll({'vehicle_manufacture': year_of_manufacture.trim()});
    result.addAll({'vehicle_engine_capacity': engine_capacity.trim()});
    result.addAll({'vehicle_transmission': transmission.trim()});
    result.addAll({'registration_year': registration_year.trim()});
    result.addAll({'vehicle_body_type': body_type.trim()});
    result.addAll({'vehicle_fule_type': vehicleFuleType.map((e) => e).toList()});
    result.addAll({'property_type': property_type.trim()});
    result.addAll({'size': size.trim()});
    result.addAll({'size_type': size_type.trim()});
    result.addAll({'property_location': property_location.trim()});
    result.addAll({'property_price_type': price_type.trim()});
    result.addAll({'animal_type': animal_type.trim()});
    result.addAll({'status': status.trim()});
    result.addAll({'images': images.map((e) => e).toList()});
    result.addAll({'thumbnail': thumbnail.trim()});
    result.addAll({'delete_image': deleteImage.map((e) => e).toList()});
    // result.addAll({'state': state});
    return result;
  }

  factory NewEditAdModalState.fromMap(Map<String, dynamic> map) {
    return NewEditAdModalState(
      title: map['title'] ?? '',
      price: map['price'] ?? '',
      category: map['category_id'] ?? '',
      subCategory: map['subcategory_id'] ?? '',
      phone: map['phone'] ?? '',
      isShowPhone: map['show_phone'] ?? false,
      email: map['email'] ?? '',
      isShowEmail: map['show_email'] ?? false,
      backupPhone: map['phone_2'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      isShowWhatsapp: map['show_whatsapp'] ?? false,
      description: map['description'] ?? '',
      features: map['features[]'] ?? [],
      location: map['address'] ?? '',
      images: map['images[]'] ?? [],
      thumbnail: map['thumbnail'] ?? '',
      deleteImage: map['delete_image[]'] ?? [],
      service_type_id: map['ads_type'] ?? '',
      experience: map['experience'] ?? '',
      educations: map['required_education'] ?? '',
      designation: map['designation'] ?? '',
      salary_from: map['salary_from'] ?? '',
      salary_to: map['salary_to'] ?? '',
      deadline: map['deadline'] ?? '',
      employerName: map['employer_name'] ?? '',
      jobType: map['job_type'] ?? '',
      website: map['website'] ?? '',
      isReceivedEmail: map['receive_is_email'] ?? false,
      isReceivedPhone: map['receive_is_phone'] ?? false,
      employerWebsite: map['website'] ?? '',
      employerLogo: map['employer_logo'] ?? '',
      condition: map['condition'] ?? '',
      textbookType: map['textbook_type'] ?? '',
      authenticity: map['authenticity'] ?? '',
      ram: map['ram'] ?? '',
      edition: map['edition'] ?? '',
      model: map['model'] ?? '',
      brandId: map['brand_id'] ?? '',
      processor: map['processor'] ?? '',
      year_of_manufacture: map['year_of_manufacture'] ?? '',
      engine_capacity: map['engine_capacity'] ?? '',
      transmission: map['vehicle_transmission'] ?? '',
      registration_year: map['registration_year'] ?? '',
      body_type: map['body_type'] ?? '',
      vehicleFuleType: map['vehicle_fule_type'] ?? [],
      property_type: map['property_type'] ?? '',
      size: map['size'] ?? '',
      size_type: map['size_type'] ?? '',
      property_location: map['property_location'] ?? '',
      price_type: map['price_type'] ?? '',
      animal_type: map['animal_type'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewEditAdModalState.fromJson(String source) =>
      NewEditAdModalState.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewEditAdModalState(title: $title, price: $price, category_id: $category, subcategory_id: $subCategory, website: $website, website: $employerWebsite, phone: $phone, show_phone: $isShowPhone phone_2: $backupPhone, whatsapp: $whatsapp, description: $description, features[]: $features, address: $location, images[]: $images, thumbnail: $thumbnail, delete_image: $deleteImage, state: $state)';

  @override
  List<Object> get props => [
    title,
    price,
    category,
    subCategory,
    phone,
    isShowPhone,
    email,
    isShowEmail,
    backupPhone,
    whatsapp,
    isShowWhatsapp,
    website,
    description,
    features,
    location,
    images,
    isReceivedEmail,
    isReceivedPhone,
    thumbnail,
    deleteImage,
    service_type_id,
    experience,
    educations,
    designation,
    salary_from,
    salary_to,
    deadline,
    employerName,
    jobType,
    employerWebsite,
    employerLogo,
    condition,
    textbookType,
    authenticity,
    ram,
    edition,
    model,
    brandId,
    processor,
    year_of_manufacture,
    engine_capacity,
    transmission,
    registration_year,
    body_type,
    vehicleFuleType,
    property_type,
    size,
    size_type,
    property_location,
    price_type,
    animal_type,
    status,
    state
  ];
}

abstract class NewEditAdState extends Equatable {
  const NewEditAdState();

  @override
  List<Object> get props => [];
}

class NewEditAdStateInitial extends NewEditAdState {
  const NewEditAdStateInitial();
}

class NewEditAdStateLoading extends NewEditAdState {
  const NewEditAdStateLoading();
}

class NewEditAdStateError extends NewEditAdState {
  final String errorMsg;
  final int statusCode;

  const NewEditAdStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class NewEditAdStateLoaded extends NewEditAdState {
  final String message;
  final bool isBack;
  const NewEditAdStateLoaded(this.message,this.isBack);

  @override
  List<Object> get props => [message];
}
