import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vici_technical_test/features/discover/domain/datas/models/item_model.dart';
import 'package:vici_technical_test/features/discover/presentation/cubit/new_discover_cubit.dart';
import 'package:vici_technical_test/features/discover/presentation/widgets/discover_card_badge.dart';
import 'package:vici_technical_test/resources/colors.dart';

import '../../../../injection_container.dart';
import '../../../../widgets/format_currency.dart';
import '../../../../widgets/not_found_widget.dart';
import '../widgets/discover_loading.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Discover',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontSize: 26.sp,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Container(),
        actions: const [
          // _shoppingCartBadge(),
          DiscoverCardBadge(),
        ],
      ),
      body: BlocListener<NewDiscoverCubit, NewDiscoverState>(
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
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                      behavior: SnackBarBehavior.floating),
                );
              },
            );
          } else if (state.successMessage != null &&
              state.addItemStatus == FormzStatus.submissionSuccess) {
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
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                      behavior: SnackBarBehavior.floating),
                );
              },
            );
          }
        },
        child: BlocBuilder<NewDiscoverCubit, NewDiscoverState>(
          buildWhen: (previous, current) =>
              previous.listItemModel != current.listItemModel,
          builder: (context, state) {
            if (state is NewDiscoverLoading) {
              return const NewDiscoverLoadingWidget();
            } else {
              return state.listItemModel!.isNotEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.white,
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AlignedGridView.count(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              itemCount: state.listItemModel!.length,
                              itemBuilder: (context, index) {
                                final item = state.listItemModel![index];
                                return itemsCard(item);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : const SingleChildScrollView(
                      child: NotFoundWidget(
                          image: 'assets/images/tracking_not_found.png',
                          title: 'Pertanyaan Kosong',
                          subtitle: 'Silahkan Coba Lagi Nanti'),
                    );
            }
          },
        ),
      ),
    );
  }

  Future<void> readJson() async {
    return await sl<NewDiscoverCubit>().fetchDiscoverItems();
  }

  Widget itemsCard(ItemModel item) {
    return InkWell(
      onTap: () {
        onTabShowBottomSheet(item, context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      item.imageUrl!,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return SvgPicture.asset(
                          'assets/icon/icon_error.svg',
                          height: 12.h,
                          width: 12.w,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.name!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.gray,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(CurrencyFormat.convertToIdr(item.price, 0),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> onTabShowBottomSheet(ItemModel item, BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builderCtx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 18.w, right: 18.w),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 50.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/icon_close.svg',
                                      height: 26.h,
                                      width: 26.w,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.only(left: 24.w, right: 24.w),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    item.imageUrl!,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return SvgPicture.asset(
                                        'assets/icon/icon_error.svg',
                                        height: 12.h,
                                        width: 12.w,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Text(
                                  item.name!,
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.sp,
                                    color: AppColors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  'Rp${item.price}',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: AppColors.black),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Description",
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16.sp,
                                          color:
                                              AppColors.black.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.description!,
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: AppColors.black,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(
                  left: 14.w,
                  right: 14.w,
                  top: 14.h,
                  bottom: 14.h,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _addItemsToCart(item);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepSkyBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Pilih Items',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.white,
                      ),
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

  Future<void> _addItemsToCart(ItemModel item) async {
    await sl<NewDiscoverCubit>().discoverAddItemsEvent(item);
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
