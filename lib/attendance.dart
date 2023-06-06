import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:attend_kor_teacher/values/strings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'get_report.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class Attendance extends StatefulWidget {
  final String? id;

  const Attendance({super.key, this.id});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late BuildContext ctx;
  String? TeacherToken;
  var lectureDetails, studentdeatails;
  TextEditingController uniqueCtrl = TextEditingController();
  List<dynamic> studentList = [];
  bool nextSelect = false;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getattendance(
            type: 'post', apiname: 'view_attendance', value: widget.id);
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
    return Scaffold(
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
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xff131A29),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Attendance',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
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
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff111233),
                    Color(0xff32334C),
                    //add more colors for gradient
                  ],
                  end: Alignment.topRight, //begin of the gradient color
                  begin: Alignment.bottomLeft,
                ),
              ),
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
                                  text: ' ${lectureDetails['stream']['name']}',
                                  style: Sty().smallText.copyWith(
                                      color: Color(0xfffcebe3),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: '',
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${lectureDetails['date']}',
                            // timetableList[index]['date'],
                            style: Sty().microText.copyWith(
                                  fontFamily: '',
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xffca937c),
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
                              text:
                                  ' ${lectureDetails['year']['year'].toString()} ${(lectureDetails['division']['name'].toString())}',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
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
                              text: ' ',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
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
                              text:
                                  ' ${lectureDetails['classroom']['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
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
                          text: "Time : ",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Color(0xffca937c),
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' ${lectureDetails['from_time'].toString()} to ${lectureDetails['to_time'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dim().d4,
            ),
            InkWell(
              onTap: () {
                _showEnterIDDialog(ctx: ctx);
              },
              child: DottedBorder(
                color: Clr().textcolor,
                //color of dotted/dash line
                strokeWidth: 0.5,
                //thickness of dash/dots
                dashPattern: [6, 4],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                    child: Text(
                      'Add Student',
                      style: Sty().largeText.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Clr().textcolor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Text(
              'List Of Students',
              style: Sty().mediumText.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: Dim().d16,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: Dim().d16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                              width: 22,
                              child: Text(
                                '${index + 1}.',
                                style: Sty()
                                    .smallText
                                    .copyWith(color: Clr().textcolor),
                              )),
                          SizedBox(
                            width: Dim().d8,
                          ),
                          Text(
                            '${studentList[index]['student']['name']}',
                            style: Sty()
                                .smallText
                                .copyWith(color: Clr().textcolor),
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            getattendance(
                                value: studentList[index]['student_id'],
                                apiname: 'delete_attendance',
                                type: 'post');
                          },
                          child: SvgPicture.asset('assets/delete.svg'))
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  //Pop Ups
  _showEnterIDDialog({ctx, timetableid, stiudentid}) {
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
            nextSelect
                ? Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Unique ID:-",
                          style: Sty().mediumText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().textcolor
                              // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${studentdeatails['unique_id'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Name:-",
                          style: Sty().mediumText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().textcolor
                              // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${studentdeatails['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Stream:-",
                          style: Sty().mediumText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().textcolor
                              // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${studentdeatails['stream']['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Class:-",
                          style: Sty().mediumText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().textcolor
                              // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${studentdeatails['year']['year'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Division:-",
                          style: Sty().mediumText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().textcolor
                              // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${studentdeatails['division']['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                    ],
                  )
                : TextFormField(
                    controller: uniqueCtrl,
                    decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                        hintText: 'Enter Student Unique ID',
                        hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ))),
            SizedBox(
              height: Dim().d20,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    nextSelect
                        ? getattendance(value: [
                            timetableid,
                            stiudentid,
                          ], apiname: 'update_attendance', type: 'post')
                        : getattendance(
                            type: 'post',
                            apiname: 'get_student_details',
                            value: uniqueCtrl.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().textcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    nextSelect ? 'Update' : 'Get Details',
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

  /// get attendance list
  void getattendance({value, type, apiname}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    /// required key's of every api using their api name
    var data = FormData.fromMap({});
    switch (apiname) {
      case "view_attendance":
        data = FormData.fromMap({
          'timetable_id': value,
        });
        break;
      case "delete_attendance":
        data = FormData.fromMap({
          'attendance_id': value,
        });
        break;
      case "get_student_details":
        data = FormData.fromMap({
          'unique_id': value,
        });
        break;
      case "update_attendance":
        data = FormData.fromMap({
          'student_id': value[0],
          'timetable_id': value[1],
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
        case "view_attendance":
          if (success) {
            // STM().displayToast('${result['message'].toString()}');
            // getTimeTable(apiname: 'get_timetable', type: 'post');
            lectureDetails = result['lecture_details'][0];
            studentList = result['attendance'];
          }
          break;
        case "delete_attendance":
          if (success) {
            STM().successDialogWithReplace(
                ctx, '${result['message']}', Attendance(id: widget.id));
          }
          break;
        case "get_student_details":
          if (success) {
            studentdeatails = result['data'];
            nextSelect = true;
            STM().back2Previous(ctx);
            _showEnterIDDialog(
                ctx: ctx,
                timetableid: lectureDetails['id'],
                stiudentid: studentdeatails['student_id']);
          }
          break;
        case "update_attendance":
          if (success) {
            STM().back2Previous(ctx);
            STM().successDialogWithReplace(
                ctx,
                '${result['message']}',
                Attendance(
                  id: widget.id,
                ));
          }
          break;
      }
    });
  }
}
