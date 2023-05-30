part of 'category_bloc.dart';
abstract class CategoryState extends Equatable {

  @override
  List<Object> get props => [];
}

class CategoryStateInitial extends CategoryState {}

class CategoryStateShowAll extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryStateSelectCategory extends CategoryState {
  final Category category;
  final bool isRequiredLoading;
  CategoryStateSelectCategory(this.category, this.isRequiredLoading);
  @override
  List<Object> get props => [category,isRequiredLoading];
}

class CategoryStateSelectSubCategory extends CategoryState {
  final Brand subCategory;
  CategoryStateSelectSubCategory(this.subCategory);
  @override
  List<Object> get props => [subCategory];
}