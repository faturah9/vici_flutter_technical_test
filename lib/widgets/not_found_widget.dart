import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vici_technical_test/resources/colors.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    this.image,
    this.title,
    this.subtitle,
    Key? key,
    this.width = 300,
    this.height = 300,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.hasBottomSheet = false,
  }) : super(key: key);

  final String? image;
  final String? title;
  final String? subtitle;
  final double width;
  final double height;
  final MainAxisAlignment mainAxisAlignment;
  final bool hasBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppColors.white,
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image!),
                  ),
                ),
              ),
              Text(title!,
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                subtitle!,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Kembali',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              (hasBottomSheet)
                  ? const SizedBox(
                      height: 120,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
