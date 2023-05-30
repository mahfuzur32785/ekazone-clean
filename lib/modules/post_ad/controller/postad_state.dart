part of 'postad_bloc.dart';

class PostAdModalState extends Equatable {
  final String name;
  final String price;
  final String category;
  final String subCategory;
  final String phone;
  final bool isShowPhone;
  final String backupPhone;
  final String weChat;
  final String description;
  final List<String> features;
  final String location;
  final List<String> images;
  final String brand;
  final PostAdState state;
  const PostAdModalState({
    this.name = '',
    this.price = '',
    this.category = '',
    this.subCategory = '',
    this.phone = '',
    this.isShowPhone = false,
    this.backupPhone = '',
    this.weChat = '',
    this.description = '',
    this.features = const [],
    this.location = '',
    this.images = const [],
    this.brand = '',
    this.state = const PostAdStateInitial(),
  });

  PostAdModalState copyWith({
    String? name,
    String? price,
    String? category,
    String? subCategory,
    String? phone,
    bool? isShowPhone,
    String? backupPhone,
    String? weChat,
    String? description,
    List<String>? features,
    String? location,
    List<String>? images,
    String? brand,
    PostAdState? state,
  }) {
    return PostAdModalState(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      phone: phone ?? this.phone,
      isShowPhone: isShowPhone ?? this.isShowPhone,
      backupPhone: backupPhone ?? this.backupPhone,
      weChat: weChat ?? this.weChat,
      description: description ?? this.description,
      features: features ?? this.features,
      location: location ?? this.location,
      images: images ?? this.images,
      brand: brand ?? this.brand,
      state: state ?? this.state,
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
    result.addAll({'phone_2': backupPhone.trim()});
    result.addAll({'whatsapp': weChat.trim()});
    result.addAll({'description': description.trim()});
    result.addAll({'features[]': features.map((e) => e).toList()});
    result.addAll({'address': location.trim()});
    result.addAll({'featured': '0'});
    result.addAll({'brand': ''});
    result.addAll({'images': images.map((e) => e).toList()});
    // result.addAll({'state': state});

    return result;
  }

  factory PostAdModalState.fromMap(Map<String, dynamic> map) {
    return PostAdModalState(
      name: map['title'] ?? '',
      price: map['price'] ?? '',
      category: map['category_id'] ?? '',
      subCategory: map['subcategory_id'] ?? '',
      phone: map['phone'] ?? '',
      isShowPhone: map['show_phone'] ?? false,
      backupPhone: map['phone_2'] ?? '',
      weChat: map['whatsapp'] ?? '',
      description: map['description'] ?? '',
      features: map['features[]'] ?? [],
      location: map['address'] ?? '',
      images: map['images[]'] ?? [],
      brand: map['brand'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostAdModalState.fromJson(String source) =>
      PostAdModalState.fromMap(json.decode(source));

  @override
  String toString() =>
      'PostAdModalState(title: $name, price: $price, category_id: $category, subcategory_id: $subCategory, phone: $phone, show_phone: $isShowPhone phone_2: $backupPhone, whatsapp: $weChat, description: $description, features[]: $features, address: $location, images[]: $images, brand: $brand, state: $state)';

  @override
  List<Object> get props => [name, price, category, subCategory, phone, isShowPhone, backupPhone, weChat, description, features, location, brand, images, state];
}

abstract class PostAdState extends Equatable {
  const PostAdState();

  @override
  List<Object> get props => [];
}

class PostAdStateInitial extends PostAdState {
  const PostAdStateInitial();
}

class PostAdStateLoading extends PostAdState {
  const PostAdStateLoading();
}

class PostAdStateError extends PostAdState {
  final String errorMsg;
  final int statusCode;

  const PostAdStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}
class PostAdStateLoaded extends PostAdState {
  final String message;
  const PostAdStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}