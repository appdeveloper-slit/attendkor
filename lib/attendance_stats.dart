
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class AttendanceStats extends StatefulWidget {
  @override
  State<AttendanceStats> createState() => _AttendanceStatsState();
}

class _AttendanceStatsState extends State<AttendanceStats> {
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return  Scaffold(
      backgroundColor: Clr().white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Color(0xfff7f7f8),
        // shadowColor: Clr().borderColor,
        toolbarHeight: 60,
        backgroundColor: Clr().white,
        leading: InkWell(
          onTap: (){
            STM().back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xff131A29),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Attendance Stats',
          style: Sty().largeText.copyWith(
              color: Clr().textcolor,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Overall Attendance',
              style: Sty().mediumText.copyWith(
                color: Clr().accentColor,
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),),
              Text('70%',
              style: Sty().mediumText.copyWith(
                color: Clr().accentColor,
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),),

            ],
          ),
          SizedBox(height: Dim().d4,),
          const Divider(
            color:  Color(0xFFD49A80),
          ),
          SizedBox(height: Dim().d4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Digital Electronics',
                style: Sty().smallText.copyWith(
                    color: Clr().textcolor,
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                ),),
              Text('65%',
                style: Sty().smallText.copyWith(
                    color: Clr().textcolor,
                  fontFamily: '',
                    fontWeight: FontWeight.w300,
                ),),

            ],
          ),
          SizedBox(height: Dim().d12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Analog Electronics',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),
              Text('75%',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),

            ],
          ),
          SizedBox(height: Dim().d12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mathematics III',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),
              Text('80%',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),

            ],
          ),
          SizedBox(height: Dim().d12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mathematics III',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),
              Text('45%',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),

            ],
          ),
          SizedBox(height: Dim().d12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mechanics',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),
              Text('55%',
                style: Sty().smallText.copyWith(
                  color: Clr().textcolor,
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                ),),

            ],
          ),
          SizedBox(height: Dim().d20,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Clr().accentColor,)
            ),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(Dim().d8),
              child: Column(children: [
                Text('Top Students (EXTC-1st Year-A)',
                  style: Sty().mediumText.copyWith(
                      color: Clr().accentColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                  ),),
                SizedBox(height: Dim().d4,),
                const Divider(
                  color:  Color(0xFFD49A80),
                ),
                SizedBox(height: Dim().d4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                    Image.asset('assets/rank1.png',
                    width: 30,
                    height: 30),
                    SizedBox(width: Dim().d8,),
                    Text('Karan Sharma',
                      style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                      ),),
                  ],),
                  Text('85%',
                    style: Sty().smallText.copyWith(
                      color: Clr().textcolor,
                      fontFamily: '',
                      fontWeight: FontWeight.w300,
                    ),),
                ],),
                SizedBox(height: Dim().d8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                      Image.asset('assets/rank2.png',
                          width: 30,
                          height: 30),
                      SizedBox(width: Dim().d8,),
                      Text('Pramod Sawant',
                        style: Sty().smallText.copyWith(
                          color: Clr().textcolor,
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                        ),),
                    ],),
                    Text('75%',
                      style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                      ),),
                  ],),
                SizedBox(height: Dim().d8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                      Image.asset('assets/rank3.png',
                          width: 30,
                          height: 30),
                      SizedBox(width: Dim().d8,),
                      Text('Lakhan Pardesi',
                        style: Sty().smallText.copyWith(
                          color: Clr().textcolor,
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                        ),),
                    ],),
                    Text('75%',
                      style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                      ),),
                  ],),
              ],),
            ),
          )
        ],),
      ),
    );
  }
}