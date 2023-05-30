import 'package:flutter/material.dart';
import 'package:ekayzone/widgets/custom_image.dart';

import '../model/blog_model.dart';
class BlogMaterialCard extends StatelessWidget {
  BlogMaterialCard({Key? key,required this.blogModel,required this.index}) : super(key: key);
  final BlogModel blogModel;
  final int? index;

  final Shader linearGradient = const LinearGradient(
    // colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
    colors: <Color>[Color(0xffff0080), Color(0xff8928ca)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black12,
      // margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(0),
            height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.65 : MediaQuery.of(context).size.height * 1,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: CustomImage(path: blogModel.image,fit: BoxFit.cover,),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Text(blogModel.category,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                // foreground: Paint()..shader = linearGradient,
              color: Colors.black54
            ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Text(blogModel.title,textAlign: TextAlign.start,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Text(blogModel.publishDate,textAlign: TextAlign.start,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Text(blogModel.summery,textAlign: TextAlign.start,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton(
                onPressed: (){

                },
                style: OutlinedButton.styleFrom(side: const BorderSide(width: 1.0, color: Color(0xff8928ca)),),
                child: Text('READ MORE',style: TextStyle(foreground: Paint()..shader = linearGradient,fontSize: 14),),
              ),
            ),
          ),
          const SizedBox(height: 12,)
        ],
      ),
    );
  }
}