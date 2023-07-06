// ignore_for_file: unrelated_type_equality_checks
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attendance.dart';
import 'home.dart';
import 'teacher_profile.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'free_lectures.dart';
import 'manage/static_method.dart';
import 'noticeboard.dart';
import 'values/colors.dart';
import 'values/detailsfalse.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class TimeTable extends StatefulWidget {
  final loop;

  const TimeTable({super.key, this.loop});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  late BuildContext ctx;
  String? SelectedValue;
  List<dynamic> selectedList = [];
  List<dynamic> dayTimeTableList = [];
  AwesomeDialog? dialog;
  var now;

  // 'Stream', 'Class', 'Subject', 'Class Room', 'Time'
  // 'Stream','Teacher', 'Class Room', 'Time'
  List<Map<String, dynamic>> teacherList = [];
  List<Map<String, dynamic>> studentList = [];
  String? TeacherToken, StudentToken;
  var code, changeColor, colleagedetails, studentid;
  bool selectweek = false;
  bool nextSelect = false;
  TextEditingController codeCtrl = TextEditingController();
  var lat, lng;

  int? click;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? null;
      StudentToken = sp.getString('studenttoken') ?? null;
      now = DateFormat('dd-MM-yyyy').format(DateTime.now());
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getTimeTable(apiname: 'get_timetable', type: 'post');
        TeacherToken != null
            ? getTimeTable(apiname: 'get_classroom', type: 'get')
            : null;

        /// teacher token not equal to null means if teacher in not login
        print(StudentToken);
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
    return WillPopScope(
      onWillPop: () async {
        if (widget.loop == 'profile') {
          STM().finishAffinity(ctx, Home());
        } else {
          STM().back2Previous(ctx);
        }
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: bottomBarLayout(ctx, 1, Color(0xff32334D)),
        backgroundColor: Clr().white,
        appBar: colleagedetails == false
            ? AppBar(
                elevation: 0,
                backgroundColor: Clr().white,
              )
            : appbarLayout(),
        body: dayTimeTableList.isEmpty
            ? colleagedetails == false
                ? Center(
                    child: EmptyDetails.EmptyContainer(ctx),
                  )
                : Container()
            : DefaultTabController(
                length: dayTimeTableList.length,
                initialIndex: click!,
                child: Column(
                  children: [
                    Expanded(
                      child: NestedScrollView(
                        floatHeaderSlivers: true,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverAppBar(
                              backgroundColor: Clr().white,
                              expandedHeight:
                                  TeacherToken != null ? Dim().d16 : Dim().d200,
                              collapsedHeight:
                                  TeacherToken != null ? Dim().d16 : Dim().d200,
                              toolbarHeight: 0.0,
                              forceElevated: innerBoxIsScrolled,
                              bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(Dim().d52),
                                  child: Column(
                                    children: [
                                      TeacherToken != null
                                          ? Container()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                bottom: Dim().d20,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        STM().redirect2page(
                                                            ctx, NoticeBoard());
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Clr().white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: Clr()
                                                                  .borderColor),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Clr()
                                                                  .borderColor
                                                                  .withOpacity(
                                                                      0.6),
                                                              spreadRadius: 0.5,
                                                              blurRadius: 4,
                                                              offset: Offset(3,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Card(
                                                          elevation: 0,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        Dim()
                                                                            .d4,
                                                                    vertical:
                                                                        Dim()
                                                                            .d4),
                                                            child: Column(
                                                              children: [
                                                                // SvgPicture.asset('assets/noticeboard.svg',
                                                                //     width: 130),
                                                                SizedBox(
                                                                  height: 90,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Lottie
                                                                          .asset(
                                                                        'animations/noticeboard_shapes.json',
                                                                        height:
                                                                            90,
                                                                        reverse:
                                                                            false,
                                                                        repeat:
                                                                            false,
                                                                        fit: BoxFit
                                                                            .cover,
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
                                                                      .copyWith(
                                                                          color:
                                                                              Color(0xffd7a088)),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Dim().d4,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: Dim().d20),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // STM().redirect2page(ctx, AttendanceStats());
                                                      },
                                                      child: Container(
                                                        width: 140,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Clr().white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: Clr()
                                                                  .borderColor),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Clr()
                                                                  .borderColor
                                                                  .withOpacity(
                                                                      0.6),
                                                              spreadRadius: 0.5,
                                                              blurRadius: 4,
                                                              offset: Offset(3,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Card(
                                                          elevation: 0,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        Dim()
                                                                            .d4,
                                                                    vertical:
                                                                        Dim()
                                                                            .d4),
                                                            child: Column(
                                                              children: [
                                                                // SvgPicture.asset('assets/noticeboard.svg',
                                                                //     width: 130),
                                                                SizedBox(
                                                                  height: 90,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Lottie.asset(
                                                                          'animations/attendance_statistics.json',
                                                                          height:
                                                                              90,
                                                                          reverse:
                                                                              false,
                                                                          repeat:
                                                                              false,
                                                                          fit: BoxFit
                                                                              .cover),
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
                                                                      .copyWith(
                                                                          color:
                                                                              Color(0xffd7a088)),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Dim().d4,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      TeacherToken != null
                                          ? Container()
                                          : Text(
                                              "TimeTable",
                                              style: Sty().mediumText,
                                            ),
                                      WeekSelectionLayout(),
                                      SizedBox(height: Dim().d16),
                                      tabLayout(),
                                    ],
                                  )),
                              stretch: true,
                            ),
                          ];
                        },
                        body: bodyLayout(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  //Pop Ups
  /// get code container dialog
  _showClassDialog({ctx, timetableid, classroomid}) {
    int? position1;
    AwesomeDialog(
      width: double.infinity,
      isDense: true,
      context: ctx,
      dismissOnTouchOutside: nextSelect ? false : true,
      dismissOnBackKeyPress: nextSelect ? false : true,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: Dim().d12, vertical: 0),
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
                              int position = selectedList.indexWhere(
                                  (e) => e['name'].toString() == t.toString());
                              position1 = selectedList[position]['id'];
                              print(position1);
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
                                    position1!,
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

  /// add attendance student
  addAttendance(studentid, timetableid) {
    return AwesomeDialog(
        width: double.infinity,
        isDense: true,
        context: ctx,
        dialogType: DialogType.NO_HEADER,
        animType: AnimType.BOTTOMSLIDE,
        alignment: Alignment.centerLeft,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dim().d32),
              TextFormField(
                controller: codeCtrl,
                decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                      hintStyle:
                          Sty().smallText.copyWith(color: Clr().hintColor),
                      hintText: 'Enter code',
                    ),
              ),
              SizedBox(height: Dim().d20),
              Center(
                child: InkWell(
                  onTap: () {
                    permissionHandle(timetableid);
                    // codeCtrl.clear();
                  },
                  child: Container(
                      width: Dim().d200,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Clr().primaryColor,
                          borderRadius: BorderRadius.circular(Dim().d4)),
                      child: const Center(
                          child: Text(
                        "Attend",
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ),
              SizedBox(height: Dim().d32),
            ],
          ),
        ))
      ..show();
  }

  /// appbar Layout
  AppBar appbarLayout() {
    return AppBar(
      elevation: 2,
      shadowColor: Color(0xfff7f7f8),
      // shadowColor: Clr().borderColor,
      toolbarHeight: 60,
      backgroundColor: Clr().white,
      leadingWidth: StudentToken != null ? double.infinity : null,
      leading: TeacherToken != null
          ? InkWell(
              onTap: () {
                if (widget.loop == 'profile') {
                  STM().finishAffinity(ctx, Home());
                } else {
                  STM().back2Previous(ctx);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      STM().redirect2page(ctx, FreeLectures());
                    },
                    child: SvgPicture.asset('assets/free_lecture.svg')),
              ))
          : Container(),
      centerTitle: true,
      title: StudentToken != null
          ? Container()
          : Text(
              'TimeTable',
              style: Sty().largeText.copyWith(
                  color: Clr().textcolor, fontWeight: FontWeight.w600),
            ),
      actions: [
        StudentToken != null
            ? Container()
            : Padding(
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
      height: TeacherToken != null
          ? MediaQuery.of(ctx).size.height / 1.5
          : MediaQuery.of(ctx).size.height / 2.1,
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: e['data'].length,
                  itemBuilder: (context, index) {
                    var Lecturestatus;
                    if (e['data'][index]['code_status'] == "1") {
                      Lecturestatus = e['data'][index]['code_status'];
                    } else {
                      Lecturestatus = e['data'][index]['status'];
                    }
                    return TeacherToken != null
                        ? teacherLayout(
                            status: Lecturestatus,
                            teacherlist: e['data'][index])
                        : studentLayout(
                            status: Lecturestatus,
                            studentlist: e['data'][index]);
                  },
                );
        }).toList(),
      ),
    );
  }

  /// studentbodylayout
  Widget studentLayout({studentlist, status}) {
    return InkWell(
      onTap: () {
        STM().redirect2page(
            ctx,
            TeacherProfile(
              value: studentlist['teacher'],
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: Dim().d14, right: Dim().d12, left: Dim().d12),
        width: double.infinity,
        decoration: BoxDecoration(
            color: status == "0"
                ? Clr().white
                : status == "1"
                    ? Clr().primaryColor
                    : Color(0xffD49A80),
            border: Border.all(color: Clr().borderColor),
            boxShadow: [
              BoxShadow(
                color: Clr().borderColor.withOpacity(0.8),
                spreadRadius: 0.5,
                blurRadius: 4,
                offset: Offset(3, 3), // changes position of shadow
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${studentlist['date']}',
                      // timetableList[index]['date'],
                      style: Sty().microText.copyWith(
                            color: status == "0"
                                ? Clr().black
                                : status == "1"
                                    ? Clr().textGoldenColor
                                    : Clr().black,
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            // color: Color(0xff2D2D2D),
                          ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: Dim().d220,
                        child: RichText(
                          text: TextSpan(
                            text: "Subject :",
                            style: Sty().smallText.copyWith(
                                  fontFamily: '',
                                  fontWeight: FontWeight.w300,
                                  color: status == "0"
                                      ? Clr().textcolor
                                      : status == "1"
                                          ? Clr().textGoldenColor
                                          : Color(0xff32334D),
                                  // color: Color(0xff2D2D2D),
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' ${studentlist['subject']['name'].toString()}',
                                style: Sty().smallText.copyWith(
                                    color: status == "0"
                                        ? Clr().black
                                        : status == "2"
                                            ? Color(0xff111233)
                                            : Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: '',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                SizedBox(
                  width: Dim().d220,
                  child: RichText(
                    text: TextSpan(
                      text: "Teacher :",
                      style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            color: status == "0"
                                ? Clr().textcolor
                                : status == "1"
                                    ? Clr().textGoldenColor
                                    : Color(0xff32334D),
                            // color: Color(0xff2D2D2D),
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${studentlist['teacher']['name'].toString()}',
                          style: Sty().smallText.copyWith(
                              color: status == "0"
                                  ? Clr().black
                                  : status == "2"
                                      ? Color(0xff111233)
                                      : Color(0xffFCEBE3),
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
                            color: status == "0"
                                ? Clr().textcolor
                                : status == "1"
                                    ? Clr().textGoldenColor
                                    : Color(0xff32334D),
                            // color: Color(0xff2D2D2D),
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              ' ${studentlist['classroom']['name'].toString()}',
                          style: Sty().smallText.copyWith(
                              color: status == "0"
                                  ? Clr().black
                                  : status == "2"
                                      ? Color(0xff111233)
                                      : Color(0xffFCEBE3),
                              fontWeight: FontWeight.w400,
                              fontFamily: '',
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: Dim().d12),
                        child: SizedBox(
                          child: RichText(
                            text: TextSpan(
                              text: "Time : ",
                              style: Sty().smallText.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: '',
                                    color: status == "0"
                                        ? Clr().textcolor
                                        : status == "1"
                                            ? Clr().textGoldenColor
                                            : Color(0xff32334D),
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${studentlist['from_time'].toString()} to ${studentlist['to_time'].toString()}',
                                  style: Sty().smallText.copyWith(
                                      color: status == "0"
                                          ? Clr().black
                                          : status == "2"
                                              ? Color(0xff111233)
                                              : Color(0xffFCEBE3),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: '',
                                      fontSize: Dim().d14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if(now == studentlist['date'])
                    studentlist['status'] == "1" ? Container() :
                    studentlist['attendance_status'] ? Container() : SizedBox(
                      height: Dim().d32,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              // backgroundColor: Clr().accentColor,
                              backgroundColor: Color(0xfffcebe3),
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Color(0xfff4f4f5)),
                                  borderRadius:
                                  BorderRadius.circular(5))),
                          onPressed: () {
                            codeCtrl.clear();
                            addAttendance(studentid, studentlist['id']);
                          },
                          child: Text(
                            'Enter Code',
                            style: Sty().largeText.copyWith(
                                color: studentlist['status'] == "0"
                                    ? Clr().textcolor
                                    : Clr().textGoldenColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ],
                ),
                status == "0"
                    ? Container()
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Text(status == "2" ? 'Cancelled' : 'Completed',
                            style: Sty().mediumText.copyWith(
                                color: status == "2"
                                    ? Clr().black
                                    : Color(0xffFCEBE3),
                                fontSize: Dim().d14)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// teacherbodyLayout
  Widget teacherLayout({teacherlist, status}) {
    return Container(
      margin:
          EdgeInsets.only(bottom: Dim().d14, right: Dim().d12, left: Dim().d12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: status == "0" ? Clr().white : Clr().primaryColor,
          border: Border.all(color: Clr().borderColor),
          boxShadow: [
            BoxShadow(
              color: Clr().borderColor.withOpacity(0.8),
              spreadRadius: 0.5,
              blurRadius: 4,
              offset: Offset(3, 3), // changes position of shadow
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: Dim().d180,
                      child: RichText(
                        text: TextSpan(
                          text: "Stream :",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: status == "0"
                                    ? Clr().textcolor
                                    : Clr().textGoldenColor,
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' ${teacherlist['stream']['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: status == "0"
                                      ? Clr().black
                                      : Color(0xffFCEBE3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${teacherlist['date'].toString()}',
                        // timetableList[index]['date'],
                        style: Sty().microText.copyWith(
                              color: status == "0"
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
                      status == "0"
                          ? InkWell(
                              onTap: () {
                                STM().canceldialog(
                                    context: ctx,
                                    funtion: () {
                                      cancelLecture(id: teacherlist['id']);
                                      STM().back2Previous(ctx);
                                    },
                                    message:
                                        'Are you sure want to cancel lecture?');
                              },
                              child: SvgPicture.asset('assets/cancel.svg'))
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
                          color: status == "0"
                              ? Clr().textcolor
                              : Clr().textGoldenColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            ' ${teacherlist['year']['year'].toString()} ${(teacherlist['division']['name'].toString())}',
                        style: Sty().smallText.copyWith(
                            color:
                                status == "0" ? Clr().black : Color(0xffFCEBE3),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: Dim().d220,
                      child: RichText(
                        text: TextSpan(
                          text: "Subject :",
                          style: Sty().smallText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: status == "0"
                                  ? Clr().textcolor
                                  : Clr().textGoldenColor
                              // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' ${teacherlist['subject']['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: status == "0"
                                      ? Clr().black
                                      : Color(0xffFCEBE3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                          color: status == "0"
                              ? Clr().textcolor
                              : Clr().textGoldenColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${teacherlist['classroom']['name'].toString()}',
                        style: Sty().smallText.copyWith(
                            color:
                                status == "0" ? Clr().black : Color(0xffFCEBE3),
                            fontWeight: FontWeight.w400,
                            fontFamily: '',
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: status == "0"
                    ? now == teacherlist['date']
                        ? EdgeInsets.zero
                        : EdgeInsets.only(top: Dim().d12)
                    : EdgeInsets.only(top: Dim().d12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: RichText(
                          text: TextSpan(
                            text: "Time : ",
                            style: Sty().smallText.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontFamily: '',
                                  color: status == "0"
                                      ? Clr().textcolor
                                      : Clr().textGoldenColor,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${teacherlist['from_time'].toString()} to ${teacherlist['to_time'].toString()}',
                                style: Sty().smallText.copyWith(
                                    color: status == "0"
                                        ? Clr().black
                                        : Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: '',
                                    fontSize: Dim().d14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (status == '0')
                      now == teacherlist['date']
                          ? SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      // backgroundColor: Clr().accentColor,
                                      backgroundColor: Color(0xfffcebe3),
                                      shape: RoundedRectangleBorder(
                                          // side: BorderSide(color: Color(0xfff4f4f5)),
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () {
                                    _showClassDialog(
                                      ctx: ctx,
                                      timetableid: teacherlist['id'],
                                    );
                                  },
                                  child: Text(
                                    'Get Code',
                                    style: Sty().largeText.copyWith(
                                        color: teacherlist['status'] == "0"
                                            ? Clr().textcolor
                                            : Clr().textGoldenColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )),
                            )
                          : Container(),
                  ],
                ),
              ),
              status == "0"
                  ? Container()
                  : teacherlist['code_status'] == "1"
                      ? Padding(
                          padding: EdgeInsets.only(top: Dim().d12),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dim().d16))),
                                  width: 100.0,
                                  height: 30.0,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: DottedBorder(
                                    color: Clr().white,
                                    //color of dotted/dash line
                                    strokeWidth: 1,
                                    //thickness of dash/dots
                                    dashPattern: [6, 4],
                                    child: Center(
                                      child: Text(
                                        '${teacherlist['code'].toString()}',
                                        style: Sty().largeText.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.0,
                                            color: Clr().white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dim().d16),
                                SizedBox(
                                  height: 35,
                                  width: 120,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          // backgroundColor: Clr().accentColor,
                                          backgroundColor: Color(0xffFCEBE3),
                                          shape: RoundedRectangleBorder(
                                              // side: BorderSide(color: Color(0xfff4f4f5)),
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onPressed: () {
                                        getTimeTable(
                                            value: teacherlist['id'],
                                            apiname: 'inactive_lecture',
                                            type: 'post');
                                      },
                                      child: Text(
                                        'Inactive',
                                        style: Sty().largeText.copyWith(
                                            color: Clr().black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                      )),
                                )
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: Dim().d12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              status == "1"
                                  ? InkWell(
                                      onTap: () {
                                        STM().redirect2page(
                                            ctx,
                                            Attendance(
                                              id: teacherlist['id'].toString(),
                                            ));
                                      },
                                      child: Column(
                                        children: [
                                          Text('Attendance',
                                              style: Sty().smallText.copyWith(
                                                  color: Clr().white,
                                                  fontSize: Dim().d12)),
                                          SizedBox(
                                            height: Dim().d2,
                                            width: Dim().d76,
                                            child: DottedLine(
                                              dashLength: 4.0,
                                              lineThickness: 1,
                                              dashColor: Clr().white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    status == "2" ? 'Cancelled' : 'Completed',
                                    style: Sty().mediumText.copyWith(
                                        color: Clr().textGoldenColor,
                                        fontSize: Dim().d14)),
                              ),
                            ],
                          ),
                        ),
            ],
          ),
        ),
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
                click = dayTimeTableList.indexWhere(
                    (e) => e['name'] == DateFormat.E().format(DateTime.now()));
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
                click = 1;
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
      case "add_attendance":
        data = FormData.fromMap({
          'student_id': value[0],
          'timetable_id': value[1],
          'code': codeCtrl.text,
          'latitude': lat,
          'longitude': lng,
        });
        break;
    }

    /// adding data to the dio body layout..
    FormData body = data;

    ///  response of get and post api in result using what type of api have...
    var result = type == 'get'
        ? await STM().get(
            ctx,
            Str().loading,
            apiname,
            TeacherToken ?? StudentToken,
            TeacherToken != null ? 'teacher/' : 'student/')
        : await STM().postWithToken(
            ctx,
            Str().loading,
            apiname,
            body,
            TeacherToken ?? StudentToken,
            TeacherToken != null ? 'teacher/' : 'student/');
    var success = result['success'];

    /// get response in list using apiname (get_timetable , "get_classroom" is api)
    setState(() {
      switch (apiname) {
        case "get_timetable":
          if (success) {
            dayTimeTableList = result['data'];
            colleagedetails = result['college_details'];
            studentid = result['student_id'];
            setState(() {
              click = dayTimeTableList.indexWhere(
                  (e) => e['name'] == DateFormat.E().format(DateTime.now()));
            });
          } else {
            STM().back2Previous(ctx);
            STM().errorDialog(ctx, '${result['message']}');
          }
          break;
        case "get_classroom":
          if (success) {
            selectedList = result['data'];
          } else {
            STM().back2Previous(ctx);
            STM().errorDialog(ctx, '${result['message']}');
          }
          break;
        case "update_actual_classroom":
          if (success) {
            nextSelect = true;
            code = result['code'];
            _showClassDialog(
                ctx: ctx, timetableid: value[0], classroomid: value[1]);
          } else {
            STM().back2Previous(ctx);
            STM().errorDialog(ctx, '${result['message']}');
          }
          break;
        case "active_lecture":
          if (success) {
            setState(() {
              nextSelect = false;
              SelectedValue = null;
            });
            STM().displayToast("${result['message'].toString()}");
            getTimeTable(apiname: 'get_timetable', type: 'post');
          } else {
            STM().back2Previous(ctx);
            STM().errorDialog(ctx, '${result['message']}');
          }
          break;
        case "inactive_lecture":
          if (success) {
            setState(() {
              nextSelect = false;
              SelectedValue = null;
            });
            getTimeTable(apiname: 'get_timetable', type: 'post');
            summerylayout(value: {
              'totalstudent': result['total_student'].toString(),
              'presentstudents': result['total_present'].toString(),
              'abscentstudents': result['total_absent'].toString(),
              'absent_students': result['absent_students'],
              'tableid': value,
            });
          } else {
            STM().back2Previous(ctx);
            STM().errorDialog(ctx, '${result['message']}');
          }
          break;
        case "add_attendance":
          if (success) {
            STM().back2Previous(ctx);
            STM().displayToast("${result['message'].toString()}");
            getTimeTable(apiname: 'get_timetable', type: 'post');
          } else {
            STM().back2Previous(ctx);
            STM().errorDialog(ctx, '${result['message']}');
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

  /// awsome dialog for summery student after inactive lecture
  summerylayout({value}) {
    var select;
    AwesomeDialog(
        width: double.infinity,
        isDense: true,
        context: ctx,
        dialogType: DialogType.NO_HEADER,
        animType: AnimType.BOTTOMSLIDE,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Summary',
                style: Sty().mediumText.copyWith(
                    fontSize: Dim().d20, fontWeight: FontWeight.w600)),
            SizedBox(height: Dim().d14),
            SizedBox(
              height: Dim().d100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "Absent Students:-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: '',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0),
                      ),
                      Text(
                        "Present Students:-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: '',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${value['totalstudent']}',
                          style: TextStyle(
                              fontFamily: '',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0)),
                      Text('${value['abscentstudents']}',
                          style: TextStyle(
                              fontFamily: '',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0)),
                      Text('${value['presentstudents']}',
                          style: TextStyle(
                              fontFamily: '',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: Dim().d32),
            Text(
              "Absent Last Time ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Dim().d14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Clr().textcolor, width: 0.3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dim().d4),
                      topRight: Radius.circular(Dim().d4)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: Dim().d32,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Clr().textcolor, width: 0.3),
                                  right: BorderSide(
                                      color: Clr().textcolor, width: 0.3)),
                            ),
                            child: Center(
                              child: Text('Student Name',
                                  style: Sty().mediumText.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dim().d14)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dim().d32,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Clr().textcolor, width: 0.3)),
                            ),
                            child: Center(
                              child: Text('Lectures Missed',
                                  style: Sty().mediumText.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dim().d14)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: value['absent_students'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: Dim().d32,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                          color: Clr().textcolor,
                                          width: 0.3,
                                        ),
                                        top: index == 0
                                            ? BorderSide()
                                            : BorderSide(
                                                color: Clr().textcolor,
                                                width: 0.3,
                                              )),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${value['absent_students'][index]['name']}',
                                      style: TextStyle(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Dim().d32,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: index == 0
                                            ? BorderSide()
                                            : BorderSide(
                                                color: Clr().textcolor,
                                                width: 0.3)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${value['absent_students'][index]['absent_count']}',
                                      style: TextStyle(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dim().d32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        select = true;
                      });
                      STM().back2Previous(ctx);
                    },
                    child: Container(
                        height: Dim().d56,
                        decoration: BoxDecoration(
                            color: Clr().white,
                            boxShadow: [
                              BoxShadow(
                                  color: Clr().lightGrey,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1))
                            ],
                            borderRadius: BorderRadius.circular(Dim().d12)),
                        child: Center(
                          child: Text('Done',
                              style:
                                  Sty().smallText.copyWith(color: Clr().black)),
                        )),
                  ),
                ),
                SizedBox(width: Dim().d16),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        select = false;
                      });
                      STM().back2Previous(ctx);
                      STM().redirect2page(
                          ctx,
                          Attendance(
                            id: value['tableid'].toString(),
                          ));
                    },
                    child: Container(
                        height: Dim().d56,
                        decoration: BoxDecoration(
                            color: Clr().primaryColor,
                            borderRadius: BorderRadius.circular(Dim().d12)),
                        child: Center(
                          child: Text('View Attendance',
                              style: Sty()
                                  .smallText
                                  .copyWith(color: Color(0xffFCEBE3))),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dim().d20),
          ],
        )).show();
  }

  Future<void> permissionHandle(timetableid) async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      getLocation(timetableid);
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      STM().displayToast('Location permission is required');
      await Geolocator.openAppSettings();
    }
  }

  // getLocation
  getLocation(timetableid) async {
    dialog = STM.loadingDialog(ctx, 'add Attendance');
    dialog!.show();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        lat = position.latitude.toString();
        lng = position.longitude.toString();
        dialog!.dismiss();
        getTimeTable(
            value: [studentid, timetableid],
            type: 'post',
            apiname: 'add_attendance');
      });
    }).catchError((e) {
      dialog!.dismiss();
    });
  }
}
