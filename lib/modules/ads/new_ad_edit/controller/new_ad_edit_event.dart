part of 'new_ad_edit_bloc.dart';

abstract class NewEditAdEvent extends Equatable {
  const NewEditAdEvent();

  @override
  List<Object> get props => [];
}

class NewEditAdEventLoadOldData extends NewEditAdEvent {
  final AdDetails adModel;
  const NewEditAdEventLoadOldData(this.adModel);

  @override
  List<Object> get props => [adModel];
}

class NewEditAdEventEmpty extends NewEditAdEvent {
  const NewEditAdEventEmpty();

  @override
  List<Object> get props => [];
}
class NewEditAdEventName extends NewEditAdEvent {
  final String name;
  const NewEditAdEventName(this.name);

  @override
  List<Object> get props => [name];
}

class NewEditAdEventPrice extends NewEditAdEvent {
  final String price;
  const NewEditAdEventPrice(this.price);

  @override
  List<Object> get props => [price];
}

class NewEditAdEventCategory extends NewEditAdEvent {
  final String category;
  const NewEditAdEventCategory(this.category);

  @override
  List<Object> get props => [category];
}

class NewEditAdEventSubCategory extends NewEditAdEvent {
  final String subCategory;
  final Brand subCategoryData;
  const NewEditAdEventSubCategory(this.subCategory,this.subCategoryData);

  @override
  List<Object> get props => [subCategory];
}

class NewEditAdEventPhone extends NewEditAdEvent {
  final String phone;
  const NewEditAdEventPhone(this.phone);

  @override
  List<Object> get props => [phone];
}
class NewEditAdEventShowPhone extends NewEditAdEvent {
  final bool isShowPhone;
  const NewEditAdEventShowPhone(this.isShowPhone);

  @override
  List<Object> get props => [isShowPhone];
}

class NewEditAdEventEmail extends NewEditAdEvent {
  final String email;
  const NewEditAdEventEmail(this.email);

  @override
  List<Object> get props => [email];
}
class NewEditAdEventShowEmail extends NewEditAdEvent {
  final bool isShowEmail;
  const NewEditAdEventShowEmail(this.isShowEmail);

  @override
  List<Object> get props => [isShowEmail];
}

class NewEditAdEventWebsiteValue extends NewEditAdEvent {
  final String websiteString;
  const NewEditAdEventWebsiteValue(this.websiteString);

  @override
  List<Object> get props => [websiteString];
}

class NewEditAdEventBackupPhone extends NewEditAdEvent {
  final String backupPhone;
  const NewEditAdEventBackupPhone(this.backupPhone);

  @override
  List<Object> get props => [backupPhone];
}

class NewEditAdEventWhatsapp extends NewEditAdEvent {
  final String whatsapp;
  const NewEditAdEventWhatsapp(this.whatsapp);

  @override
  List<Object> get props => [whatsapp];
}

class NewEditAdEventReceivedEmail extends NewEditAdEvent {
  final bool isReceivedEmail;
  const NewEditAdEventReceivedEmail(this.isReceivedEmail);

  @override
  List<Object> get props => [isReceivedEmail];
}
class NewEditAdEventReceivedPhone extends NewEditAdEvent {
  final bool isReceivedPhone;
  const NewEditAdEventReceivedPhone(this.isReceivedPhone);

  @override
  List<Object> get props => [isReceivedPhone];
}

class NewEditAdEventShowWhatsapp extends NewEditAdEvent {
  final bool isShowWhatsapp;
  const NewEditAdEventShowWhatsapp(this.isShowWhatsapp);

  @override
  List<Object> get props => [isShowWhatsapp];
}

class NewEditAdEventDescription extends NewEditAdEvent {
  final String description;
  const NewEditAdEventDescription(this.description);

  @override
  List<Object> get props => [description];
}

class NewEditAdEventFeature extends NewEditAdEvent {
  final List<String> features;
  const NewEditAdEventFeature(this.features);

  @override
  List<Object> get props => [features];
}

class NewEditAdEventLocation extends NewEditAdEvent {
  final String location;
  const NewEditAdEventLocation(this.location);

  @override
  List<Object> get props => [location];
}

class NewEditAdEventImages extends NewEditAdEvent {
  final List<String> images;
  const NewEditAdEventImages(this.images);

  @override
  List<Object> get props => [images];
}

class NewEditAdEventFeatureImage extends NewEditAdEvent {
  final String thumbnail;
  const NewEditAdEventFeatureImage(this.thumbnail);

  @override
  List<Object> get props => [thumbnail];
}

class NewEditAdEventDeleteImage extends NewEditAdEvent {
  final List<String> imageIds;
  const NewEditAdEventDeleteImage(this.imageIds);

  @override
  List<Object> get props => [imageIds];
}

//////////////////
class NewEditAdEventServiceTypeId extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventServiceTypeId(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventExperience extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventExperience(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEducations extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEducations(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventDesignation extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventDesignation(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventSalaryFrom extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventSalaryFrom(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventSalaryTo extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventSalaryTo(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventDeadline extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventDeadline(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEmployerName extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEmployerName(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEmploymentType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEmploymentType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventStatusType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventStatusType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEmployerWebsite extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEmployerWebsite(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEmployeeLogo extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEmployeeLogo(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventCondition extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventCondition(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventTextBookType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventTextBookType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventAuthenticity extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventAuthenticity(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventRam extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventRam(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEdition extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEdition(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventProductModel extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventProductModel(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventProductBrandId extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventProductBrandId(this.value1,);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventProcessor extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventProcessor(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventTrimEdition extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventTrimEdition(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventYearOfManufacture extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventYearOfManufacture(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventEngineCapacity extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventEngineCapacity(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventTransmission extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventTransmission(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventRegistrationYear extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventRegistrationYear(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventBodyType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventBodyType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventFuelType extends NewEditAdEvent {
  final List<String> value1;
  const NewEditAdEventFuelType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventPropertyType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventPropertyType(this.value1);

  @override
  List<Object> get props => [value1];
}
// class NewEditAdEventBedroom extends NewEditAdEvent {
//   final String value1;
//   const NewEditAdEventBedroom(this.value1);
//
//   @override
//   List<Object> get props => [value1];
// }
class NewEditAdEventSize extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventSize(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventSizeType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventSizeType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventPropertyLocation extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventPropertyLocation(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventPriceType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventPriceType(this.value1);

  @override
  List<Object> get props => [value1];
}
class NewEditAdEventAnimalType extends NewEditAdEvent {
  final String value1;
  const NewEditAdEventAnimalType(this.value1);

  @override
  List<Object> get props => [value1];
}
//////////////////

// class NewEditAdEventCustomFieldDataMap extends NewEditAdEvent {
//   final Map data;
//   const NewEditAdEventCustomFieldDataMap(this.data);
//
//   @override
//   List<Object> get props => [data];
// }

class NewEditAdEventGetCustomFieldData extends NewEditAdEvent {
  final String slug;
  const NewEditAdEventGetCustomFieldData(this.slug);

  @override
  List<Object> get props => [slug];
}

class NewEditAdEventSubmit extends NewEditAdEvent {
  final String token;
  final int id;
  const NewEditAdEventSubmit(this.token,this.id);
  @override
  List<Object> get props => [token,id];
}