import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  final String title, subTitle, image, paragraph;

  const OnBoardingModel({
    required this.paragraph,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  List<Object> get props => [image, title, subTitle, paragraph];
}
