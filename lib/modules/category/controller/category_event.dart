part of 'category_bloc.dart';
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategorySelectBackAllCategory extends CategoryEvent {
  const CategorySelectBackAllCategory();

  @override
  List<Object> get props => [];
}

class CategoryShowAllDataEvent extends CategoryEvent {
  const CategoryShowAllDataEvent();

  @override
  List<Object> get props => [];
}

class CategorySelectEvent extends CategoryEvent {
  final Category category;
  final bool isRequiredLoading;

  const CategorySelectEvent(this.category,this.isRequiredLoading);

  @override
  List<Object> get props => [category,isRequiredLoading];
}

class CategoryDataEvent extends CategoryEvent {
  final Category category;

  const CategoryDataEvent(this.category);

  @override
  List<Object> get props => [category,true];
}

class CategorySubCategorySelectEvent extends CategoryEvent {
  final Brand subCategory;

  const CategorySubCategorySelectEvent(this.subCategory);

  @override
  List<Object> get props => [subCategory];
}