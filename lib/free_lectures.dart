import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:attend_kor_teacher/values/strings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manage/static_method.dart';
import 'timetable.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class FreeLectures extends StatefulWidget {
  @override
  State<FreeLectures> createState() => _FreeLecturesState();
}

class _FreeLecturesState extends State<FreeLectures> {
  late BuildContext ctx;
  String? TeacherToken;
  int? SubjectValue;

  int? classValue;

  List<dynamic> timetableList = [];
  List<dynamic> classroomList = [];
  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getLecture();
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
    return WillPopScope(onWillPop: () async {
      STM().replacePage(ctx,TimeTable());
      return false;
    },
      child: Scaffold(
        backgroundColor: Clr().white,
        appBar: AppBar(
          elevation: 2,
          shadowColor: Color(0xfff7f7f8),
          // shadowColor: Clr().borderColor,
          toolbarHeight: 60,
          backgroundColor: Clr().white,
          leading: InkWell(
            onTap: () {
              STM().replacePage(ctx,TimeTable());
            },
            child: Icon(
              Icons.arrow_back,
              size: 28,
              color: Color(0xff131A29),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Free Lectures',
            style: Sty()
                .largeText
                .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dim().d16),
          child: Column(
            children: [
              timetableList.isEmpty ? Container() : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: timetableList.length,
                itemBuilder: (context, index) {
                  var color1 = Color(0xff111233);
                  var color2 = Color(0xff32334D);
                  return Container(
                    margin: EdgeInsets.only(bottom: 14),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Clr().background1,
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
                        gradient: timetableList[index]['clr']),
                    child: Card(
                      elevation: 0,
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
                                          color: color1,
                                          // color: Color(0xff2D2D2D),
                                        ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${timetableList[index]['stream']['name'].toString()}',
                                        style: Sty().smallText.copyWith(
                                            color: color2,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: '',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${timetableList[index]['date'].toString()}',
                                  // timetableList[index]['date'],
                                  style: Sty().microText.copyWith(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w300,
                                        color: color1,
                                        // color: Color(0xff2D2D2D),
                                      ),
                                ),
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
                                      color: color1,
                                      // color: Color(0xff2D2D2D),
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${timetableList[index]['year']['year']} ${timetableList[index]['division']['name']}',
                                    style: Sty().smallText.copyWith(
                                        color: color2,
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
                                    color: color1
                                    // color: Color(0xff2D2D2D),
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${timetableList[index]['classroom']['name']}',
                                    style: Sty().smallText.copyWith(
                                        color: color2,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Time : ",
                                    style: Sty().smallText.copyWith(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w300,
                                          color: color1,
                                          // color: Color(0xff2D2D2D),
                                        ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${timetableList[index]['from_time'].toString()} to ${timetableList[index]['to_time'].toString()}',
                                        style: Sty().smallText.copyWith(
                                            color: color2,
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
                                          backgroundColor: Color(0xffFCEBE3),
                                          shape: RoundedRectangleBorder(
                                              // side: BorderSide(color: Color(0xfff4f4f5)),
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onPressed: () {
                                        // STM().redirect2page(ctx, Job());
                                        _showClassDialog(ctx: ctx,list: timetableList[index],classroomlist: classroomList,subjectlist: timetableList[index]['all_subject']);
                                      },
                                      child: Text(
                                        'Book',
                                        style: Sty().largeText.copyWith(
                                            color: Clr().black,
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
            ],
          ),
        ),
      ),
    );
  }

  //Pop Ups
  _showClassDialog({ctx,list,classroomlist,List? subjectlist}) {
    AwesomeDialog(
      width: double.infinity,
      isDense: true,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(
        padding: EdgeInsets.all(Dim().d16),
        child: StatefulBuilder(builder: (context,setState){
          return Column(
            children: [
              SizedBox(
                height: Dim().d8,
              ),
              TextFormField(
                  cursorColor: Clr().textcolor,
                  readOnly: true,
                  keyboardType: TextInputType.name,
                  decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                      hintText: '${list['stream']['name']}',
                      hintStyle: Sty().mediumText.copyWith(
                        color: Clr().hintColor,
                        fontSize: 14,
                      ))),
              SizedBox(
                height: Dim().d20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        readOnly: true,
                        cursorColor: Clr().textcolor,
                        keyboardType: TextInputType.name,
                        decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                            hintText: '${list['year']['year']}',
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ))),
                  ),
                  SizedBox(width: Dim().d16,),
                  Expanded(
                    child: TextFormField(
                        readOnly: true,
                        cursorColor: Clr().textcolor,
                        keyboardType: TextInputType.name,
                        decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                            hintText: '${list['division']['name']}',
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ))),
                  ),
                ],
              ),

              SizedBox(
                height: Dim().d20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Clr().textcolor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: SubjectValue,
                    isExpanded: true,
                    hint: Text('Enter the subject',style: Sty().smallText.copyWith(color: Clr().hintColor)),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                      color: Clr().textcolor,
                    ),
                    style: TextStyle(color: Color(0xff787882)),
                    items: subjectlist!.map((v) {
                      return DropdownMenuItem(
                        value: v['id'],
                        child: Text(
                          v['name'].toString(),
                          style: TextStyle(color: Clr().textcolor, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (t) {
                      setState(() {
                        SubjectValue = t as int?;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Clr().textcolor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: classValue,
                    isExpanded: true,
                    hint: Text('Enter the classroom',style: Sty().smallText.copyWith(color: Clr().hintColor)),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                      color: Clr().textcolor,
                    ),
                    style: TextStyle(color: Color(0xff787882)),
                    items: classroomList.map((string) {
                      return DropdownMenuItem(
                        value: string['id'],
                        child: Text(
                          string['name'].toString(),
                          style: TextStyle(color: Clr().textcolor, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (t) {
                      // STM().redirect2page(ctx, Home());
                      setState(() {
                        classValue = t as int?;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        cursorColor: Clr().textcolor,
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                            hintText: '${list['from_time']}',
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ))),
                  ),
                  SizedBox(width: Dim().d16,),
                  Expanded(
                    child: TextFormField(
                        readOnly: true,
                        cursorColor: Clr().textcolor,
                        keyboardType: TextInputType.name,
                        decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                            hintText: '${list['to_time']}',
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ))),
                  ),
                ],
              ),
              SizedBox(height: Dim().d20,),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      resheduleLecture(list['id']);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Clr().textcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      'Add',
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
          );
        }),
      ),
    ).show();
  }

  void getLecture() async {
    var result = await STM().get(ctx, Str().loading, 'get_free_lecture', TeacherToken, 'teacher/');
    var success = result['success'];
    if(success){
      setState(() {
        timetableList = result['data'];
        getClassroom();
      });
    }
  }

  void getClassroom() async {
    var result = await STM().get(ctx, Str().loading, 'get_classroom', TeacherToken, 'teacher/');
    var success = result['success'];
    if(success){
      setState(() {
        classroomList = result['data'];
      });
    }
  }

  void resheduleLecture(id) async {
    FormData body = FormData.fromMap({
      'timetable_id': id,
      'subject_id':  SubjectValue,
      'classroom_id': classValue
    });
    var result = await STM().postWithToken(ctx, Str().processing, 'rescheduled_lecture', body, TeacherToken, 'teacher/');
    var success = result['success'];
    var messege = result['messege'];
    if(success){
      STM().successDialogWithReplace(ctx, messege, widget);
    }else{
      STM().errorDialog(ctx, messege);
    }
  }


}
