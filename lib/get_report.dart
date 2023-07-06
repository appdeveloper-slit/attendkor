import 'package:attend_kor_teacher/values/colors.dart';
import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage/static_method.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class GetReports extends StatefulWidget {
  @override
  State<GetReports> createState() => _GetReportsState();
}

class _GetReportsState extends State<GetReports> {
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController dobCtrl1 = TextEditingController();
  TextEditingController dobteacherCtrl = TextEditingController();
  TextEditingController dobteacherCtrl1 = TextEditingController();

  Future datePicker() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobCtrl = TextEditingController(text: s);
      });
    }
  }

  Future datePicker1() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobCtrl1 = TextEditingController(text: s);
      });
    }
  }

  Future datePickerTeacher() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobteacherCtrl = TextEditingController(text: s);
      });
    }
  }

  Future datePickerTeacher1() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobteacherCtrl1 = TextEditingController(text: s);
      });
    }
  }

  String? streamValue, teacherStream, TeacherToken;
  List<dynamic> streamList = [];

  int? stream_id,
      semester_id,
      year_id,division_id;


  String? classValue, teacherClass;
  List<dynamic> classList = [];

  String? semestervalue, teacherSemester;
  List<dynamic> semesterList = [];

  String? divisionValue, teacherDivision;
  String? error1, error2, error3, error4,error5,error6;
  String? teachererror1, teachererror2, teachererror3, teachererror4,teachererror5,teachererror6;
  List<dynamic> divisionList = [];


  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? null;
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        apiReports();
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
          'Reports',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Student Reports',
                style: Sty()
                    .mediumText
                    .copyWith(color: Clr().black, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Dim().d8,
              ),
              Text(
                'Get the detailed reports of all the students in your classroom in terms of excel sheet.',
                textAlign: TextAlign.center,
                style: Sty().smallText.copyWith(
                    color: Color(0xff58596e),
                    fontFamily: '',
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: Dim().d28,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: streamValue,
                          isExpanded: true,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          hint: Text(
                            'Select Stream',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: streamList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'],
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (t) {
                            setState(() {
                              streamValue = t.toString();
                              int position = streamList.indexWhere((e) => e['name'].toString() == streamValue.toString());
                              print(position);
                              stream_id = streamList[position]['id'];
                              classList = streamList[position]['years'];
                              semestervalue = null;
                              error1 = null;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: classValue,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          isExpanded: true,
                          hint: Text(
                            'Select Class',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: classList.map((string) {
                            return DropdownMenuItem(
                              value: string['year'],
                              child: Text(
                                string['year'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (c) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              classValue = c.toString();
                              int position = classList.indexWhere((e) => e['year'].toString() == classValue.toString());
                              year_id = classList[position]['id'];
                              semesterList = classList[position]['semesters'];
                              divisionList = classList[position]['divisions'];
                              semestervalue = null;
                              divisionValue = null;
                              error3 = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  error2 != null ? SizedBox(height: Dim().d16) : Container(),
                  error2 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: Text('${error2}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                  error1 != null ? SizedBox(height: Dim().d16) : Container(),
                  error1 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Text('${error1}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                ],
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: semestervalue,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          isExpanded: true,
                          hint: Text(
                            'Select Semester',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: semesterList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'],
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (t) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              semestervalue = t.toString();
                              int position = semesterList.indexWhere((e) =>
                              e['name'].toString() ==
                                  semestervalue.toString());
                              semester_id = semesterList[position]['id'];
                              error2 = null;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: divisionValue,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          isExpanded: true,
                          hint: Text(
                            'Select Division',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: divisionList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'],
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (d) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              divisionValue = d.toString();
                              int position = divisionList.indexWhere((e) => e['name'].toString() == divisionValue.toString());
                              division_id = divisionList[position]['id'];
                              error4 = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               Row(
                 children: [
                   error3 != null ? SizedBox(height: Dim().d16) : Container(),
                   error3 == null ? SizedBox.shrink() : Expanded(
                     child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                         child: Text('${error3}',
                             style: TextStyle(
                               fontFamily: 'Roboto',
                               letterSpacing: 0.5,
                               color: Clr().errorRed,
                               fontSize: 14.0,
                             ))),
                   ),
                   // error4 != null ? SizedBox(height: Dim().d16) : Container(),
                   // error4 == null ? SizedBox.shrink() : Expanded(
                   //   child: Padding(
                   //       padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                   //       child: Text('${error4}',
                   //           style: TextStyle(
                   //             fontFamily: 'Roboto',
                   //             letterSpacing: 0.5,
                   //             color: Clr().errorRed,
                   //             fontSize: 14.0,
                   //           ))),
                   // ),
                 ],
               ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: dobCtrl,
                          onTap: () {
                            datePicker();
                          },
                          readOnly: true,
                          onChanged: (v){
                            setState(() {
                              error5 = null;
                            });
                          },
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(Dim().d12),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'From Date',
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300,
                                fontSize: Dim().d16,
                              ))),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: dobCtrl1,
                          onTap: () {
                            datePicker1();
                          },
                          readOnly: true,
                          onChanged: (v){
                            setState(() {
                              error6 = null;
                            });
                          },
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                              suffixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dim().d12),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'To Date',
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300,
                                fontSize: Dim().d16,
                              ))),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  error5 != null ? SizedBox(height: Dim().d16) : Container(),
                  error5 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: Text('${error5}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                  error6 != null ? SizedBox(height: Dim().d16) : Container(),
                  error6 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Text('${error6}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                ],
              ),
              SizedBox(height: Dim().d28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _validateForm(ctx,'/student_report');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Clr().textcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text(
                            'Attendance Report',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffFCEBE3),
                              fontWeight: FontWeight.w500,
                              fontSize: Dim().d16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dim().d12),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _validateForm(ctx,'/black_student_report');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Clr().textcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text(
                            'Blacklist Report',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // fontFamily: 'Merriweather',
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFCEBE3),
                              fontSize: Dim().d16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d40,
              ),
              Text(
                'Teacher Report',
                style: Sty().mediumText.copyWith(color: Clr().textcolor),
              ),
              SizedBox(
                height: Dim().d8,
              ),
              Text(
                'Get the detailed reports of all the students in your classroom in terms of excel sheet.',
                textAlign: TextAlign.center,
                style: Sty().smallText.copyWith(
                    color: Color(0xff58596e),
                    fontFamily: '',
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: dobteacherCtrl,
                          onTap: () {
                            datePickerTeacher();
                          },
                          readOnly: true,onChanged: (v){
                        setState(() {
                          teachererror5 = null;
                        });
                      },
                          decoration: Sty().TextFormFieldOutlineStyle
                              .copyWith(
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(Dim().d12),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'From Date',
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300,
                                fontSize: Dim().d16,
                              ))),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: dobteacherCtrl1,
                          onTap: () {
                            datePickerTeacher1();
                          },
                          readOnly: true,
                          onChanged: (v){
                            setState(() {
                              teachererror6 = null;
                            });
                          },
                          decoration: Sty().TextFormFieldOutlineStyle
                              .copyWith(
                              suffixIcon: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: Dim().d12),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'To Date',
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300,
                                fontSize: Dim().d16,
                              ))),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  teachererror5 != null ? SizedBox(height: Dim().d16) : Container(),
                  teachererror5 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: Text('${teachererror5}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                  teachererror6 != null ? SizedBox(height: Dim().d16) : Container(),
                  teachererror6 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Text('${teachererror6}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                ],
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: teacherStream,
                          isExpanded: true,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          hint: Text(
                            'Select Stream',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: streamList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'],
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (t) {
                            setState(() {
                              teacherStream = t.toString();
                              int position = streamList.indexWhere((e) => e['name'].toString() == teacherStream.toString());
                              print(position);
                              stream_id = streamList[position]['id'];
                              classList = streamList[position]['years'];
                              teacherSemester = null;
                              teachererror1 = null;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: teacherClass,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          isExpanded: true,
                          hint: Text(
                            'Select Class',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: classList.map((string) {
                            return DropdownMenuItem(
                              value: string['year'],
                              child: Text(
                                string['year'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (c) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              teacherClass = c.toString();
                              int position = classList.indexWhere((e) => e['year'].toString() == teacherClass.toString());
                              year_id = classList[position]['id'];
                              semesterList = classList[position]['semesters'];
                              divisionList = classList[position]['divisions'];
                              teacherSemester = null;
                              teacherDivision = null;
                              teachererror3 = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  teachererror2 != null ? SizedBox(height: Dim().d16) : Container(),
                  teachererror2 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: Text('${teachererror2}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                  teachererror1 != null ? SizedBox(height: Dim().d16) : Container(),
                  teachererror1 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Text('${teachererror1}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                ],
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: teacherSemester,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          isExpanded: true,
                          hint: Text(
                            'Select Semester',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: semesterList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'],
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (t) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              teacherSemester = t.toString();
                              int position = semesterList.indexWhere((e) =>
                              e['name'].toString() ==
                                  teacherSemester.toString());
                              semester_id = semesterList[position]['id'];
                              teachererror2 = null;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: teacherDivision,
                          decoration: Sty().TextFormFieldOutlineDarkStyle,
                          isExpanded: true,
                          hint: Text(
                            'Select Division',
                            style: Sty().smallText.copyWith(
                                color: Clr().hintColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: divisionList.map((string) {
                            return DropdownMenuItem(
                              value: string['name'],
                              child: Text(
                                string['name'],
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (d) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              teacherDivision = d.toString();
                              int position = divisionList.indexWhere((e) =>
                              e['name'].toString() ==
                                  teacherDivision.toString());
                              division_id = divisionList[position]['id'];
                              teachererror4 = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  teachererror3 != null ? SizedBox(height: Dim().d16) : Container(),
                  teachererror3 == null ? SizedBox.shrink() : Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: Text('${teachererror3}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              color: Clr().errorRed,
                              fontSize: 14.0,
                            ))),
                  ),
                  // error4 != null ? SizedBox(height: Dim().d16) : Container(),
                  // error4 == null ? SizedBox.shrink() : Expanded(
                  //   child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                  //       child: Text('${error4}',
                  //           style: TextStyle(
                  //             fontFamily: 'Roboto',
                  //             letterSpacing: 0.5,
                  //             color: Clr().errorRed,
                  //             fontSize: 14.0,
                  //           ))),
                  // ),
                ],
              ),
              SizedBox(
                height: Dim().d28,
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _teacherValidateForm(ctx,'/teacher_report');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().textcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    'Lecture History',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFCEBE3),
                      fontSize: Dim().d16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// reports api
  void apiReports() async {
    var result = await STM().get(
        ctx, Str().loading, '/get_stream', TeacherToken, 'teacher');
    var success = result['success'];
    if (success) {
      setState(() {
        streamList = result['data'];
      });
    }
  }

  /// api for student report
  void getReport(type) async {
    FormData body = FormData.fromMap({
      'stream_id': stream_id,
      'semester_id': semester_id,
      'year_id': year_id,
      'division_id': division_id,
      'from_date': type == '/teacher_report'? dobteacherCtrl.text : dobCtrl.text,
      'to_date': type == '/teacher_report'? dobteacherCtrl1.text : dobCtrl1.text,
    });
    var result = await STM().postWithToken(
        ctx, Str().processing, type, body, TeacherToken,
        'teacher');
    var success = result['success'];
    if (success) {
      STM().openWeb('${result['path']}');
      setState(() {
        semestervalue = null;
        streamValue = null;
        classValue = null;
        divisionValue = null;
        dobCtrl1.clear();
        dobCtrl.clear();
        dobteacherCtrl1.clear();
        dobteacherCtrl.clear();
      });
    } else {
      STM().errorDialog(ctx, '${result['message']}');
    }
  }


  // validation funtion
  _validateForm(ctx,type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool _isValid = formKey.currentState!.validate();

    if (streamValue == null) {
      setState(() => error1 = "This field is required");
      _isValid = false;
    }
    if (semestervalue == null) {
      setState(() {
        error2 = "This field is required";
      });
      _isValid = false;
    }
    if (classValue == null) {
      setState(() {
        error3 = "This field is required";
      });
      _isValid = false;
    }
    if (dobCtrl.text.isEmpty) {
      setState(() {
        error5 = "This field is required";
      });
      _isValid = false;
    }
    if (dobCtrl1.text.isEmpty) {
      setState(() {
        error6 = "This field is required";
      });
      _isValid = false;
    }
    // if (divisionValue == null) {
    //   setState(() {
    //     error4 = "This filed is required";
    //   });
    //   _isValid = false;
    // }
    if (_isValid) {
      getReport(type);
    }
  }

  // validation funtion
  _teacherValidateForm(ctx,type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool _isValid = formKey.currentState!.validate();

    if (teacherStream == null) {
      setState(() => teachererror1 = "This field is required");
      _isValid = false;
    }
    if (teacherSemester == null) {
      setState(() {
        teachererror2 = "This field is required";
      });
      _isValid = false;
    }
    if (teacherClass == null) {
      setState(() {
        teachererror3 = "This field is required";
      });
      _isValid = false;
    }
    if (dobteacherCtrl.text.isEmpty) {
      setState(() {
        teachererror5 = "This field is required";
      });
      _isValid = false;
    }
    if (dobteacherCtrl1.text.isEmpty) {
      setState(() {
        teachererror6 = "This field is required";
      });
      _isValid = false;
    }
    // if (divisionValue == null) {
    //   setState(() {
    //     error4 = "This filed is required";
    //   });
    //   _isValid = false;
    // }
    if (_isValid) {
      getReport(type);
    }
  }

}
