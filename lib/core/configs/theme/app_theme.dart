import 'package:flutter/material.dart';
import 'package:sptify/core/configs/theme/app_colors.dart';

class AppTheme {

  static final lightTheme = ThemeData(
      primaryColor: AppColors.pink,
      scaffoldBackgroundColor: AppColors.lightBackground,
      brightness: Brightness.light,
      fontFamily: 'Satoshi',
      sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noOverlay
      ),




      /// input decoration in light theme

      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(30),
          hintStyle: const TextStyle(
            color: Color(0xff383838),
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: Colors.white,
                  width: 0.4
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0.4
              )
          )
      ),


      /// elevated buttom

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pink,
              elevation: 0,
              textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              )
          )
      )
  );




  ///daaark

  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      brightness: Brightness.dark,
      fontFamily: 'Satoshi',


      sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noOverlay,
          activeTrackColor: Color(0xffB7B7B7),
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
          thumbColor: Color(0xffB7B7B7)

      ),
      inputDecorationTheme:InputDecorationTheme(
          filled: true ,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.all(30),
          enabledBorder : OutlineInputBorder(
            borderRadius: BorderRadius.circular(30) ,
            borderSide: const BorderSide(
              color : Colors.white ,
              width: 0.4 ,
            ),
          ),
      ),



      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pink,
              elevation: 0,
              textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              )
          )
      )
  );

}