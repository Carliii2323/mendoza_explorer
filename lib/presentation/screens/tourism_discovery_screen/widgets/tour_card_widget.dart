import 'package:flutter/material.dart';

import '../../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';

class TourCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final String iconPath;
  final VoidCallback? onTap;

  TourCardWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.iconPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.white_A700,
          borderRadius: BorderRadius.circular(18.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            CustomImageView(
              imagePath: imagePath,
              width: double.infinity,
              height: 106.h,
              fit: BoxFit.cover,
            ),

            // Title and subtitle
            Container(
              margin: EdgeInsets.only(top: 6.h, left: 2.h),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: TextStyleHelper.instance.label10SemiBoldPoppins
                          .copyWith(height: 1.5),
                    ),
                    TextSpan(
                      text: subtitle,
                      style: TextStyleHelper.instance.label10RegularPoppins
                          .copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            // Price and currency row
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 6.h, right: 6.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: iconPath,
                    width: iconPath.contains('gray_900') ? 14.h : 10.h,
                    height: 12.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.h),
                    child: Text(
                      price,
                      style: TextStyleHelper.instance.label10SemiBoldPoppins
                          .copyWith(color: appTheme.gray_600, height: 1.5),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 14.h),
                    child: Text(
                      'UDS',
                      style: TextStyleHelper.instance.label10MediumPoppins
                          .copyWith(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
