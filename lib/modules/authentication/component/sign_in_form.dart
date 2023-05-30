import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../controllers/login/login_bloc.dart';

// ignore: must_be_immutable
class SignInForm extends StatefulWidget {
  SignInForm({Key? key, required this.pageController}) : super(key: key);
  PageController pageController = PageController();

  @override
  State<SignInForm> createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
  bool _checkBoxSelect = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // const SliverPadding(
          //   padding: EdgeInsets.symmetric(vertical: 30,),
          //   sliver: SliverToBoxAdapter(
          //     child: CustomImage(
          //       // path: RemoteUrls.imageUrl(appSetting.settingModel!.logo),
          //       path: Kimages.logoColor,
          //       width: 280,
          //       height: 110,
          //     ),
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: loginBloc.formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(5),
                  //     border: Border.all(color: Colors.grey.shade300),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.grey.withOpacity(0.1),
                  //           blurRadius: 6,
                  //           offset: const Offset(1, 1))
                  //     ]),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.topLeft,
                        duration: kDuration,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black54),),
                          GestureDetector(
                            onTap: () {
                              widget.pageController.animateToPage(1,
                                  duration: kDuration, curve: Curves.bounceInOut);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Color(0xFF212D6E),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: false,
                            child: InkWell(
                              onTap: () {
                                context.read<LoginBloc>().add(LoginWithFacebookEventSubmit(context));
                              },
                              child: const Image(
                                image: AssetImage("assets/login/facebook.png"),
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              context.read<LoginBloc>().add(LoginWithGoogleEventSubmit(context));
                            },
                            child: const Image(
                              image: AssetImage("assets/login/google.png"),
                              height: 40,
                              width: 40,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      ),

                      BlocBuilder<LoginBloc, LoginModelState>(
                        buildWhen: (previous, current) =>
                            previous.email != current.email,
                        builder: (context, state) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            initialValue: state.email,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                            onChanged: (value) => loginBloc.add(LoginEventUserName(value)),

                            decoration: const InputDecoration(
                              hintText: "Enter your email",
                              fillColor: Color(0xffEBEDF4),
                              filled: true
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Text("Password",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      ),

                      BlocBuilder<LoginBloc, LoginModelState>(
                        buildWhen: (previous, current) =>
                            previous.password != current.password,
                        builder: (context, state) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            initialValue: state.password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              } else if (value.length < 8) {
                                return 'Enter Minimum 8 Character';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                loginBloc.add(LoginEventPassword(value)),
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              hintText:
                                  'Enter your password',
                              fillColor: const Color(0xffEBEDF4),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: grayColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildRememberMe(),
                      const SizedBox(height: 25),
                      BlocBuilder<LoginBloc, LoginModelState>(
                        buildWhen: (previous, current) =>
                            previous.state != current.state,
                        builder: (context, state) {
                          if (state.state is LoginStateLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Utils.closeKeyBoard(context);
                                loginBloc.add(const LoginEventSubmit());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  backgroundColor:
                                  const Color(0xFF212d6e)),
                              child: const Text("Log In"),
                            ),
                          );
                        },
                      ),
                      // const SocialButtons()
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: [
        Flexible(
          child: CheckboxListTile(
            value: _checkBoxSelect,
            dense: true,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            activeColor: redColor,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Remember me',
              style: TextStyle(color: blackColor.withOpacity(.5)),
            ),
            onChanged: (bool? v) {
              if (v == null) return;
              setState(() {
                _checkBoxSelect = v;
              });
            },
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.forgotScreen);
          },
          child: const Text(
            'Forgot password',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
