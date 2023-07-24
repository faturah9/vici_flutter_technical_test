import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:vici_technical_test/common/constants/router_constants.dart';
import 'package:vici_technical_test/widgets/modal_progress_custom.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../bloc/login_bloc.dart';
import '../widgets/masuk_button.dart';
import '../widgets/password_input.dart';
import '../widgets/username_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    sl<LoginBloc>().add(LoginPageInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.black,
                fontSize: 26.sp,
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: Container(),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.submitStatus == FormzStatus.submissionFailure) {
                  _onWidgetDidBuild(
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${state.errorMessage}'),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: 'Oke',
                              textColor: AppColors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                            behavior: SnackBarBehavior.floating),
                      );
                    },
                  );
                } else if (state.submitStatus ==
                    FormzStatus.submissionSuccess) {
                  _onWidgetDidBuild(
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${state.successMessage}'),
                            backgroundColor: Colors.green,
                            action: SnackBarAction(
                              label: 'Oke',
                              textColor: AppColors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                            behavior: SnackBarBehavior.floating),
                      );
                    },
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteName.homeRoute, (route) => false);
                }
              },
              builder: (context, state) {
                if (state.submitStatus == FormzStatus.submissionInProgress) {
                  return _buildLoginInputWidget(state, true);
                } else {
                  return _buildLoginInputWidget(state, false);
                }
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Belum punya akun? ',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      color: AppColors.deepSkyBlue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context)
                            .pushNamed(RouteName.registerRoute);
                      },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _buildLoginInputWidget(LoginState state, bool isLoading) {
    return ModalProgress(
      inAsyncCall: isLoading,
      child: bodyContent(),
    );
  }

  Widget bodyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Masuk Apps',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                  fontSize: 26.sp,
                ),
              ),
            ),
            SizedBox(
              height: 30.0.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Masuk dengan akun yang terdaftar',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.gray,
                  fontSize: 16.sp,
                  // fontSize: 14,
                ),
              ),
            ),
            const UsernameInput(),
            SizedBox(
              height: 15.0.h,
            ),
            const PasswordInput(),
            SizedBox(
              height: 30.0.h,
            ),
            const MasukButton(),
          ],
        ),
      ),
    );
  }
}
