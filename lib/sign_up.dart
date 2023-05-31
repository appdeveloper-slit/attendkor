import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'manage/static_method.dart';
import 'otp.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/strings.dart';
import 'values/styles.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  late BuildContext ctx;

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

  String GenderValue = 'Select Gender';
  List<String> genderList = ['Select Gender', 'Male', 'Female'];
  String t = "0";

  String StateValue = 'Select State';
  List<String> stateList = ['Select State', 'State 1', 'State 2'];
  String v = "0";

  String CityValue = 'Select City';
  List<String> cityList = ['Select City', 'City 1', 'City 2'];
  String p = "0";

  String? sToken;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Clr().white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/sign_up.png'),
              Lottie.asset('animations/signup.json',

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
                        'Sign Up',
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
                        'Hello! Register to get started',
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
                        child: TextFormField(
                            cursorColor: Clr().textcolor,
                            keyboardType: TextInputType.name,
                            decoration:
                                Sty().TextFormFieldOutlineStyle.copyWith(
                                    hintText: 'Enter Name',
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
                            cursorColor: Clr().textcolor,
                            keyboardType: TextInputType.number,
                            decoration:
                                Sty().TextFormFieldOutlineStyle.copyWith(
                                    hintText: 'Enter Mobile Number',
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
                            cursorColor: Clr().textcolor,
                            keyboardType: TextInputType.emailAddress,
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
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Clr().textcolor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: GenderValue,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              style: TextStyle(color: Color(0xff787882)),
                              items: genderList.map((String string) {
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
                                  GenderValue = t!;
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
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Clr().textcolor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: StateValue,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              style: TextStyle(color: Color(0xff787882)),
                              items: stateList.map((String string) {
                                return DropdownMenuItem<String>(
                                  value: string,
                                  child: Text(
                                    string,
                                    style: TextStyle(
                                        color: Clr().textcolor, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (v) {
                                // STM().redirect2page(ctx, Home());
                                setState(() {
                                  StateValue = v!;
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
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Clr().textcolor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: CityValue,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              style: TextStyle(color: Color(0xff787882)),
                              items: cityList.map((String string) {
                                return DropdownMenuItem<String>(
                                  value: string,
                                  child: Text(
                                    string,
                                    style: TextStyle(
                                        color: Clr().textcolor, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (p) {
                                // STM().redirect2page(ctx, Home());
                                setState(() {
                                  CityValue = p!;
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
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Clr().textcolor)),
                          child: TextFormField(
                              controller: dobCtrl,
                              onTap: () {
                                datePicker();
                              },
                              readOnly: true,
                              decoration:
                                  Sty().TextFormFieldOutlineStyle.copyWith(
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(Dim().d12),
                                        child: SvgPicture.asset(
                                            'assets/calender.svg'),
                                      ),
                                      hintText: 'Select Date of Birth',
                                      hintStyle: Sty().mediumText.copyWith(
                                            color: Clr().textcolor,
                                            fontSize: 14,
                                          ))),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
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
                                hintText: 'Enter Password',
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
                            if (value!.isEmpty ||
                                !RegExp(r'(.{6,})').hasMatch(value)) {
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
                            if (value!.isEmpty ||
                                !RegExp(r'(.{6,})').hasMatch(value)) {
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
                      SizedBox(
                        height: Dim().d16,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              // permissionHandle();
                              STM().redirect2page(ctx, OTP(sUsertype: '',));
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
                              'Send OTP',
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
                      InkWell(
                        onTap: () {
                          STM().redirect2page(ctx, SignIn());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already Registered ? ",
                            style: Sty().smallText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Clr().textcolor,
                                fontFamily: ''),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign In Now',
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

//Api Method
// void sendOTP() async {
//   //Input
//   FormData body = FormData.fromMap({
//     'page_type': 'login',
//     'mobile': mobileCtrl.text,
//   });
//   //Output
//       var result = await STM().postWithToken(ctx, Str().sendingOtp, "send_otp", body, sToken);
//       print(sToken);
//   // if (!mounted) return;
//   var message = result['message'];
//   var success = result['success'];
//   if (success) {
//     STM().redirect2page(
//         ctx,
//         OTP(
//           smobileCtrl: mobileCtrl.text,
//           snameCtrl: '',
//           semailCtrl: '',
//           sType: 'login',
//         ));
//     STM().displayToast(message);
//   } else {
//     var message = result['message'];
//     STM().errorDialog(ctx, message);
//   }
// }
}
