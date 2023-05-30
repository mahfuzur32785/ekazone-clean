import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ekayzone/modules/setting/model/country_model.dart';
import 'package:ekayzone/modules/setting/model/user_with_country_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:ekayzone/utils/utils.dart';

import '../../../../core/error/failure.dart';
import '../../../profile/repository/profile_repository.dart';
import '../../models/facebook_login_model.dart';
import '../../models/user_login_response_model.dart';
import '../../repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginModelState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final formKey = GlobalKey<FormState>();

  final List<CountryModel> countries = [];

  UserLoginResponseModel? _user;

  bool get isLoggedIn => _user != null && _user!.accessToken.isNotEmpty;

  UserLoginResponseModel? get userInfo => _user;
  set user(UserLoginResponseModel userData) => _user = userData;

  LoginBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(const LoginModelState()) {
    on<LoginEventUserName>((event, emit) {
      emit(state.copyWith(email: event.name));
    });
    on<LoginEventPassword>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginEventSubmit>(_submitLoginForm);
    on<LoginWithGoogleEventSubmit>(_getGoogleLoginInfo);
    on<LoginWithFacebookEventSubmit>(_getFacebookLoginInfo);
    on<LoginEventLogout>(_logOut);
    on<LoginEventCheckProfile>(_getUserInfo);
    on<UpdateProfileEvent>(_updateProfile);

    /// set user data if usre already login

    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
      },
    );
  }
  Future<void> _getUserInfo(
    LoginEventCheckProfile event,
    Emitter<LoginModelState> emit,
  ) async {
    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
        emit(state.copyWith(state: LoginStateLoaded(r)));
      },
    );

    ///load user info if user longed in and update user on bloc state
    if (isLoggedIn) {
      final updateProfile = await _profileRepository.userProfile(userInfo!.accessToken);

      updateProfile.fold(
        (failure) {
          if (failure.statusCode == 401) {
            final currentState = LoginStateLogOut(
                'Session expired, Signin again', failure.statusCode);
            emit(state.copyWith(state: currentState));
          } else {
            final currentState =
                LoginStateError(failure.message, failure.statusCode);
            emit(state.copyWith(state: currentState));
          }
        },
        (UserWithCountryResponse userCountry) {
          user = (_user?.copyWith(user: userCountry.user))!;
          countries.clear();
          countries.addAll(userCountry.countries);
          emit(state.copyWith(state: LoginStateUpdatedProfile(userInfo!)));
        },
      );
    } else {
      _user = null;
      const currentState = LoginStateInitial();
      emit(state.copyWith(state: currentState));
    }
  }

  Future<void> _submitLoginForm(
    LoginEventSubmit event,
    Emitter<LoginModelState> emit,
  ) async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(state: const LoginStateLoading()));
    final bodyData = state.toMap();

    final result = await _authRepository.login(bodyData);

    result.fold(
      (Failure failure) {
        final error = LoginStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (user) {
        print("uuuuuuuuuuuuuuuuu $user uuuuuuuuuuuuuuuuuu");
        final loadedData = LoginStateLoaded(user);
        _user = user;
        emit(state.copyWith(state: loadedData));

        emit(state.copyWith(
          email: '',
          password: '',
          state: const LoginStateInitial(),
        ));
      },
    );
  }
  Future<void> _logOut(
    LoginEventLogout event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLogOutLoading()));

    final result = await _authRepository.logOut(userInfo!.accessToken);

    result.fold(
      (Failure failure) {
        if (failure.statusCode == 500) {
          const loadedData = LoginStateLogOut('logout success', 200);
          emit(state.copyWith(state: loadedData));
        } else {
          final error =
              LoginStateSignOutError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (String success) {
        _user = null;
        final loadedData = LoginStateLogOut(success, 200);
        emit(state.copyWith(state: loadedData));
      },
    );
  }

  Future<void> _updateProfile(
      UpdateProfileEvent event,
      Emitter<LoginModelState> emit,
      ) async {
    final loadedData = LoginStateLoaded(event.user);
    _user = event.user;
    emit(state.copyWith(state: loadedData));
  }

  //..................... Social Login ......................

  ///....... Google Login .......
  void _getGoogleLoginInfo(
      LoginWithGoogleEventSubmit event,
      Emitter<LoginModelState> emit,
      ) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      signInOption: SignInOption.standard,
      scopes: [
        'email',
        // you can add extras if you require
      ],
    );

    await googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
      GoogleSignInAuthentication auth = await acc!.authentication;
      if (kDebugMode) {
        print(acc.id);
        print(acc.email);
        print(acc.displayName);
        print(acc.photoUrl);
      }
      if(kReleaseMode){
        print(acc.id);
        print(acc.email);
        print(acc.displayName);
        print(acc.photoUrl);
      }
      // Utils.showSnackBar(event.context, "${acc.email}\n${acc.displayName}");

      if (auth.accessToken != null) {
        final body = <String, dynamic>{};

        body.addAll({'id': acc.id});
        body.addAll({'name': acc.displayName});
        body.addAll({'username': acc.displayName});
        body.addAll({'email': acc.email});
        body.addAll({'token': auth.accessToken});
        body.addAll({'provider': 'google'});

        print(auth.accessToken);

        emit(state.copyWith(state: const LoginStateGoogleLoading()));

        Utils.loadingDialog(event.context);

        final result = await _authRepository.socialLogin(body);

        print(result);

        result.fold(
              (Failure failure) {
                Utils.closeDialog(event.context);
            final error = LoginStateError(failure.message, failure.statusCode);
            emit(state.copyWith(state: error));
          },
              (user) {
                print("gggggggggggggg $user ggggggggggggg");
                Utils.closeDialog(event.context);
            final loadedData = LoginStateLoaded(user);
                _user = user;
            emit(state.copyWith(state: loadedData));

            emit(state.copyWith(
              email: '',
              password: '',
              state: const LoginStateInitial(),
            ));
          },
        );
      }
      // Helper().toastMsg("${acc.email}\n${acc.displayName}");
      // socialLogin(acc.id,acc.displayName, acc.email, acc.photoUrl,google);

      // acc.authentication.then((GoogleSignInAuthentication auth) async {
      //   print('Auth id token${auth.idToken!}');
      //   print('Auth access token${auth.accessToken!}');
      // });
    });
  }

  ///....... Facebook Login .......
  void _getFacebookLoginInfo(
      LoginWithFacebookEventSubmit event,
      Emitter<LoginModelState> emit,
      ) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxx");
    Client client = Client();
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);

      print("Token is: ${loginResult.accessToken!.token}\n Message is: ${loginResult.message}");

      final token = loginResult.accessToken?.token;
      final appId = loginResult.accessToken?.applicationId;
      final userId = loginResult.accessToken?.userId;

      print("Token is: $token\nApp Id: $appId\nUser is: $userId");

      final graphResponse = await client.get(Uri.parse('https://graph.facebook.com/v14.0/me?fields=id,name,first_name,last_name,email,gender,birthday,picture&access_token=$token'));
      if (kDebugMode) {
        print(graphResponse.body);
      }
      final profile = json.decode(graphResponse.body);
      if (kDebugMode) {
        print(profile);
      }
      // Utils.showSnackBar(event.context, profile.toString());

      if (profile != null) {
        FacebookLoginModel model = FacebookLoginModel.fromJson(jsonDecode(graphResponse.body));
        if (model.id != null) {
          // socialLogin(model.id, model.name, model.email, model.picture?.data?.url, google);

            final body = <String, dynamic>{};

            body.addAll({'id': model.id});
            body.addAll({'name': model.name});
            body.addAll({'username': model.name});
            body.addAll({'email': model.email});
            body.addAll({'token': token});
            body.addAll({'provider': 'facebook'});

            emit(state.copyWith(state: const LoginStateGoogleLoading()));

            Utils.loadingDialog(event.context);

            final result = await _authRepository.socialLogin(body);

            print(result);

            result.fold(
                  (Failure failure) {
                Utils.closeDialog(event.context);
                final error = LoginStateError(failure.message, failure.statusCode);
                emit(state.copyWith(state: error));
              },
                  (user) {
                print("fffffffffff $user fffffffffff");
                Utils.closeDialog(event.context);
                final loadedData = LoginStateLoaded(user);
                _user = user;
                emit(state.copyWith(state: loadedData));

                emit(state.copyWith(
                  email: '',
                  password: '',
                  state: const LoginStateInitial(),
                ));
              },
            );

        } else {
          Utils.showSnackBar(event.context, "Login Failed!");
        }
      }

    }catch (e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

}
