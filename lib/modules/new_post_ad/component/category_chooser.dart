import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/utils/constants.dart';

import '../controller/new_posted_bloc.dart';

class NewAdPostCategoryChooser extends StatefulWidget {
  const NewAdPostCategoryChooser({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;

  @override
  State<NewAdPostCategoryChooser> createState() =>
      _NewAdPostCategoryChooserState();
}

class _NewAdPostCategoryChooserState extends State<NewAdPostCategoryChooser> {
  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Select a category",
              style: TextStyle(fontSize: 16),),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                var category = postAdBloc.categoryList[index];
                return BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                  buildWhen: (previous, current) => previous.category != current.category,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Material(
                          color: redColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          child: InkWell(
                            onTap: () {
                              postAdBloc.add(NewPostAdEventCategory(category.id.toString()));
                              // if (category.haseCustomField) {
                              // postAdBloc.customFieldDataModel = null;
                              // postAdBloc.add(NewPostAdEventGetCustomFieldData(category.slug));
                              // }
                              Future.delayed(const Duration(milliseconds: 200)).then((value2) {
                                widget.onPressed();
                              });
                            },
                            splashColor: redColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Text(
                                        category.name,
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    );
                  },
                );
              },
              childCount: postAdBloc.categoryList.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16,),
        )
      ],
    );
  }
}
