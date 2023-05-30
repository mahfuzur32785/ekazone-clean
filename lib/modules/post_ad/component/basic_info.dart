import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/home/model/category_model.dart';
import 'package:ekayzone/modules/post_ad/controller/postad_bloc.dart';

class BasicInfoView extends StatefulWidget {
  const BasicInfoView({Key? key}) : super(key: key);

  @override
  State<BasicInfoView> createState() => _BasicInfoViewState();
}

class _BasicInfoViewState extends State<BasicInfoView> {

  bool isFeature = false;

  Brand? subCategory;

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<PostAdBloc>();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: postAdBloc.basicFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ad Name*"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.name != current.name,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.name,
                        // initialValue: state.name,
                        controller: postAdBloc.nameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(PostAdEventName(value)),
                        decoration: const InputDecoration(hintText: "Ad Name"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Price*(VT)"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.price != current.price,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.number,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                        // initialValue: state.price,
                        controller: postAdBloc.priceController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Price';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(PostAdEventPrice(value)),
                        decoration: const InputDecoration(hintText: "Price"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Category*"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                      buildWhen: (previous, current) => previous.category != current.category,
                      builder: (context, state) {
                      return DropdownButtonFormField<Category>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          hintText: "Category",
                        ),
                        items: postAdBloc.categoryList.map<DropdownMenuItem<Category>>((e) {
                          return DropdownMenuItem<Category>(
                            value: e,
                            child: Text(e.name),
                          );
                      }).toList(),
                        validator: (value){
                          if (value == null) {
                            return "Select Category";
                          }
                        },
                        onChanged: (Category? value) {
                          // setState(() {
                          //   subCategory = null;
                          //   postAdBloc.subCategoryList = [];
                          // });
                          Future.delayed(const Duration(milliseconds: 300)).then((value2) {
                            postAdBloc.add(PostAdEventCategory(value!.id.toString()));
                          });
                        },
                      );
                    }
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Sub Category*"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                      buildWhen: (previous, current) => previous.subCategory != current.subCategory,
                      builder: (context, state) {
                      return DropdownButtonFormField<Brand>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          hintText: "Sub Category",
                        ),
                        value: postAdBloc.subCategory,
                        items: postAdBloc.subCategoryList.map<DropdownMenuItem<Brand>>((e) {
                          return DropdownMenuItem<Brand>(
                            value: e,
                            child: Text(e.name),
                          );
                        }).toList(),
                        validator: (value){
                          if (postAdBloc.subCategoryList.isNotEmpty && value == null) {
                            return "Select Sub Category";
                          }
                          return null;
                        },
                        onChanged: (Brand? value) {
                          setState(() {
                            subCategory = null;
                          });
                          postAdBloc.add(PostAdEventSubCategory(value!.id.toString(),value));
                        },
                      );
                    }
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Row(
                    children: [
                      const Text("Phone("),
                      BlocBuilder<PostAdBloc, PostAdModalState>(
                          buildWhen: (previous, current) => previous.isShowPhone != current.isShowPhone,
                          builder: (context, state) {
                          return SizedBox(
                            width: 30,
                            height: 24,
                            child: Checkbox(
                                value: state.isShowPhone,
                                onChanged: (value){
                                  postAdBloc.add(PostAdEventShowPhone(value!));
                            }),
                          );
                        }
                      ),
                      const Text("Show in ads details)")
                    ],
                  ),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.phone != current.phone,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // initialValue: state.phone,
                        controller: postAdBloc.phoneController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Phone Number';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(PostAdEventPhone(value)),
                        decoration: const InputDecoration(hintText: "Phone"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Backup Phone Number"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.backupPhone != current.backupPhone,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // initialValue: state.backupPhone,
                        controller: postAdBloc.backupPhoneController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            // return 'Enter Backup Number';
                            return null;
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(PostAdEventBackupPhone(value)),
                        decoration: const InputDecoration(hintText: "Phone Number"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("WeChat"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.weChat != current.weChat,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // initialValue: state.weChat,
                        controller: postAdBloc.weChatController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                            // return 'Enter Your WeChat Number';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(PostAdEventWeChat(value)),
                        decoration: const InputDecoration(hintText: "E.G 1687*****"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Row(
                  //   children: [
                  //     Checkbox(value: isFeature, onChanged: (value){
                  //       setState(() {
                  //         isFeature = value!;
                  //       });
                  //     }),
                  //     const Text("Featured")
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
