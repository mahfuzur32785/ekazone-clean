import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../core/router_name.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../controllers/forgot_password/forgot_password_cubit.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPasswordCubit>();
    final size = MediaQuery.of(context).size;
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordStateError) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is ForgotPasswordStateLoaded) {
          Utils.showSnackBar(context, state.message);
          if(state.message == 'Email address not found'){
            return;
          }
          bloc.emailController.text = '';
          Navigator.pushReplacementNamed(context, RouteNames.setPasswordScreen);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FD),
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xffFFEFE7)],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(child: _buildForm(bloc,context)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(ForgotPasswordCubit bloc,BuildContext context) {
    return Form(
      key: bloc.formKey1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(1, 1)),
            ],
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            /*CircleAvatar(
              radius: 96,
              backgroundColor: redColor.withOpacity(0.1),
              child: const CustomImage(path: Kimages.forgotIcon),
            ),*/
            const SizedBox(height: 55),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Forgot password',
                style: GoogleFonts.poppins(
                    height: 1, fontSize: 20, fontWeight: FontWeight.bold)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Please enter the email address you\'d like your password reset informationsent to',
                  style: GoogleFonts.poppins(
                      height: 1, fontSize: 16, color: Colors.black54),textAlign: TextAlign.center,
                ),
              ),
            ),
            Divider(color: Colors.grey.shade300,),
            const SizedBox(height: 22),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("*",style: TextStyle(color: Colors.red),),
                ],
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: bloc.emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter email';
                } else if (!Utils.isEmail(value.trim())) {
                  return "Enter valid email";
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
            const SizedBox(height: 28),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
              if (state is ForgotPasswordStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    bloc.forgotPassWord();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor:
                      const Color(0xFF212d6e)),
                  child: const Text("Request Reset Link"),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
