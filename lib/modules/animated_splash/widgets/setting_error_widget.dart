import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../controller/app_setting_cubit.dart';

class SettingErrorWidget extends StatelessWidget {
  const SettingErrorWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: redColor, fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              context.read<AppSettingCubit>().loadWebSetting();
            },
            child: const Icon(
              Icons.refresh_outlined,
              color: blackColor,
            ),
          )
        ],
      ),
    );
  }
}
