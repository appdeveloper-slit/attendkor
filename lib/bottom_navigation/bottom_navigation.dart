import 'package:attend_kor_teacher/stu_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../attend_kor.dart';
import '../home_student.dart';
import '../timetable.dart';
import '../home.dart';
import '../manage/static_method.dart';
import '../my_profile.dart';
import '../values/colors.dart';

Widget bottomBarLayout(ctx, index,color) {
  return BottomNavigationBar(
    elevation:50,
    selectedItemColor: Clr().grey,
    unselectedItemColor: Clr().grey,
    selectedFontSize: 0.0,
    unselectedFontSize: 0.0,
    currentIndex: index,
    onTap: (i) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      switch (i) {
        case 0:
           STM().finishAffinity(ctx, Home());
          // STM().replacePage(ctx, Home());
          break;
        case 1:
        index == 1 ?  STM().replacePage(ctx, TimeTable()) : STM().redirect2page(ctx, TimeTable());
          // STM().replacePage(ctx,  TimeTable());
          break;
        case 2:
         index == 2 ? STM().replacePage(ctx, MyProfile()) : STM().redirect2page(ctx, MyProfile());
          // STM().replacePage(ctx,  MyProfile());
          break;
      }
    },
    items: STM().getBottomList(index),
  );
}