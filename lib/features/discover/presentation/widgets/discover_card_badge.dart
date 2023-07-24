import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/constants/router_constants.dart';
import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../cubit/new_discover_cubit.dart';

class DiscoverCardBadge extends StatefulWidget {
  const DiscoverCardBadge({super.key});

  @override
  State<DiscoverCardBadge> createState() => _DiscoverCardBadgeState();
}

class _DiscoverCardBadgeState extends State<DiscoverCardBadge> {
  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewDiscoverCubit, NewDiscoverState>(
      buildWhen: (previous, current) =>
          previous.listCartModel != current.listCartModel,
      builder: (context, state) {
        if (state is NewDiscoverBadgesLoading) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(
                height: 20.h,
                width: 20.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          );
        } else {
          return state.listCartModel!.isEmpty
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.cartRoute);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.shopping_cart),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.cartRoute);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: 0, end: 3),
                      badgeAnimation: const badges.BadgeAnimation.slide(
                        disappearanceFadeAnimationDuration:
                            Duration(milliseconds: 200),
                        curve: Curves.easeInCubic,
                      ),
                      showBadge: state.showCardBadge!,
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                      ),
                      badgeContent: Text(
                        state.listCartModel!.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.cartRoute);
                          },
                        ),
                      ),
                    ),
                  ),
                );
        }
      },
    );
  }

  Future<void> fetchCart() async {
    return await sl<NewDiscoverCubit>().fetchDiscoverBadgesEvent();
  }
}
