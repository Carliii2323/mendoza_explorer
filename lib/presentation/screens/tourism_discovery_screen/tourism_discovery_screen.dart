import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/tour_card_widget.dart';

class TourismDiscoveryScreen extends StatelessWidget {
  TourismDiscoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray_300,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //titulo
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10.h),
                      child: Text(
                        'Mendoza Explorer',
                        textAlign: TextAlign.left,
                        style: TextStyleHelper.instance.headline24SemiBoldPoppins
                            .copyWith(height: 1.5),
                      ),
                    ),
                  ),


                  // Main image
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 40.h,
                      left: 28.h,
                      right: 28.h,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgImage1,
                      width: double.infinity,
                      height: 236.h,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: 1.h,
                    margin: EdgeInsets.only(top: 20.h, bottom: 2.h),
                    color: appTheme.black_900,
                  ),
                  // Title
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 10.h,
                      left: 10.h,
                    ),
                    child: Text(
                      'Descubre Mendoza',
                      textAlign: TextAlign.left,
                      style: TextStyleHelper.instance.headline24SemiBoldPoppins
                          .copyWith(height: 1.5),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: 1.h,
                    margin: EdgeInsets.only(top: 10.h, bottom: 2.h),
                    color: appTheme.black_900,
                  ),

                  // Tab section
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 6.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 2.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTabItem('Bodega', true),
                        _buildTabItem('Comidas', true),
                        _buildTabItem('Actividad', true),
                        _buildTabItem('Parque', true),
                        _buildTabItem('Eventos', true),
                      ],
                    ),
                  ),

                  // Tour cards section
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 22.h,
                      left: 10.h,
                      right: 18.h,
                    ),
                    child: Row(
                      spacing: 36.h,
                      children: [
                        Expanded(
                          child: TourCardWidget(
                            imagePath: ImageConstant.imgImage3,
                            title: 'Tours de Vino',
                            subtitle: 'Viñedos, Catas, Experiencias',
                            price: '\$50.00',
                            iconPath: ImageConstant.imgVector,
                            onTap: () => _onTourCardTap(context),
                          ),
                        ),
                        Expanded(
                          child: TourCardWidget(
                            imagePath: ImageConstant.imgImage4,
                            title: 'Sitios Culturales',
                            subtitle: 'Museos',
                            price: '\$10.00',
                            iconPath: ImageConstant.imgVectorGray900,
                            onTap: () => _onTourCardTap(context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Line separator
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    margin: EdgeInsets.only(top: 20.h, bottom: 2.h),
                    color: appTheme.black_900,
                  ),
                  // Atracciones section
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 10.h,
                      left: 10.h,
                    ),
                    child: Text(
                      'Atracciones',
                      textAlign: TextAlign.left,
                      style: TextStyleHelper.instance.headline24SemiBoldPoppins
                          .copyWith(height: 1.5),
                    ),
                  ),

                  // Line separator
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    margin: EdgeInsets.only(top: 6.h, bottom: 86.h),
                    color: appTheme.black_900,
                  ),
                ],
              ),
            ),
          ),

          // Bottom navigation
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIconIonicons,
                  width: 24.h,
                  height: 60.h,
                  margin: EdgeInsets.only(bottom: 12.h, left: 6.h),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconIoniconsGray900,
                  width: 24.h,
                  height: 65.h,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconIoniconsGray90024x24,
                  width: 24.h,
                  height: 65.h,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconIonicons24x24,
                  width: 24.h,
                  height: 65.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: isSelected
          ? BoxDecoration(
        color: appTheme.colorFF4CAF,
        borderRadius: BorderRadius.circular(20.h),
      )
          : null,
      child: Text(
        text,
        style: TextStyleHelper.instance.body13SemiBoldPoppins.copyWith(
            color: isSelected ? Color(0xFFFFFFFF) : appTheme.black_900,
            height: 1.5),
      ),
    );
  }

  void _onTourCardTap(BuildContext context) {
    // Handle tour card tap
  }
}
