part of 'postad_bloc.dart';

abstract class PostAdEvent extends Equatable {
  const PostAdEvent();

  @override
  List<Object> get props => [];
}

class PostAdEventName extends PostAdEvent {
  final String name;
  const PostAdEventName(this.name);

  @override
  List<Object> get props => [name];
}

class PostAdEventPrice extends PostAdEvent {
  final String price;
  const PostAdEventPrice(this.price);

  @override
  List<Object> get props => [price];
}

class PostAdEventCategory extends PostAdEvent {
  final String category;
  const PostAdEventCategory(this.category);

  @override
  List<Object> get props => [category];
}

class PostAdEventSubCategory extends PostAdEvent {
  final String subCategory;
  final Brand subCategoryData;
  const PostAdEventSubCategory(this.subCategory,this.subCategoryData);

  @override
  List<Object> get props => [subCategory];
}

class PostAdEventPhone extends PostAdEvent {
  final String phone;
  const PostAdEventPhone(this.phone);

  @override
  List<Object> get props => [phone];
}
class PostAdEventShowPhone extends PostAdEvent {
  final bool isShowPhone;
  const PostAdEventShowPhone(this.isShowPhone);

  @override
  List<Object> get props => [isShowPhone];
}

class PostAdEventBackupPhone extends PostAdEvent {
  final String backupPhone;
  const PostAdEventBackupPhone(this.backupPhone);

  @override
  List<Object> get props => [backupPhone];
}

class PostAdEventWeChat extends PostAdEvent {
  final String weChat;
  const PostAdEventWeChat(this.weChat);

  @override
  List<Object> get props => [weChat];
}

class PostAdEventDescription extends PostAdEvent {
  final String description;
  const PostAdEventDescription(this.description);

  @override
  List<Object> get props => [description];
}

class PostAdEventFeature extends PostAdEvent {
  final List<String> features;
  const PostAdEventFeature(this.features);

  @override
  List<Object> get props => [features];
}

class PostAdEventLocation extends PostAdEvent {
  final String location;
  const PostAdEventLocation(this.location);

  @override
  List<Object> get props => [location];
}

class PostAdEventImages extends PostAdEvent {
  final List<String> images;
  const PostAdEventImages(this.images);

  @override
  List<Object> get props => [images];
}

class PostAdEventBrand extends PostAdEvent {
  final String brand;
  const PostAdEventBrand(this.brand);

  @override
  List<Object> get props => [brand];
}

class PostAdEventSubmit extends PostAdEvent {
  final String token;
  const PostAdEventSubmit(this.token);
  @override
  List<Object> get props => [token];
}