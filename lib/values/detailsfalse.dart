import 'package:attend_kor_teacher/manage/static_method.dart';
import 'package:attend_kor_teacher/values/colors.dart';
import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:attend_kor_teacher/values/styles.dart';
import 'package:flutter/material.dart';

import '../my_profile.dart';

class EmptyDetails{
  static EmptyContainer(ctx) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dim().d20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get organized and stay informed! ',
            style: Sty().largeText.copyWith(
                color: Clr().textcolor,
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
          ),
          SizedBox(
            height: Dim().d12,
          ),
          Text(
            'Add your institution details to access timetables and attendance statistics from your profile.',
            textAlign: TextAlign.center,
            style: Sty().smallText.copyWith(height: 1.3,
              color: Clr().textcolor,
              fontWeight: FontWeight.w400,

            ),
          ),
          SizedBox(
            height: Dim().d28,
          ),
          SizedBox(
            height: 45,
            width: 300,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    // backgroundColor: Clr().accentColor,
                    backgroundColor: Clr().white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Clr().textcolor),
                        borderRadius: BorderRadius.circular(5)
                    )
                ),
                onPressed: () {
                  STM().redirect2page(ctx, MyProfile());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Go to My Profile',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),),
                    SizedBox(width: Dim().d12,),
                    Icon(Icons.arrow_forward,
                      color: Clr().textcolor,)
                  ],
                )),
          )
        ],
      ),
    );
  }
}