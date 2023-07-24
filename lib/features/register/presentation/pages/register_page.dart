import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:vici_technical_test/widgets/modal_progress_custom.dart';

import '../../../../common/constants/router_constants.dart';
import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../bloc/register_bloc.dart';
import '../widgets/number_phone_input.dart';
import '../widgets/regis_name_input.dart';
import '../widgets/regis_password_input.dart';
import '../widgets/regis_username_input.dart';
import '../widgets/register_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    sl<RegisterBloc>().add(RegisterPageInitEvent());
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
            'Register',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.black,
              fontSize: 26.sp,
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<RegisterBloc, RegisterState>(
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
              } else if (state.submitStatus == FormzStatus.submissionSuccess) {
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
                    RouteName.loginRoute, (route) => false);
              }
            },
            builder: (context, state) {
              if (state.submitStatus == FormzStatus.submissionInProgress) {
                return _buildRegisterWidget(state, true);
              } else {
                return _buildRegisterWidget(state, false);
              }
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Sudah punya akun? ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: AppColors.deepSkyBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterWidget(RegisterState state, bool isLoading) {
    return ModalProgress(inAsyncCall: isLoading, child: bodyContent());
  }

  Widget bodyContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Isi Lengkap Data Diri Anda',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.gray,
                  fontSize: 16.sp,
                  // fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            const RegisNameInput(),
            SizedBox(height: 16.h),
            const RegisUsernameInput(),
            SizedBox(height: 16.h),
            const RegisPasswordInput(),
            SizedBox(height: 16.h),
            const NumberPhoneInput(),
            SizedBox(height: 16.h),
            const RegisterButton(),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
