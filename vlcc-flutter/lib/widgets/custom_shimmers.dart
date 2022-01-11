import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';

import 'fixed_shimmer.dart';

enum ShimmerType { profile, assessment, session, wallet, singleShimmer }

class CustomShimmer extends StatelessWidget {
  final ShimmerType shimmers;
  const CustomShimmer({Key? key, this.shimmers = ShimmerType.assessment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(shimmerType: shimmers);
  }

  Widget body({required ShimmerType shimmerType}) {
    switch (shimmerType) {
      case ShimmerType.assessment:
        return assessmentListingShimmer();
      case ShimmerType.session:
        return sessionListingShimmer();
      case ShimmerType.profile:
        return profilePageShimmer();
      case ShimmerType.singleShimmer:
        return singleShimmer();
      case ShimmerType.wallet:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Shimmer.fromColors(
            highlightColor: AppColors.greyShadow,
            baseColor: AppColors.grey,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 25),
                    Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      default:
        return MyShimmer();
    }
  }

  Widget profilePageShimmer() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Shimmer.fromColors(
        highlightColor: AppColors.greyShadow,
        baseColor: AppColors.grey,
        child: Column(
          children: [
            const SizedBox(width: 40),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      PNGAsset.avatar,
                    )),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(width: 20),
            Container(
              height: 22,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 22,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  6,
                  (index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 25),
                          Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
            )
          ],
        ),
      ),
    );
  }

  Widget sessionListingShimmer() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Shimmer.fromColors(
            highlightColor: AppColors.greyShadow,
            baseColor: AppColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(5,
                  // ignore: missing_return
                  (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 175,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget assessmentListingShimmer() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(5, (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget singleShimmer() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Shimmer.fromColors(
        highlightColor: AppColors.greyShadow,
        baseColor: AppColors.grey,
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
