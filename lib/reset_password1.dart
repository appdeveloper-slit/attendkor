import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'manage/static_method.dart';
import 'sign_in.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class ResetPassword1 extends StatefulWidget {
  final String? mobilenum;
  const ResetPassword1({super.key, this.mobilenum});
  @override
  State<ResetPassword1> createState() => _ResetPassword1State();
}

class _ResetPassword1State extends State<ResetPassword1> with TickerProviderStateMixin {
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmpasswordCtrl = TextEditingController();

  bool isHidden = true;
  bool isHidden2 = true;

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

    return  Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Image.asset('assets/otp.png'),
              Lottie.asset('animations/resetpass.json',
                  // width: MediaQuery.of(ctx).size.width,
                  height: 320,
                  reverse: false,
                  repeat: false,
                  fit: BoxFit.fill),
              SizedBox(height: Dim().d20,),
              FadeTransition(
                opacity: animationController
                    .drive(CurveTween(curve: Curves.easeIn)),
                child: Container(
                  child: Column(
                    children: [
                      Text('Reset Password',
                        style: Sty().largeText.copyWith(
                          fontFamily: 'roboto',
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),),
                      SizedBox(height: Dim().d8,),
                      Text('Enter a new password to get logged in (2/2)',
                        textAlign: TextAlign.center,
                        style: Sty().mediumText.copyWith(
                          fontFamily: 'roboto',
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w400,

                        ),),
                      SizedBox(height: Dim().d20,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                          cursorColor: Clr().textcolor,
                          controller: passwordCtrl,
                          style: Sty().mediumText.copyWith(
                            color: Clr().textcolor,
                          ),
                          // textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isHidden,
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ),
                            hintText: 'New Password',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: InkWell(
                                child: Icon(
                                  isHidden
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Clr().textcolor,
                                ),
                                onTap: () {
                                  setState(() {
                                    isHidden ^= true;
                                  });
                                },
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'(.{6,})').hasMatch(value)) {
                              return Str().invalidPassword;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                          controller: confirmpasswordCtrl,
                          cursorColor: Clr().textcolor,
                          style: Sty().mediumText.copyWith(
                            color: Clr().textcolor,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isHidden2,
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().hintColor,
                              fontSize: 14,
                            ),
                            hintText: 'Confirm Password',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: InkWell(
                                child: Icon(
                                  isHidden2
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Clr().textcolor,
                                ),
                                onTap: () {
                                  setState(() {
                                    isHidden2 ^= true;
                                  });
                                },
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm password is required';
                            }
                            if(passwordCtrl.text != confirmpasswordCtrl.text){
                              return 'Confirm password must be same as new password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Dim().d32,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                UpdatePassword();
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
                      Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('assets/end.svg')
                      ),
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

  // update password
 void UpdatePassword() async {
    FormData body = FormData.fromMap({
      'mobile': widget.mobilenum,
      'password': passwordCtrl.text,
      'password_confirmation': confirmpasswordCtrl.text,
    });
    var result = await STM().post(ctx, Str().updating, 'update_password', body,'');
    var success = result['success'];
    var message = result['message'];
    if(success) {
      STM().displayToast(message);
      STM().finishAffinity(ctx, SignIn());
    }else{
      STM().errorDialog(ctx, message);
    }
 }
}