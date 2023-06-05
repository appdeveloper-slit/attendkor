import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Map<String, dynamic>> dataLectureList = [];
  String t = "0";
  List<dynamic> dayTimeTableList = [];
  String? TeacherToken;
  int position = 0;
  var code;
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
    return DefaultTabController(
      length: dayTimeTableList.length,
      initialIndex: position,
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
  _showClassDialog(ctx,timetableid,classroomid) {
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                        style:
                            Sty().mediumText.copyWith(color: Clr().hintColor)),
                    items: selectedList.map((string) {
                      return DropdownMenuItem(
                        value: string['name'].toString(),
                        child: Text(
                          string['name'],
                          style:
                              TextStyle(color: Clr().textcolor, fontSize: 14),
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
              SizedBox(
                height: Dim().d20,
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      getTimeTable(apiname: 'update_actual_classroom', type: 'post',value: [
                         timetableid,
                         classroomid,
                      ]);
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
        );
      }),
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
                    STM().redirect2page(
                        ctx,
                        TimeTable2(
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
            ),
            SizedBox(
              height: Dim().d16,
            ),
          ],
        ),
      ),
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
                    var Lecturestatus = e['data'][index]['status'];
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
                                                cancelLecture(
                                                    id: e['data'][index]['id']);
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
                                height: Dim().d4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Dim().d180,
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
                                  Lecturestatus == "0"
                                      ? SizedBox(
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
                                                _showClassDialog(ctx,e['data'][index]['id'],e['data'][index]['classroom_id']);
                                              },
                                              child: Text(
                                                'Get Code',
                                                style: Sty().largeText.copyWith(
                                                    color: e['data'][index]
                                                                ['status'] ==
                                                            "0"
                                                        ? Clr().textcolor
                                                        : Clr().textGoldenColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                        )
                                      : Text(
                                          Lecturestatus == "2"
                                              ? 'Cancelled'
                                              : 'Completed',
                                          style: Sty().mediumText.copyWith(
                                              color: Clr().textGoldenColor)),
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
            height: Dim().d20,
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
  void getTimeTable({value,type, apiname}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    /// required key's of every api using their api name
    var data;
    switch (apiname) {
      case "get_timetable":
        data = FormData.fromMap({
          'next_week': value,
        });
        break;
      case "update_actual_classroom":
        data = FormData.fromMap({
          'timetable_id': value['timetable_id'],
          'classroom_id': value['classroom_id'],
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
            position = dayTimeTableList.indexWhere(
                (e) => e['name'] == DateFormat.E().format(DateTime.now()));
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
