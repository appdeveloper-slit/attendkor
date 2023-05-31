import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'attendance.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'free_lectures.dart';
import 'manage/static_method.dart';
import 'noticeboard.dart';
import 'timetable3.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class TimeTable2 extends StatefulWidget {
  final String sUsertype;

  const TimeTable2({super.key, required this.sUsertype});

  @override
  State<TimeTable2> createState() => _TimeTable2State();
}

class _TimeTable2State extends State<TimeTable2> with TickerProviderStateMixin {
  late BuildContext ctx;

  String SelectedValue = 'Select Class Room';
  List<String> selectedList = ['Select Class Room', '19A', '19B', '19C', '19D'];
  String t = "0";

  List<dynamic> timetableList = [
    {
      'btntclr': Clr().textcolor,
      'tclr': Color(0xffca937c),
      'tclr2': Color(0xfffcebe3),
      'btn': 'Inactive',
      'date': '16/04/2023',
      'btnclr': Color(0xfffcebe3),
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
      'btn': 'Get Code',
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
      'btn': 'Get Code',
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
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Get Code',
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
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Get Code',
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
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Get Code',
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
  ];

  @override
  Widget build(BuildContext context) {
    ctx = context;

    TabController _controller = TabController(
      length: 6,
      vsync: this,
    );

    return Scaffold(
        bottomNavigationBar: bottomBarLayout(ctx, 1, widget.sUsertype),
        // bottomNavigationBar: bottomBarLayout(ctx, 1),
        backgroundColor: Clr().white,
        appBar: AppBar(
          elevation: 2,
          shadowColor: Color(0xfff7f7f8),
          // shadowColor: Clr().borderColor,
          toolbarHeight: 60,
          backgroundColor: Clr().white,
          leading: InkWell(
              onTap: () {
                STM().back2Previous(ctx);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      STM().redirect2page(ctx, FreeLectures());
                    },
                    child: SvgPicture.asset('assets/free_lecture.svg')),
              )),
          centerTitle: true,
          title: Text(
            'TimeTabl',
            style: Sty()
                .largeText
                .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    STM().redirect2page(ctx, NoticeBoard());
                  },
                  child: Image.asset('assets/notice.png')),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dim().d16),
          child: Column(
            children: [
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
                height: MediaQuery.of(context).size.height,
                // height: 350,
                child: TabBarView(controller: _controller, children: [
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: "Stream :",
                                              style: Sty().smallText.copyWith(
                                                    fontFamily: '',
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xffca937c),
                                                    // color: Color(0xff2D2D2D),
                                                  ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: ' EXTC',
                                                  style: Sty()
                                                      .smallText
                                                      .copyWith(
                                                          color: timetableList[
                                                              index]['tclr2'],
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                          text: "Class :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xffca937c),
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' 1st Year (A)',
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
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xffca937c),
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
                                      SizedBox(
                                        height: Dim().d12,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Class Room :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xffca937c),
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '19C',
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
                                      RichText(
                                        text: TextSpan(
                                          text: "Time : ",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xffca937c),
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
                                        height: Dim().d12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [

                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              DottedBorder(
                                                color: Color(0xffFCEBE3),
                                                //color of dotted/dash line
                                                strokeWidth: 0.5,
                                                //thickness of dash/dots
                                                dashPattern: [6, 4],
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                                  child: Center(
                                                    child: Text(
                                                      '872987',
                                                      style: Sty()
                                                          .largeText
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffFCEBE3),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dim().d12,
                                              ),
                                              SizedBox(
                                                height: 35,
                                                width: 110,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 0,
                                                            // backgroundColor: Clr().accentColor,
                                                            backgroundColor:
                                                                timetableList[
                                                                        index]
                                                                    ['btnclr'],
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5))),
                                                    onPressed: () {
                                                      // STM().redirect2page(ctx, Job());
                                                      _showAttendanceDialog(
                                                          ctx);
                                                    },
                                                    child: Text(
                                                      'Inactive',
                                                      style: Sty()
                                                          .largeText
                                                          .copyWith(
                                                              color:
                                                                  timetableList[
                                                                          index]
                                                                      [
                                                                      'btntclr'],
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                                  color: Clr().white),
                              child: Card(
                                elevation: 0,
                                color: Clr().transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(Dim().d12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: "Stream :",
                                              style: Sty().smallText.copyWith(
                                                    fontFamily: '',
                                                    fontWeight: FontWeight.w300,
                                                    color: Clr().primaryColor,
                                                    // color: Color(0xff2D2D2D),
                                                  ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: ' EXTC',
                                                  style: Sty()
                                                      .smallText
                                                      .copyWith(
                                                          color: Clr()
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: '',
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                '16/04/2023',
                                                // timetableList[index]['date'],
                                                style: Sty().microText.copyWith(
                                                      fontFamily: '',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Clr().primaryColor,
                                                      // color: Color(0xff2D2D2D),
                                                    ),
                                              ),
                                              SizedBox(
                                                width: Dim().d12,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/cancel.svg')
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dim().d12,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Class :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Clr().primaryColor,
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' 1st Year (A)',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().primaryColor,
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
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Clr().primaryColor,
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().primaryColor,
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
                                                color: Clr().primaryColor,
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '19C',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().primaryColor,
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
                                                    color: Clr().primaryColor,
                                                    // color: Color(0xff2D2D2D),
                                                  ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '9 am to 10 am',
                                                  style: Sty()
                                                      .smallText
                                                      .copyWith(
                                                          color: Clr()
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: '',
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 110,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    // backgroundColor: Clr().accentColor,
                                                    backgroundColor:
                                                        timetableList[index]
                                                            ['btnclr'],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            // side: BorderSide(color: Color(0xfff4f4f5)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                onPressed: () {
                                                  // STM().redirect2page(ctx, Job());
                                                  _showAttendanceDialog(ctx);
                                                },
                                                child: Text(
                                                  'Get Code',
                                                  style: Sty()
                                                      .largeText
                                                      .copyWith(
                                                          color: Clr()
                                                              .primaryColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                                  color: Clr().white),
                              child: Card(
                                elevation: 0,
                                color: Clr().transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(Dim().d12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: "Stream :",
                                              style: Sty().smallText.copyWith(
                                                    fontFamily: '',
                                                    fontWeight: FontWeight.w300,
                                                    color: Clr().primaryColor,
                                                    // color: Color(0xff2D2D2D),
                                                  ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: ' EXTC',
                                                  style: Sty()
                                                      .smallText
                                                      .copyWith(
                                                          color: Clr()
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: '',
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                '16/04/2023',
                                                // timetableList[index]['date'],
                                                style: Sty().microText.copyWith(
                                                      fontFamily: '',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Clr().primaryColor,
                                                      // color: Color(0xff2D2D2D),
                                                    ),
                                              ),
                                              SizedBox(
                                                width: Dim().d12,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/cancel.svg')
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dim().d12,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Class :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Clr().primaryColor,
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' 1st Year (A)',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().primaryColor,
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
                                          text: "Subject :",
                                          style: Sty().smallText.copyWith(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w300,
                                                color: Clr().primaryColor,
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Digital Electronics',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().primaryColor,
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
                                                color: Clr().primaryColor,
                                                // color: Color(0xff2D2D2D),
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '19C',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().primaryColor,
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
                                                    color: Clr().primaryColor,
                                                    // color: Color(0xff2D2D2D),
                                                  ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '9 am to 10 am',
                                                  style: Sty()
                                                      .smallText
                                                      .copyWith(
                                                          color: Clr()
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: '',
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 110,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    // backgroundColor: Clr().accentColor,
                                                    backgroundColor:
                                                        timetableList[index]
                                                            ['btnclr'],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            // side: BorderSide(color: Color(0xfff4f4f5)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                onPressed: () {
                                                  // STM().redirect2page(ctx, Job());
                                                  _showAttendanceDialog(ctx);
                                                },
                                                child: Text(
                                                  'Get Code',
                                                  style: Sty()
                                                      .largeText
                                                      .copyWith(
                                                          color: Clr()
                                                              .primaryColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                        width: 110,
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
                                              _showAttendanceDialog(ctx);
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
                                              _showAttendanceDialog(ctx);
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
                                              _showAttendanceDialog(ctx);
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
                                              _showAttendanceDialog(ctx);
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
                                              _showAttendanceDialog(ctx);
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

  //Pop Ups
  _showAttendanceDialog(ctx) {
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
            Text(
              "Summary",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: Dim().d24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Students:-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                  Text(
                    "80",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim().d16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Absent Students:-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                  Text(
                    "20",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim().d16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Present Students:-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                  Text(
                    "60",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim().d32,
            ),
            Text(
              "Absent Last Time ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Table(
              border: TableBorder.all(
                  color: Clr().textcolor,
                  width: 0.3,
                  borderRadius: BorderRadius.circular(5)),
              children: const [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Student Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Lectures Missed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Darshan Jadhav",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "2",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Aniket Mahakal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "3",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Yogesh Pawar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 138,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        // _showCodeDialog(ctx);
                        STM().redirect2page(
                            ctx,
                            TimeTable3(
                              sUsertype: '',
                            ));
                        // if (formKey.currentState!.validate()) {
                        //   STM().checkInternet(context, widget).then((value) {
                        //     if (value) {
                        //       sendOTP();
                        //     }
                        //   });
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Clr().white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Clr().textcolor,
                          // fontFamily: 'Merriweather',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )),
                ),
                SizedBox(
                  width: 138,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        // _showCodeDialog(ctx);
                        STM().redirect2page(ctx, Attendance());
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
                        'View Attendance',
                        style: TextStyle(
                          // fontFamily: 'Merriweather',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )),
                ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: Dim().d8,
            ),
          ],
        ),
      ),
    ).show();
  }

  _showCodeDialog(ctx) {
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
            Text(
              'Show This Generated Code to students\n& Attend Lecture.',
              style: Sty().smallText.copyWith(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                    color: Clr().black,
                    // color: Color(0xff2D2D2D),
                  ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xfffcebe3),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: 220,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: DottedBorder(
                color: Clr().textcolor, //color of dotted/dash line
                strokeWidth: 1, //thickness of dash/dots
                dashPattern: [6, 4],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Center(
                    child: Text(
                      '872987',
                      style: Sty().largeText.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Clr().textcolor),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dim().d24,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    // STM().redirect2page(ctx, TeacherProfile());
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
                    'Next',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Dim().d14),
              //   child: SizedBox(
              //     height: Dim().d56,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xff991404),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //       onPressed: () {
              //         if (formkey.currentState!.validate()) {
              //           // updateUser();
              //           widget.sType == 'addAddress'? getaddAddress():getUpdateAddress();
              //         }
              //       },
              //       child: Center(
              //         child: Text(
              //           'Save address',
              //           style: Sty().mediumText.copyWith(color: Clr().white),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
            SizedBox(
              height: Dim().d16,
            ),
          ],
        ),
      ),
    ).show();
  }
}
