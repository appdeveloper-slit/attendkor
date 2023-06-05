
import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:flutter/material.dart';

import 'attend_kor2.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'attendkor3.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class AttendKor1 extends StatefulWidget {
  final String sUsertype;

  const AttendKor1({super.key, required this.sUsertype});

  @override
  State<AttendKor1> createState() => _AttendKor1State();
}

class _AttendKor1State extends State<AttendKor1> {
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return  Scaffold(
      bottomNavigationBar: bottomBarLayout(ctx, 1, Color(0xff32334D)),
      backgroundColor: Clr().white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Color(0xfff7f7f8),
        // shadowColor: Clr().borderColor,
        toolbarHeight: 60,
        backgroundColor: Clr().white,
      ),
      body: Padding(
        padding:  EdgeInsets.all(Dim().d16),
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
                    STM().redirect2page(ctx, HomePage(sUsertype: '',));
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
      ),

    );
  }
}