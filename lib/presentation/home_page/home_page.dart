import 'package:artohmapp/data/localStorage.dart';
import 'package:artohmapp/presentation/home_page/widgets/homeArtworkCard.dart';
import 'package:artohmapp/presentation/artworks/controller/artworks_controller.dart';
import 'package:artohmapp/presentation/home_page/models/home_model.dart';
import 'package:artohmapp/presentation/home_page/models/home_model_populated.dart';
import 'package:artohmapp/widgets/custom_search_view.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/home_controller.dart';
import 'package:artohmapp/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:artohmapp/widgets/custom_search_view.dart' as customSearch;

import 'widgets/home_chip.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeController controller = Get.put(HomeController(HomeModel().obs));
  LikedArtworksController likedArtworksController = Get.find();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            leadingWidth: 46.h,
            leading: CustomImageView(
              svgPath: ImageConstant.imgArtohmlogo,
              margin: EdgeInsets.only(
                left: 18.h,
              ),
              height: 40.v,
              width: 30.h,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(9.v, 9.v, 9.v, 9.v),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 32.h),
                    IconButton(
                      icon: Icon(
                        Icons.search_outlined,
                        color: appTheme.red300,
                        size: 24,
                      ),
                      onPressed: () {
                        customSearch.SearchController searchController =
                            customSearch.SearchController();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomSearchView(
                              controller:
                                  searchController.textEditingController,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 32.h),
                    Stack(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            onTapImgNotification();
                          },
                          icon: Icon(
                            Icons.notifications,
                            color: appTheme.red300,
                            size: 24,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Badge.count(
                            backgroundColor: appTheme.red300,
                            textColor: appTheme.whiteA700,
                            count: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.h),
                    CustomImageView(
                      imagePath: ImageConstant.imgFrame72,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                      margin: EdgeInsets.only(left: 32.h, right: 12.h),
                      onTap: () {
                        onTapImgProfileoneone();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          body: bodyContent(),
        ),
      ),
    );
  }

  bodyContent() {
    
    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          homeFilters(),
          SizedBox(height: 8.v),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 2.v),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: appTheme.blueGray400.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgRectangle11400x3401,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.v,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Obx(() {
                    
                    return Column(
                      children: controller.categories.value.map((category) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.categoryName,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium,
                            ),
                            SizedBox(height: 16.v),
                            // Category title
                            Container(
                              height: 200.v,
                              margin:
                                  EdgeInsets.only(right: 15.h, bottom: 24.h),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.artworks.length,
                                itemBuilder: (context, index) {
                                  final artwork = category.artworks[index];
                                  return HomeArtworkCardNew(
                                    artwork: artwork,
                                    
                                  );
                                  // log artwork to se its data
                                  // Log the artwork details to the console
                                },
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    );
                  }), // Close Obx here
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  homeFilters() {
    HomeController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 8,
      ),
      child: Container(
        height: 50.0, // Adjust this value as needed
        child: Align(
          alignment: Alignment.centerLeft,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              for (var chip in controller.homeChipFilterList.value)
                HomeChip(chip: chip),
            ],
          ),
        ),
      ),
    );
  }
  // Padding(
  //   padding: EdgeInsets.only(left: 15.h, top: 18.v),
  //   child: Obx(
  //     () => ListView.separated(
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       separatorBuilder: (context, index) {
  //         return SizedBox(height: 26.v);
  //       },
  //       itemCount: controller
  //           .homeModelObj.value.homeCategoriesList.value.length,
  //       itemBuilder: (context, index) {
  //         HomeCategoriesModel model = controller
  //             .homeModelObj.value.homeCategoriesList.value[index];

  //         return HomeCategoriesWidget(
  //             homeCategoriesModelObj: model);
  //       },
  //     ),
  //   ),
  // ),

  // homeFilterss() {
  //   HomeController controller = Get.find();
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     padding: EdgeInsets.only(left: 16.h, top: 16.v),
  //     child: IntrinsicWidth(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Flexible(
  //             child: CustomDropDown(
  //               borderDecoration: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //                 borderSide: BorderSide(
  //                   color: appTheme.lightBlueA700,
  //                   width: 1.0,
  //                 ),
  //               ),
  //               dropdownColor: appTheme.blue50,
  //               width: 120.h,
  //               hintText: "Filter By",
  //               items: controller.homeModelObj.value.dropdownItemList.value,
  //               onChanged: (value) {
  //                 controller.onSelected(value);
  //               },
  //             ),
  //           ),
  //           for (var chip in controller.homeChipFilterList.value)
  //             HomeChip(chip: chip),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Navigates to the notificationsTabContainerScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the notificationsTabContainerScreen.
  onTapImgNotification() {
    Get.toNamed(
      AppRoutes.notificationsTabContainerScreen,
    );
  }

  /// Navigates to the userProfileContainerScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the userProfileContainerScreen.
  onTapImgProfileoneone() {
    Get.toNamed(
      AppRoutes.userProfileContainerScreen,
    );
  }

  /// Navigates to the art_marketplace_screen when the action is triggered.

  onTapImgMarketplace() {
    Get.toNamed(
      AppRoutes.artMarketplaceScreen,
    );
  }
}
