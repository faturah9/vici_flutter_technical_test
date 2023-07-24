import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../bloc/login_bloc.dart';

class MasukButton extends StatefulWidget {
  const MasukButton({super.key});

  @override
  State<MasukButton> createState() => _MasukButtonState();
}

class _MasukButtonState extends State<MasukButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.h, 0.0, 0.0),
            child: GestureDetector(
              onTap: () async {
                sl<LoginBloc>().add(LoginSubmittedEvent());
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.deepSkyBlue,
                      AppColors.deepSkyBlue.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
