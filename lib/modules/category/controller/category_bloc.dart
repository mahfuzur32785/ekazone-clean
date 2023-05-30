import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/modules/home/model/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  CategoryBloc()
      : super(CategoryStateInitial()){
    on<CategorySelectBackAllCategory>(_backAllCategory);
    on<CategoryShowAllDataEvent>(_showAllData);
    on<CategorySelectEvent>(_selectCategory);
    on<CategoryDataEvent>(_categoryData);
    on<CategorySubCategorySelectEvent>( _selectSubCategory);
  }

  Category? category;
  Brand? subCategory;

  String categoryStr = '';
  String categorySlug = '';
  String subCategorySlug = '';

  String getCategoryName(context){
    if (categoryStr != '') {
      return categoryStr;
    }
    return "Select category";
  }

  String getCategorySlug(){
    if (categorySlug != '') {
      return categorySlug;
    }
    return "";
  }
  String getSubCategorySlug(){
    if (subCategorySlug != '') {
      return subCategorySlug;
    }
    return "";
  }

  void _backAllCategory(CategorySelectBackAllCategory event, Emitter<CategoryState> emit){
    subCategory = null;
    category = null;
    subCategorySlug = '';
    categorySlug = '';
    categoryStr = '';
    emit(CategoryStateInitial());
  }

  void _showAllData(CategoryShowAllDataEvent event, Emitter<CategoryState> emit){
    subCategory = null;
    category = null;
    subCategorySlug = '';
    categorySlug = '';
    categoryStr = '';
    emit(CategoryStateShowAll());
  }

  void _selectCategory(CategorySelectEvent event, Emitter<CategoryState> emit) async {
    category = event.category;
    categorySlug = event.category.slug;
    subCategory = null;
    subCategorySlug = '';
    categoryStr = event.category.name;
    emit(CategoryStateSelectCategory(event.category,false));
  }

  void _categoryData(CategoryDataEvent event, Emitter<CategoryState> emit) async {
    category = event.category;
    subCategory = null;
    categoryStr = event.category.name;
    subCategorySlug = '';
    emit(CategoryStateSelectCategory(event.category,true));
  }

  void _selectSubCategory(CategorySubCategorySelectEvent event, Emitter<CategoryState> emit) async {
    subCategory = event.subCategory;
    categoryStr = event.subCategory.name;
    subCategorySlug = event.subCategory.slug;
    emit(CategoryStateSelectSubCategory(event.subCategory));
  }

}