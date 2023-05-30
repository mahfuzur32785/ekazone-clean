part of 'new_posted_bloc.dart';

abstract class NewPostAdEvent extends Equatable {
  const NewPostAdEvent();

  @override
  List<Object> get props => [];
}



class NewPostAdEventEmpty extends NewPostAdEvent {
  const NewPostAdEventEmpty();

  @override
  List<Object> get props => [];
}
class NewPostAdEventName extends NewPostAdEvent {
  final String name;
  const NewPostAdEventName(this.name);

  @override
  List<Object> get props => [name];
}

class NewPostAdEventPrice extends NewPostAdEvent {
  final String price;
  const NewPostAdEventPrice(this.price);

  @override
  List<Object> get props => [price];
}

class NewPostAdEventCategory extends NewPostAdEvent {
  final String category;
  const NewPostAdEventCategory(this.category);

  @override
  List<Object> get props => [category];
}

class NewPostAdEventSubCategory extends NewPostAdEvent {
  final String subCategory;
  final Brand subCategoryData;
  const NewPostAdEventSubCategory(this.subCategory,this.subCategoryData);

  @override
  List<Object> get props => [subCategory];
}

class NewPostAdEventPhone extends NewPostAdEvent {
  final String phone;
  const NewPostAdEventPhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class NewPostAdEventShowPhone extends NewPostAdEvent {
  final bool isShowPhone;
  const NewPostAdEventShowPhone(this.isShowPhone);

  @override
  List<Object> get props => [isShowPhone];
}

class NewPostAdEventEmail extends NewPostAdEvent {
  final String email;
  const NewPostAdEventEmail(this.email);

  @override
  List<Object> get props => [email];
}
class NewPostAdEventEmployerEmail extends NewPostAdEvent {
  final String email;
  const NewPostAdEventEmployerEmail(this.email);

  @override
  List<Object> get props => [email];
}
class NewPostAdEventEmployerPhone extends NewPostAdEvent {
  final String phone;
  const NewPostAdEventEmployerPhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class NewPostAdEventShowEmail extends NewPostAdEvent {
  final bool isShowEmail;
  const NewPostAdEventShowEmail(this.isShowEmail);

  @override
  List<Object> get props => [isShowEmail];
}
class NewPostAdEventApplicationReceivedInEmail extends NewPostAdEvent {
  final bool value1;
  const NewPostAdEventApplicationReceivedInEmail(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventApplicationReceivedInPhone extends NewPostAdEvent {
  final bool value1;
  const NewPostAdEventApplicationReceivedInPhone(this.value1);

  @override
  List<Object> get props => [value1];
}

class NewPostAdEventWhatsapp extends NewPostAdEvent {
  final String whatsapp;
  const NewPostAdEventWhatsapp(this.whatsapp);

  @override
  List<Object> get props => [whatsapp];
}

class NewPostAdEventShowWhatsapp extends NewPostAdEvent {
  final bool isShowWhatsapp;
  const NewPostAdEventShowWhatsapp(this.isShowWhatsapp);

  @override
  List<Object> get props => [isShowWhatsapp];
}

class NewPostAdEventBackupPhone extends NewPostAdEvent {
  final String backupPhone;
  const NewPostAdEventBackupPhone(this.backupPhone);

  @override
  List<Object> get props => [backupPhone];
}

class NewPostAdEventWebsite extends NewPostAdEvent {
  final String website;
  const NewPostAdEventWebsite(this.website);

  @override
  List<Object> get props => [website];
}

class NewPostAdEventDescription extends NewPostAdEvent {
  final String description;
  const NewPostAdEventDescription(this.description);

  @override
  List<Object> get props => [description];
}

class NewPostAdEventFeature extends NewPostAdEvent {
  final List<String> features;
  const NewPostAdEventFeature(this.features);

  @override
  List<Object> get props => [features];
}

class NewPostAdEventLocation extends NewPostAdEvent {
  final String location;
  const NewPostAdEventLocation(this.location);

  @override
  List<Object> get props => [location];
}
class NewPostAdEventLatLng extends NewPostAdEvent {
  final String lat;
  final String long;
  const NewPostAdEventLatLng(this.lat,this.long);

  @override
  List<Object> get props => [lat,long];
}

class NewPostAdEventImages extends NewPostAdEvent {
  final List<String> images;
  const NewPostAdEventImages(this.images);

  @override
  List<Object> get props => [images];
}

class NewPostAdEventFeatureImage extends NewPostAdEvent {
  final String thumbnail;
  const NewPostAdEventFeatureImage(this.thumbnail);

  @override
  List<Object> get props => [thumbnail];
}

class NewPostAdEventBrand extends NewPostAdEvent {
  final String brand;
  final BrandModel brandModel;
  const NewPostAdEventBrand(this.brand, this.brandModel);

  @override
  List<Object> get props => [brand];
}

// class NewPostAdEventSubCategory extends NewPostAdEvent {
//   final String subCategory;
//   final Brand subCategoryData;
//   const NewPostAdEventSubCategory(this.subCategory,this.subCategoryData);
//
//   @override
//   List<Object> get props => [subCategory];
// }

//////////////////
class NewPostAdEventServiceTypeId extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventServiceTypeId(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventExperience extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventExperience(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEducations extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEducations(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventDesignationId extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventDesignationId(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventSalaryFrom extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventSalaryFrom(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventSalaryTo extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventSalaryTo(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventDeadline extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventDeadline(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEmployerName extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEmployerName(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEmployerDesignation extends NewPostAdEvent {
  final String designation;
  const NewPostAdEventEmployerDesignation(this.designation);

  @override
  List<Object> get props => [designation];
}
class NewPostAdEventEmploymentType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEmploymentType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventJobType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventJobType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEmployerWebsite extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEmployerWebsite(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEmployeeLogo extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEmployeeLogo(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventCondition extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventCondition(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventAuthenticity extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventAuthenticity(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventTextBookType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventTextBookType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventRam extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventRam(this.value1);

  @override
  List<Object> get props => [value1];
}

class NewPostAdEventProductModel extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventProductModel(this.value1);

  @override
  List<Object> get props => [value1];
}

class NewPostAdEventProductBrandId extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventProductBrandId(this.value1);

  @override
  List<Object> get props => [value1];
}

class NewPostAdEventProductAdsType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventProductAdsType(this.value1);

  @override
  List<Object> get props => [value1];
}

class NewPostAdEventProcessor extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventProcessor(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEdition extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEdition(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventYearOfManufacture extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventYearOfManufacture(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventEngineCapacity extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventEngineCapacity(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventTransmission extends NewPostAdEvent {
  final String transmission;
  const NewPostAdEventTransmission(this.transmission);

  @override
  List<Object> get props => [transmission];
}
class NewPostAdEventRegistrationYear extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventRegistrationYear(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventBodyType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventBodyType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventFuelType extends NewPostAdEvent {
  final List<String> value1;
  const NewPostAdEventFuelType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventPropertyType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventPropertyType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventBedroom extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventBedroom(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventSize extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventSize(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventSizeType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventSizeType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventPropertyLocation extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventPropertyLocation(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventPriceType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventPriceType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewPostAdEventAnimalType extends NewPostAdEvent {
  final String value1;
  const NewPostAdEventAnimalType(this.value1);

  @override
  List<Object> get props => [value1];
}
//////////////////

class NewPostAdEventCustomFieldDataMap extends NewPostAdEvent {
  final Map data;
  const NewPostAdEventCustomFieldDataMap(this.data);

  @override
  List<Object> get props => [data];
}

class NewPostAdEventGetCustomFieldData extends NewPostAdEvent {
  final String slug;
  const NewPostAdEventGetCustomFieldData(this.slug);

  @override
  List<Object> get props => [slug];
}

class NewPostAdEventSubmit extends NewPostAdEvent {
  final String token;
  const NewPostAdEventSubmit(this.token);
  @override
  List<Object> get props => [token];
}