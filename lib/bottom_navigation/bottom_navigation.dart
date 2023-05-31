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

Widget bottomBarLayout(ctx, index,sUsertype ) {

  return BottomNavigationBar(
    elevation:50,
    backgroundColor: Clr().white,
    selectedItemColor: Clr().grey,
    unselectedItemColor: Clr().grey,
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) async {
      SharedPreferences sp = await SharedPreferences.getInstance();

      switch (i) {
        case 0:
          sp.getString("UserType") == 'Teacher' ? STM().redirect2page(ctx, Home()): STM().redirect2page(ctx,  Home_student(sUsertype: 'Student',));
          // STM().replacePage(ctx, Home());
          break;
        case 1:
          sp.getString("UserType") == 'Teacher' ? STM().redirect2page(ctx, TimeTable(sUsertype: 'Teacher',)): STM().redirect2page(ctx,  AttendKor1(sUsertype: 'Student',));
          // STM().replacePage(ctx,  TimeTable());
          break;
        case 2:
          sp.getString("UserType") == 'Teacher' ? STM().redirect2page(ctx, MyProfile(sUsertype: 'Teacher')) : STM().redirect2page(ctx, StudentProfile(sUsertype: 'Student'));
          // STM().replacePage(ctx,  MyProfile());
          break;
      }
    },
    items: STM().getBottomList(index),
  );
}