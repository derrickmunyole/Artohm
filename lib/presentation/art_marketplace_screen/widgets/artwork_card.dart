import 'package:artohmapp/core/app_export.dart';
import 'package:artohmapp/presentation/art_marketplace_screen/models/art_marketplace_model.dart';
import 'package:artohmapp/presentation/modal_contact_seller/modal_contact_seller.dart';
import 'package:artohmapp/presentation/modal_screen/artwork_card_modal.dart';
import 'package:artohmapp/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../models/seller_model.dart';

class CustomCardWidget extends StatelessWidget {
  final MarketPlaceArtwork card;
  final MarketPlaceArtwork artwork;

  CustomCardWidget({required this.card, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      // height: double.maxFinite,
      padding: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          SizedBox(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  fit: BoxFit.fill,
                  // imagePath: card.imagePath,
                  imagePath: artwork.imagePath,
                  radius: BorderRadius.circular(8.h),
                  alignment: Alignment.center,
                ),
                IconButton(
                  onPressed: () {
                    ArtworkCardModalState.showModal(context);
                  },
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: appTheme.whiteA700,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.v),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artwork.title.tr,
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 6.v),
                    Text(
                      artwork.artist.tr,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 4.v,
                  ),
                  decoration: AppDecoration.outlineBlack90001.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder4,
                      color: appTheme.blue50),
                  child: Text(
                    artwork.price.tr,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_outlined,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CustomElevatedButton(
                  onTap: () {
                    Get.bottomSheet(ContactSellerBottomSheet(seller: seller));
                  },
                  text: 'Contact Seller',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
