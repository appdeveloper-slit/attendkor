import 'package:attend_kor_teacher/attendkor3.dart';
import 'package:attend_kor_teacher/values/colors.dart';
import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'attendance_stats.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'noticeboard.dart';
import 'teacher_profile.dart';
import 'values/styles.dart';

class AttendKor2 extends StatefulWidget {
  final String sUsertype;

  const AttendKor2({super.key, required this.sUsertype});

  @override
  State<AttendKor2> createState() => _AttendKor2State();
}

class _AttendKor2State extends State<AttendKor2> with TickerProviderStateMixin {
  late BuildContext ctx;

  List<dynamic> timetableList = [
    {
      'btntclr': Color(0xfffcebe3),
      'tclr': Color(0xffca937c),
      'tclr2': Color(0xfffcebe3),
      'page' : TeacherProfile(),
      'btn': 'Completed',
      'date': '16/04/2023',
      'btnclr': Clr().transparent,
      'clr': LinearGradient(
        colors: [
          Color(0xff111233),
          Color(0xff32334C),
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    }, //Completed Card
    {
      'tclr': Clr().textcolor,
      'btntclr': Clr().textcolor,
      'btn': 'Enter Code',
      'date': '16/04/2023',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    }, //Enter Code Card
    {
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Enter Code',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
    {
      'btntclr': Color(0xfffcebe3),
      'tclr': Color(0xffca937c),
      'tclr2': Color(0xfffcebe3),
      'btn': 'Completed',
      'date': '16/04/2023',
      'btnclr': Clr().transparent,
      'clr': LinearGradient(
        colors: [
          Color(0xff111233),
          Color(0xff32334C),
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
    {
      'tclr': Clr().textcolor,
      'btntclr': Clr().textcolor,
      'btn': 'Cancelled',
      'date': '',
      'btnclr': Clr().transparent,
      'clr': LinearGradient(
        colors: [
          Clr().accentColor,
          Clr().accentColor,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    ctx = context;

    TabController _controller = TabController(length: 6, vsync: this);

    return Scaffold(
        bottomNavigationBar: bottomBarLayout(ctx, 1, widget.sUsertype),
        backgroundColor: Clr().white,
        appBar: AppBar(
          title: Text(
            'Thakur college of Engg.',
            maxLines: 1,
            style: Sty().mediumText.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                  fontFamily: '',
                ),
          ),
          elevation: 2,
          shadowColor: Color(0xfff7f7f8),
          centerTitle: true,
          // shadowColor: Clr().borderColor,
          toolbarHeight: 55,
          backgroundColor: Clr().white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dim().d16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      STM().redirect2page(ctx, NoticeBoard());
                    },
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Clr().white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Clr().borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Clr().borderColor.withOpacity(0.6),
                            spreadRadius: 0.5,
                            blurRadius: 4,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dim().d4, vertical: Dim().d4),
                          child: Column(
                            children: [
                              // SvgPicture.asset('assets/noticeboard.svg',
                              //     width: 130),
                              SizedBox(
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'animations/noticeboard_shapes.json',
                                      height: 90,
                                      reverse: false,
                                      repeat: false,
                                      fit: BoxFit.cover,
                                    ),
                                    // Lottie.asset('animations/attendance_statistics.json',
                                    //     height: 300,
                                    //     reverse: false,
                                    //     repeat: false,
                                    //     fit: BoxFit.cover),
                                  ],
                                ),
                              ),
                              Text(
                                'Noticeboard',
                                style: Sty()
                                    .smallText
                                    .copyWith(color: Color(0xffd7a088)),
                              ),
                              SizedBox(
                                height: Dim().d4,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      STM().redirect2page(ctx, AttendanceStats());
                    },
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Clr().white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Clr().borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Clr().borderColor.withOpacity(0.6),
                            spreadRadius: 0.5,
                            blurRadius: 4,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dim().d4, vertical: Dim().d4),
                          child: Column(
                            children: [
                              // SvgPicture.asset('assets/noticeboard.svg',
                              //     width: 130),
                              SizedBox(
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                        'animations/attendance_statistics.json',
                                        height: 90,
                                        reverse: false,
                                        repeat: false,
                                        fit: BoxFit.cover),
                                    // Lottie.asset('animations/attendance_statistics.json',
                                    //     height: 300,
                                    //     reverse: false,
                                    //     repeat: false,
                                    //     fit: BoxFit.cover),
                                  ],
                                ),
                              ),
                              Text(
                                'Attendance Stats',
                                style: Sty()
                                    .smallText
                                    .copyWith(color: Color(0xffd7a088)),
                              ),
                              SizedBox(
                                height: Dim().d4,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dim().d20),
              InkWell(
                onTap: () {
                  STM().redirect2page(ctx, HomePage(sUsertype: ''));
                },
                child: Text(
                  'TimeTable',
                  style: Sty()
                      .largeText
                      .copyWith(fontSize: 18, color: Clr().textcolor),
                ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Next Week',
                      style: Sty().microText.copyWith(color: Color(0xffd7a088)),
                    ),
                    SizedBox(
                      width: Dim().d4,
                    ),
                    SvgPicture.asset('assets/next_week.svg')
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d8,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Clr().lightGrey,
                ))),
                child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Dim().d0),
                    labelColor: Color(0xffca937c),
                    // labelColor: Clr().textcolor,
                    indicatorColor: Color(0xffca937c),
                    automaticIndicatorColorAdjustment: true,
                    unselectedLabelColor: Color(0xffbcbcc6),
                    tabs: [
                      Tab(
                        text: "Mon",
                        height: Dim().d20,
                      ),
                      Tab(
                        text: 'Tue',
                      ),
                      Tab(
                        text: 'Wed',
                      ),
                      Tab(
                        text: 'Thu',
                      ),
                      Tab(
                        text: 'Fri',
                      ),
                      Tab(
                        text: 'Sat',
                      ),
                    ]),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                // height: MediaQuery.of(context).size.height,
                height: 350,
                child: TabBarView(controller: _controller, children: [
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: timetableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().borderColor.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: timetableList[index]['clr']),
                          child: Card(
                            elevation: 0,
                            color: Clr().transparent,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '16/04/2023',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: timetableList[index]
                                                  ['tclr'],
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Teacher :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Darshan Jadhav',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Class Room :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' 19C',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '9 am to 10 am',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    timetableList[index]
                                                        ['btnclr'],
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              // STM().redirect2page(ctx, Job());
                                              _showSuccessDialog(ctx);
                                            },
                                            child: Text(
                                              timetableList[index]['btn'],
                                              style: Sty().largeText.copyWith(
                                                  color: timetableList[index]
                                                      ['btntclr'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: timetableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().borderColor.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: timetableList[index]['clr']),
                          child: Card(
                            elevation: 0,
                            color: Clr().transparent,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '16/04/2023',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: timetableList[index]
                                                  ['tclr'],
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Teacher :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Darshan Jadhav',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Class Room :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' 19C',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '9 am to 10 am',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    timetableList[index]
                                                        ['btnclr'],
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              // STM().redirect2page(ctx, Job());
                                              _showSuccessDialog(ctx);
                                            },
                                            child: Text(
                                              timetableList[index]['btn'],
                                              style: Sty().largeText.copyWith(
                                                  color: timetableList[index]
                                                      ['btntclr'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: timetableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().borderColor.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: timetableList[index]['clr']),
                          child: Card(
                            elevation: 0,
                            color: Clr().transparent,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '16/04/2023',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: timetableList[index]
                                                  ['tclr'],
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Teacher :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Darshan Jadhav',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Class Room :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' 19C',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '9 am to 10 am',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    timetableList[index]
                                                        ['btnclr'],
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              // STM().redirect2page(ctx, Job());
                                              _showSuccessDialog(ctx);
                                            },
                                            child: Text(
                                              timetableList[index]['btn'],
                                              style: Sty().largeText.copyWith(
                                                  color: timetableList[index]
                                                      ['btntclr'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: timetableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().borderColor.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: timetableList[index]['clr']),
                          child: Card(
                            elevation: 0,
                            color: Clr().transparent,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '16/04/2023',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: timetableList[index]
                                                  ['tclr'],
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Teacher :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Darshan Jadhav',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Class Room :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' 19C',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '9 am to 10 am',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    timetableList[index]
                                                        ['btnclr'],
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              // STM().redirect2page(ctx, Job());
                                              _showSuccessDialog(ctx);
                                            },
                                            child: Text(
                                              timetableList[index]['btn'],
                                              style: Sty().largeText.copyWith(
                                                  color: timetableList[index]
                                                      ['btntclr'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: timetableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().borderColor.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: timetableList[index]['clr']),
                          child: Card(
                            elevation: 0,
                            color: Clr().transparent,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '16/04/2023',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: timetableList[index]
                                                  ['tclr'],
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Teacher :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Darshan Jadhav',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Class Room :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' 19C',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '9 am to 10 am',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    timetableList[index]
                                                        ['btnclr'],
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              // STM().redirect2page(ctx, Job());
                                              _showSuccessDialog(ctx);
                                            },
                                            child: Text(
                                              timetableList[index]['btn'],
                                              style: Sty().largeText.copyWith(
                                                  color: timetableList[index]
                                                      ['btntclr'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: timetableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().borderColor.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: timetableList[index]['clr']),
                          child: Card(
                            elevation: 0,
                            color: Clr().transparent,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '16/04/2023',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: timetableList[index]
                                                  ['tclr'],
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Teacher :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Darshan Jadhav',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d12,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Class Room :",
                                      style: Sty().smallText.copyWith(
                                            fontFamily: '',
                                            fontWeight: FontWeight.w300,
                                            color: timetableList[index]['tclr'],
                                            // color: Color(0xff2D2D2D),
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' 19C',
                                          style: Sty().smallText.copyWith(
                                              color: timetableList[index]
                                                  ['tclr2'],
                                              fontWeight: FontWeight.w400,
                                              fontFamily: '',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dim().d4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: timetableList[index]
                                                    ['tclr'],
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '9 am to 10 am',
                                              style: Sty().smallText.copyWith(
                                                  color: timetableList[index]
                                                      ['tclr2'],
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: '',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    timetableList[index]
                                                        ['btnclr'],
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              // STM().redirect2page(ctx, Job());
                                              _showSuccessDialog(ctx);
                                            },
                                            child: Text(
                                              timetableList[index]['btn'],
                                              style: Sty().largeText.copyWith(
                                                  color: timetableList[index]
                                                      ['btntclr'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }

  //Pop Up
  _showSuccessDialog(ctx) {
    AwesomeDialog(
      width: double.infinity,
      isDense: true,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          children: [
            SizedBox(
              height: Dim().d8,
            ),
            TextFormField(
                // controller: mobileCtrl,
                cursorColor: Clr().textcolor,
                keyboardType: TextInputType.number,
                decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Clr().textcolor,
                      ),
                    ),
                    hintText: 'Enter Code',
                    hintStyle: Sty().mediumText.copyWith(
                          color: Clr().textcolor,
                          fontSize: 14,
                        ))),
            SizedBox(
              height: Dim().d20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    STM().redirect2page(ctx, TeacherProfile());
                    // if (formKey.currentState!.validate()) {
                    //   STM().checkInternet(context, widget).then((value) {
                    //     if (value) {
                    //       sendOTP();
                    //     }
                    //   });
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().textcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Attend',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )),
            ),
            SizedBox(
              height: Dim().d28,
            ),
          ],
        ),
      ),
    ).show();
  }
}
