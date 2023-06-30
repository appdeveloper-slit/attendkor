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
      year_id;


  String? classValue, teacherClass;
  List<dynamic> classList = [];

  String? semestervalue, teacherSemester;
  List<dynamic> semesterList = [];

  String? divisionValue, teacherDivision;
  String? error1, error2, error3, error4;
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
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color:  error1 != null ? Clr().errorRed : Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: streamValue,
                            isExpanded: true,
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
                                int position = streamList.indexWhere((e) =>
                                e['name'].toString() == streamValue.toString());
                                print(position);
                                stream_id = streamList[position]['id'];
                                semesterList =
                                streamList[position]['semesters'];
                                classList = streamList[position]['years'];
                                divisionList =
                                streamList[position]['divisions'];
                                semestervalue = null;
                                classValue = null;
                                divisionValue = null;
                                error1 = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: error2 != null ? Clr().errorRed : Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: semestervalue,
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
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: error3 != null  ? Clr().errorRed :Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: classValue,
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
                                int position = classList.indexWhere((e) =>
                                e['year'].toString() == classValue.toString());
                                year_id = classList[position]['id'];
                                error3 = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: error4 != null  ? Clr().errorRed : Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: divisionValue,
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
                                error4 = null;
                              });
                            },
                          ),
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
                   error4 != null ? SizedBox(height: Dim().d16) : Container(),
                   error4 == null ? SizedBox.shrink() : Expanded(
                     child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                         child: Text('${error4}',
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
                      child: TextFormField(
                          controller: dobCtrl,
                          onTap: () {
                            datePicker();
                          },
                          readOnly: true,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'This field is required';
                            }
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
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'This field is required';
                            }
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
                            _validateForm(ctx);
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
                            // _showCodeDialog(ctx);
                            // STM().redirect2page(ctx, GetReports());
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
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().textcolor)),
                        child: TextFormField(
                            controller: dobteacherCtrl,
                            onTap: () {
                              datePickerTeacher();
                            },
                            readOnly: true,
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
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().textcolor)),
                        child: TextFormField(
                            controller: dobteacherCtrl1,
                            onTap: () {
                              datePickerTeacher1();
                            },
                            readOnly: true,
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: teacherStream,
                            isExpanded: true,
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
                              // STM().redirect2page(ctx, Home());
                              setState(() {
                                teacherStream = t.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: teacherSemester,
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
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: teacherClass,
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
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().textcolor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: teacherDivision,
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
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d28,
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // _showCodeDialog(ctx);
                    // STM().redirect2page(ctx, GetReports());
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
  void getReport() async {
    FormData body = FormData.fromMap({
      'stream_id': stream_id,
      'semester_id': semester_id,
      'year_id': year_id,
    });
    var result = await STM().postWithToken(
        ctx, Str().processing, '/student_report', body, TeacherToken,
        'teacher');
    var success = result['success'];
    if (success) {
      STM().openWeb('${result['path']}');
    } else {
      STM().errorDialog(ctx, '${result['message']}');
    }
  }


  // validation funtion
  _validateForm(ctx) async {
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
    if (divisionValue == null) {
      setState(() {
        error4 = "This filed is required";
      });
      _isValid = false;
    }
    if (_isValid) {
      getReport();
    }
  }

}
