import 'package:attend_kor_teacher/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manage/static_method.dart';
import 'otp2.dart';
import 'reset_password1.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with TickerProviderStateMixin {
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl = TextEditingController();

  String? SelectedValue;
  List<String> selectedList = ['Teacher', 'Student'];
  String t = "0";
  String? userToken;

  //Animation fade in
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2, milliseconds: 30),
      vsync: this,
    );

    animation = Tween(begin: 4.0, end: 2.5).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Lottie.asset('animations/resetpass.json',
                  // width: MediaQuery.of(ctx).size.width,
                  height: 320,
                  reverse: false,
                  repeat: false,
                  fit: BoxFit.fill),
              SizedBox(
                height: Dim().d20,
              ),
              FadeTransition(
                opacity:
                    animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Reset Password',
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
                        'Select user type to reset password (1/2)',
                        textAlign: TextAlign.center,
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
                              value: SelectedValue,
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
                              onChanged: (t) {
                                // STM().redirect2page(ctx, Home());
                                setState(() {
                                  SelectedValue = t!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mobile Number is required';
                              }
                              if (value.length != 10) {
                                return 'Mobile Number must be 10 digits';
                              }
                            },
                            maxLength: 10,
                            controller: mobileCtrl,
                            cursorColor: Clr().textcolor,
                            keyboardType: TextInputType.number,
                            decoration:
                                Sty().TextFormFieldOutlineStyle.copyWith(
                                    hintText: 'Registered Mobile Number',
                                    hintStyle: Sty().mediumText.copyWith(
                                          color: Clr().hintColor,
                                          fontSize: 14,
                                        ))),
                      ),
                      SizedBox(
                        height: Dim().d32,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                resetPassOtp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Clr().textcolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                // fontFamily: 'Merriweather',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            )),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('assets/end.svg')),
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

  // reset password send otp
  void resetPassOtp() async {
    FormData body = FormData.fromMap({
      'mobile': mobileCtrl.text,
      'type': SelectedValue == 'Teacher' ? 'teacher' : 'student',
    });
    var result =
        await STM().post(ctx, Str().sendingOtp, 'reset_password_otp', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
      STM().redirect2page(ctx, OTP2(sUsertype: SelectedValue!,mobilenum: mobileCtrl.text,));
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
