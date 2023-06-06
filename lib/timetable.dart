import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attendance.dart';
import 'attendkor3.dart';
import 'timetable2.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'free_lectures.dart';
import 'manage/static_method.dart';
import 'noticeboard.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  late BuildContext ctx;
  String? SelectedValue;
  List<dynamic> selectedList = [];
  List<dynamic> dayTimeTableList = [];
  String? TeacherToken;
  var code, changeColor;
  bool selectweek = false;
  bool nextSelect = false;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getTimeTable(apiname: 'get_timetable', type: 'post');
        getTimeTable(apiname: 'get_classroom', type: 'get');
        print(TeacherToken);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return dayTimeTableList.isEmpty
        ? Container(color: Clr().white)
        : DefaultTabController(
            length: dayTimeTableList.length,
            initialIndex: dayTimeTableList.indexWhere(
                (e) => e['name'] == DateFormat.E().format(DateTime.now())),
            child: Scaffold(
                bottomNavigationBar: bottomBarLayout(ctx, 1, Color(0xff32334D)),
                backgroundColor: Clr().white,
                appBar: appbarLayout(),
                body: SingleChildScrollView(
                  padding: EdgeInsets.all(Dim().d16),
                  child: Column(
                    children: [
                      WeekSelectionLayout(),
                      SizedBox(height: Dim().d16),
                      tabLayout(),
                      SizedBox(height: Dim().d12),
                      bodyLayout(),
                    ],
                  ),
                )),
          );
  }

  //Pop Ups
  /// get code container dialog
  _showClassDialog(ctx, timetableid, classroomid) {
    AwesomeDialog(
      width: double.infinity,
      isDense: true,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: StatefulBuilder(builder: (context, setstate) {
        return Container(
          padding: EdgeInsets.all(Dim().d16),
          child: Column(
            children: [
              SizedBox(
                height: Dim().d8,
              ),
              nextSelect
                  ? Container()
                  : Text(
                      'Confirm Class',
                      style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            height: 1.2,
                            color: Clr().black,
                            // color: Color(0xff2D2D2D),
                          ),
                    ),
              nextSelect ? Container() : SizedBox(height: Dim().d20),
              nextSelect
                  ? Text(
                      'Show This Generated Code to students\n& Attend Lecture.',
                      style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            height: 1.2,
                            color: Clr().black,
                            // color: Color(0xff2D2D2D),
                          ),
                    )
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: SelectedValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          hint: Text('Select Classroom name',
                              style: Sty()
                                  .mediumText
                                  .copyWith(color: Clr().hintColor)),
                          items: selectedList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'].toString(),
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (t) {
                            setstate(() {
                              SelectedValue = t.toString();
                            });
                          },
                        ),
                      ),
                    ),
              nextSelect ? SizedBox(height: Dim().d20) : Container(),
              nextSelect
                  ? Container(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Center(
                            child: Text(
                              '${code}',
                              style: Sty().largeText.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Clr().textcolor),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: Dim().d20,
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      setstate(() {
                        nextSelect
                            ? getTimeTable(
                                apiname: 'active_lecture',
                                value: timetableid,
                                type: 'post',
                              )
                            : getTimeTable(
                                apiname: 'update_actual_classroom',
                                type: 'post',
                                value: [
                                    timetableid,
                                    classroomid,
                                  ]);
                        STM().back2Previous(ctx);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Clr().textcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        // fontFamily: 'Merriweather',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )),
              ),
              SizedBox(
                height: Dim().d16,
              ),
            ],
          ),
        );
      }),
    ).show();
  }

  /// appbar Layout
  AppBar appbarLayout() {
    return AppBar(
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
      title: InkWell(
        onTap: () {
          STM().redirect2page(
              ctx,
              HomePage(
                sUsertype: '',
              ));
        },
        child: Text(
          'TimeTable',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
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
    );
  }

  /// tabbarview or boydLayout of lecturer details
  Widget bodyLayout() {
    return SizedBox(
      height: MediaQuery.of(ctx).size.height / 1.5,
      child: TabBarView(
        children: dayTimeTableList.map((e) {
          return e['data'].isEmpty
              ? SizedBox(
                  height: MediaQuery.of(ctx).size.height / 1.5,
                  child: Center(
                    child: Text('No Lectures Available',
                        style: Sty().mediumBoldText),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: e['data'].length,
                  itemBuilder: (context, index) {
                    var Lecturestatus;
                    if (e['data'][index]['code_status'] == "1") {
                      Lecturestatus = e['data'][index]['code_status'];
                    } else {
                      Lecturestatus = e['data'][index]['status'];
                    }
                    return Container(
                      margin: EdgeInsets.only(bottom: Dim().d14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Lecturestatus == "0"
                              ? Clr().white
                              : Clr().primaryColor,
                          border: Border.all(color: Clr().borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Clr().borderColor.withOpacity(0.8),
                              spreadRadius: 0.5,
                              blurRadius: 4,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)),
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
                                  SizedBox(
                                    width: Dim().d180,
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Stream :",
                                        style: Sty().smallText.copyWith(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              color: Lecturestatus == "0"
                                                  ? Clr().textcolor
                                                  : Clr().textGoldenColor,
                                              // color: Color(0xff2D2D2D),
                                            ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' ${e['data'][index]['stream']['name'].toString()}',
                                            style: Sty().smallText.copyWith(
                                                color: Lecturestatus == "0"
                                                    ? Clr().black
                                                    : Clr().white,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: '',
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        '${e['data'][index]['date'].toString()}',
                                        // timetableList[index]['date'],
                                        style: Sty().microText.copyWith(
                                              color: Lecturestatus == "0"
                                                  ? Clr().black
                                                  : Clr().textGoldenColor,
                                              fontFamily: '',
                                              fontWeight: FontWeight.w300,
                                              // color: Color(0xff2D2D2D),
                                            ),
                                      ),
                                      SizedBox(
                                        width: Dim().d12,
                                      ),
                                      Lecturestatus == "0"
                                          ? InkWell(
                                              onTap: () {
                                                STM().canceldialog(
                                                    context: ctx,
                                                    funtion: () {
                                                      cancelLecture(
                                                          id: e['data'][index]
                                                              ['id']);
                                                      STM().back2Previous(ctx);
                                                    },
                                                    message:
                                                        'Are you sure want to cancel lecture?');
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/cancel.svg'))
                                          : Container()
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Dim().d12,
                              ),
                              SizedBox(
                                width: Dim().d220,
                                child: RichText(
                                  text: TextSpan(
                                    text: "Class :",
                                    style: Sty().smallText.copyWith(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w300,
                                          color: Lecturestatus == "0"
                                              ? Clr().textcolor
                                              : Clr().textGoldenColor,
                                          // color: Color(0xff2D2D2D),
                                        ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' ${e['data'][index]['year']['year'].toString()} ${(e['data'][index]['division']['name'].toString())}',
                                        style: Sty().smallText.copyWith(
                                            color: Lecturestatus == "0"
                                                ? Clr().black
                                                : Clr().white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: '',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dim().d12,
                              ),
                              SizedBox(
                                width: Dim().d220,
                                child: RichText(
                                  text: TextSpan(
                                    text: "Subject :",
                                    style: Sty().smallText.copyWith(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w300,
                                          color: Lecturestatus == "0"
                                              ? Clr().textcolor
                                              : Clr().textGoldenColor,
                                          // color: Color(0xff2D2D2D),
                                        ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' ${e['data'][index]['subject']['name'].toString()}',
                                        style: Sty().smallText.copyWith(
                                            color: Lecturestatus == "0"
                                                ? Clr().black
                                                : Clr().white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: '',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dim().d12,
                              ),
                              SizedBox(
                                width: Dim().d220,
                                child: RichText(
                                  text: TextSpan(
                                    text: "Class Room :",
                                    style: Sty().smallText.copyWith(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w300,
                                          color: Lecturestatus == "0"
                                              ? Clr().textcolor
                                              : Clr().textGoldenColor,
                                          // color: Color(0xff2D2D2D),
                                        ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' ${e['data'][index]['classroom']['name'].toString()}',
                                        style: Sty().smallText.copyWith(
                                            color: Lecturestatus == "0"
                                                ? Clr().black
                                                : Clr().white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: '',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dim().d12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Dim().d240,
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Time : ",
                                        style: Sty().smallText.copyWith(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: '',
                                              color: Lecturestatus == "0"
                                                  ? Clr().textcolor
                                                  : Clr().textGoldenColor,
                                            ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' ${e['data'][index]['from_time'].toString()} to ${e['data'][index]['to_time'].toString()}',
                                            style: Sty().smallText.copyWith(
                                                color: Lecturestatus == "0"
                                                    ? Clr().black
                                                    : Clr().white,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: '',
                                                fontSize: Dim().d14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dim().d12),
                              Lecturestatus == "0"
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                // backgroundColor: Clr().accentColor,
                                                backgroundColor:
                                                    Color(0xfffcebe3),
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              _showClassDialog(
                                                  ctx,
                                                  e['data'][index]['id'],
                                                  e['data'][index]
                                                      ['classroom_id']);
                                            },
                                            child: Text(
                                              'Get Code',
                                              style: Sty().largeText.copyWith(
                                                  color: e['data'][index]
                                                              ['status'] ==
                                                          "0"
                                                      ? Clr().textcolor
                                                      : Clr().textGoldenColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ),
                                    )
                                  : e['data'][index]['code_status'] == "1"
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                Dim().d16))),
                                                width: 100.0,
                                                height: 30.0,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2),
                                                child: DottedBorder(
                                                  color: Clr().white,
                                                  //color of dotted/dash line
                                                  strokeWidth: 1,
                                                  //thickness of dash/dots
                                                  dashPattern: [6, 4],
                                                  child: Center(
                                                    child: Text(
                                                      '${e['data'][index]['code'].toString()}',
                                                      style: Sty()
                                                          .largeText
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 10.0,
                                                              color:
                                                                  Clr().white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: Dim().d16),
                                              SizedBox(
                                                height: 35,
                                                width: 120,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 0,
                                                            // backgroundColor: Clr().accentColor,
                                                            backgroundColor:
                                                                Color(
                                                                    0xffFCEBE3),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    // side: BorderSide(color: Color(0xfff4f4f5)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5))),
                                                    onPressed: () {
                                                      getTimeTable(
                                                          value: e['data']
                                                              [index]['id'],
                                                          apiname:
                                                              'inactive_lecture',
                                                          type: 'post');
                                                    },
                                                    child: Text(
                                                      'Inactive',
                                                      style: Sty()
                                                          .largeText
                                                          .copyWith(
                                                              color:
                                                                  Clr().black,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    )),
                                              )
                                            ],
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Lecturestatus == "1"
                                                ? InkWell(
                                                    onTap: () {
                                                      STM().redirect2page(
                                                          ctx, Attendance(id: e['data'][index]['id'].toString(),));
                                                    },
                                                    child: Text('Attendance',
                                                        style: Sty()
                                                            .smallText
                                                            .copyWith(
                                                                color:
                                                                    Clr().white,
                                                                fontSize:
                                                                    Dim().d12)),
                                                  )
                                                : Container(),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  Lecturestatus == "2"
                                                      ? 'Cancelled'
                                                      : 'Completed',
                                                  style: Sty()
                                                      .mediumText
                                                      .copyWith(
                                                          color: Clr()
                                                              .textGoldenColor,
                                                          fontSize: Dim().d14)),
                                            ),
                                          ],
                                        ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        }).toList(),
      ),
    );
  }

  /// tabbar or tabLayout
  Widget tabLayout() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Clr().lightGrey,
      ))),
      child: TabBar(
        isScrollable: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dim().d0),
        labelColor: Color(0xffca937c),
        // labelColor: Lecturestatus == 0 ? Clr().textcolor : Clr().textGoldenColor,,
        indicatorColor: Color(0xffca937c),
        automaticIndicatorColorAdjustment: true,
        unselectedLabelColor: Color(0xffbcbcc6),
        tabs: dayTimeTableList.map((e) {
          return Tab(
            text: e['name'].toString(),
            height: Dim().d28,
          );
        }).toList(),
      ),
    );
  }

  /// select prevoius week and next week button
  Widget WeekSelectionLayout() {
    return selectweek
        ? InkWell(
            onTap: () {
              getTimeTable(apiname: 'get_timetable', type: 'post');
              setState(() {
                selectweek = false;
              });
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SvgPicture.asset('assets/previuos.svg'),
                  SizedBox(
                    width: Dim().d4,
                  ),
                  Text(
                    'Previous Week',
                    style: Sty().microText.copyWith(color: Color(0xffd7a088)),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              getTimeTable(value: true, type: 'post', apiname: 'get_timetable');
              setState(() {
                selectweek = true;
              });
            },
            child: Align(
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
          );
  }

  /// get TimeTableList
  void getTimeTable({value, type, apiname}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    /// required key's of every api using their api name
    var data = FormData.fromMap({});
    switch (apiname) {
      case "get_timetable":
        data = FormData.fromMap({
          'next_week': value,
        });
        break;
      case "update_actual_classroom":
        data = FormData.fromMap({
          'timetable_id': value[0],
          'classroom_id': value[1],
        });
        break;
      case "active_lecture":
        data = FormData.fromMap({
          'timetable_id': value,
        });
        break;
      case "inactive_lecture":
        data = FormData.fromMap({
          'timetable_id': value,
        });
        break;
    }

    /// adding data to the dio body layout..
    FormData body = data;

    ///  response of get and post api in result using what type of api have...
    var result = type == 'get'
        ? await STM().get(ctx, Str().loading, apiname, TeacherToken, 'teacher/')
        : await STM().postWithToken(
            ctx, Str().loading, apiname, body, TeacherToken, 'teacher/');
    var success = result['success'];

    /// get response in list using apiname (get_timetable , "get_classroom" is api)
    setState(() {
      switch (apiname) {
        case "get_timetable":
          if (success) {
            dayTimeTableList = result['data'];
          }
          break;
        case "get_classroom":
          if (success) {
            selectedList = result['data'];
          }
          break;
        case "update_actual_classroom":
          if (success) {
            nextSelect = true;
            code = result['code'];
            _showClassDialog(ctx, value[0], value[1]);
          }
          break;
        case "active_lecture":
          if (success) {
            STM().successDialogWithReplace(ctx, "${result['message'].toString()}", widget);
          }
          break;
        case "inactive_lecture":
          if (success) {
            STM().successDialogWithReplace(ctx, "${result['message'].toString()}", widget);
          }
          break;
      }
    });
  }

  /// cancel Lecture
  void cancelLecture({id}) async {
    FormData body = FormData.fromMap({
      'timetable_id': id,
    });
    var result = await STM().postWithToken(
        ctx, Str().deleting, 'cancel_lecture', body, TeacherToken, 'teacher/');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
      getTimeTable(apiname: 'get_timetable', type: 'post');
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
