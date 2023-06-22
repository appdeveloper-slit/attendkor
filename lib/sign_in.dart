import 'package:attend_kor_teacher/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'manage/static_method.dart';
import 'otp.dart';
import 'reset_password.dart';
import 'sign_up.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  late BuildContext ctx;
  final stype = 'stu';
  String? sUsertype, usererror;
  List<String> selectedList = ['Teacher', 'Student'];
  String t = "0";
  bool? loading;
  String? sToken;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  //Animation Fade In
  late Animation animation;
  late AnimationController animationController;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2, milliseconds: 30),
      vsync: this,
    );
    // sUsertype = sUsertype;
    animation = Tween(begin: 4.0, end: 2.5).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Clr().white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/sign_in.png'),
              Lottie.asset('animations/signinfinal.json',
                  // width: MediaQuery.of(ctx).size.width,
                  height: 320,
                  reverse: false,
                  repeat: false,
                  fit: BoxFit.fill),
              SizedBox(
                height: Dim().d8,
              ),
              FadeTransition(
                opacity:
                    animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Sign In',
                        style: Sty().largeText.copyWith(
                              fontFamily: 'roboto',
                              color: Clr().primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d8,
                      ),
                      Text(
                        'Welcome back! Glad to see you again!',
                        style: Sty().mediumText.copyWith(
                              fontFamily: 'roboto',
                              color: Clr().textcolor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Clr().textcolor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: sUsertype,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              hint: Text('Select User Type',
                                  style: Sty()
                                      .mediumText
                                      .copyWith(color: Clr().hintColor)),
                              style: TextStyle(color: Color(0xff787882)),
                              items: selectedList.map((String string) {
                                return DropdownMenuItem<String>(
                                  value: string,
                                  child: Text(
                                    string,
                                    style: TextStyle(
                                        color: Clr().textcolor, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (t) async {
                                setState(() {
                                  sUsertype = t!;
                                  usererror = null;
                                });
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                sp.setString('usertype_id', stype.toString());
                              },
                            ),
                          ),
                        ),
                      ),
                      usererror == null
                          ? SizedBox.shrink()
                          : Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Dim().d32,vertical: Dim().d8),
                            child: Align(
                        alignment: Alignment.topLeft,
                              child: Text('${usererror}',
                                  textAlign: TextAlign.start,
                                  style: Sty()
                                      .smallText
                                      .copyWith(color: Clr().errorRed)),
                            ),
                          ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email address is required';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            decoration:
                                Sty().TextFormFieldOutlineStyle.copyWith(
                                    hintText: 'Enter Email Address',
                                    hintStyle: Sty().mediumText.copyWith(
                                          color: Clr().hintColor,
                                          fontSize: 14,
                                        ))),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                            controller: passCtrl,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                            },
                            decoration:
                                Sty().TextFormFieldOutlineStyle.copyWith(
                                    hintText: 'Enter Password',
                                    hintStyle: Sty().mediumText.copyWith(
                                          color: Clr().hintColor,
                                          fontSize: 14,
                                        ))),
                      ),
                      SizedBox(
                        height: Dim().d8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: InkWell(
                          onTap: () {
                            STM().redirect2page(ctx, ResetPassword());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: Sty().microText.copyWith(
                                    fontFamily: 'roboto',
                                    color: Clr().accentColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (){
                                _validateForm(ctx);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Clr().textcolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              'Sign in',
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
                      sUsertype == 'Teacher'
                          ? Container()
                          : InkWell(
                              onTap: () {
                                STM().redirect2page(ctx, SignUp());
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Don’t have a Student account? ",
                                  style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Clr().textcolor,
                                      fontFamily: ''),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Register Now',
                                      style: Sty().mediumText.copyWith(
                                          color: Clr().accentColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          fontFamily: ''),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('assets/end.svg'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateForm(ctx) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isValid = formKey.currentState!.validate();
    if (sUsertype == null) {
      setState(() => usererror = "User Type is required");
      isValid = false;
    }
    if (isValid) {
      verifyTeacher(sUsertype == 'Student' ? 'student' : 'teacher');
    }
  }

// Api Method
  void verifyTeacher(type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap(
        {'email': emailCtrl.text, 'password': passCtrl.text, 'type': type});
    //Output
    var result = await STM().post(ctx, Str().verifying, "login", body, '');
    var message = result['message'];
    var success = result['success'];
    if (success) {
      setState(() {
        loading = false;
        STM().displayToast(message);
        result['teacher_token'] == null
            ? sp.setString('studenttoken', result['student_token'].toString())
            : sp.setString('teacherToken', result['teacher_token'].toString());
        sp.setBool('is_login', true);
        STM().finishAffinity(ctx, Home());
      });
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
