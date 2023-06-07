import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  String? GenderValue, cityerror, stateerror, gendererror;

  List<Map<String, dynamic>> genderList = [
    {'id': '1', 'type': 'Male'},
    {'id': '2', 'type': 'Female'},
    {'id': '3', 'type': 'Other'},
  ];

  int? StateValue;
  List<Map<String, dynamic>> stateList = [
    {
      "id": 1,
      "name": "Andaman Nicobar",
      "created_at": "2023-04-22T12:03:16.000000Z",
      "updated_at": "2023-04-22T12:03:16.000000Z",
      "city": [
        {"id": 1, "name": "Nicobar", "state_id": 1},
        {"id": 2, "name": "North Middle Andaman", "state_id": 1},
        {"id": 3, "name": "South Andaman", "state_id": 1}
      ]
    },
    {
      "id": 2,
      "name": "Andhra Pradesh",
      "created_at": "2023-04-22T12:03:16.000000Z",
      "updated_at": "2023-04-22T12:03:16.000000Z",
      "city": [
        {"id": 4, "name": "Anantapur", "state_id": 2},
        {"id": 5, "name": "Chittoor", "state_id": 2},
        {"id": 6, "name": "East Godavari", "state_id": 2},
        {"id": 7, "name": "Guntur", "state_id": 2},
        {"id": 8, "name": "Kadapa", "state_id": 2},
        {"id": 9, "name": "Krishna", "state_id": 2},
        {"id": 10, "name": "Kurnool", "state_id": 2},
        {"id": 11, "name": "Nellore", "state_id": 2},
        {"id": 12, "name": "Prakasam", "state_id": 2},
        {"id": 13, "name": "Srikakulam", "state_id": 2},
        {"id": 14, "name": "Visakhapatnam", "state_id": 2},
        {"id": 15, "name": "Vizianagaram", "state_id": 2},
        {"id": 16, "name": "West Godavari", "state_id": 2}
      ]
    },
  ];

  int? CityValue;
  List<Map<String,dynamic>> cityList = [];

  String? sToken;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: Sty().largeText.copyWith(
                                fontFamily: 'roboto',
                                color: Clr().primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d8,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Hello! Register to get started',
                          style: Sty().mediumText.copyWith(
                                fontFamily: 'roboto',
                                color: Clr().textcolor,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                            controller: nameCtrl,
                            cursorColor: Clr().textcolor,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is required';
                              }
                            },
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
                            controller: mobileCtrl,
                            cursorColor: Clr().textcolor,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mobile is required';
                              }
                              if (value.length != 10) {
                                return 'Mobile number digits must be 10';
                              }
                              return null;
                            },
                            decoration:
                                Sty().TextFormFieldOutlineStyle.copyWith(
                                  counterText: '',
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
                            controller: emailCtrl,
                            cursorColor: Clr().textcolor,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Id is required';
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
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Clr().textcolor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: GenderValue,
                              isExpanded: true,
                              hint: Text('Enter the gender'),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              style: TextStyle(color: Color(0xff787882)),
                              items: genderList.map((string) {
                                return DropdownMenuItem(
                                  value: string['id'],
                                  child: Text(
                                    string['type'].toString(),
                                    style: TextStyle(
                                        color: Clr().textcolor, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (t) {
                                setState(() {
                                  GenderValue = t.toString();
                                  gendererror = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      gendererror == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: Dim().d32, top: Dim().d12),
                              child: Text('${gendererror}',
                                  style: Sty()
                                      .smallText
                                      .copyWith(color: Clr().errorRed)),
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
                            child: DropdownButton(
                              value: StateValue,
                              isExpanded: true,
                              hint: Text('Enter the state'),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              style: TextStyle(color: Color(0xff787882)),
                              items: stateList.map((string) {
                                return DropdownMenuItem(
                                  value: string['id'],
                                  child: Text(
                                    string['name'].toString(),
                                    style: TextStyle(
                                        color: Clr().textcolor, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (v) {
                                // STM().redirect2page(ctx, Home());
                                setState(() {
                                  StateValue = v as int?;
                                  stateerror = null;
                                  int position = stateList.indexWhere((e) => e['id'] == StateValue);
                                  cityList = stateList[position]['city'];
                                  CityValue = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      stateerror == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: Dim().d32, top: Dim().d12),
                              child: Text('${stateerror}',
                                  style: Sty()
                                      .smallText
                                      .copyWith(color: Clr().errorRed)),
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
                            child: DropdownButton(
                              value: CityValue,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().textcolor,
                              ),
                              hint: Text('Enter the city'),
                              style: TextStyle(color: Color(0xff787882)),
                              items: cityList.map((string) {
                                return DropdownMenuItem(
                                  value: string['id'],
                                  child: Text(
                                    string['name'].toString(),
                                    style: TextStyle(
                                        color: Clr().textcolor, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (p) {
                                // STM().redirect2page(ctx, Home());
                                setState(() {
                                  CityValue = p as int?;
                                  cityerror = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      cityerror == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: Dim().d32, top: Dim().d12),
                              child: Text('${cityerror}',
                                  style: Sty()
                                      .smallText
                                      .copyWith(color: Clr().errorRed)),
                            ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                        child: TextFormField(
                            controller: dobCtrl,
                            onTap: () {
                              datePicker();
                            },
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Date of birth is required';
                              }
                            },
                            decoration: Sty()
                                .TextFormFieldOutlineStyle
                                .copyWith(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.all(Dim().d12),
                                      child: SvgPicture.asset(
                                          'assets/calender.svg'),
                                    ),
                                    hintText: dobCtrl.text.isEmpty
                                        ? 'Select Date of Birth'
                                        : '${dobCtrl.text}',
                                    hintStyle: Sty().mediumText.copyWith(
                                          color: Clr().textcolor,
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
                            if (value!.isEmpty) {
                              return 'Please type confirm password';
                            }
                            if (value != passwordCtrl.text) {
                              return 'confirm Password must be same as new password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                _validateForm(ctx);
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
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
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

  // validation funtion
  _validateForm(ctx) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool _isValid = formKey.currentState!.validate();

    if (GenderValue == null) {
      setState(() => gendererror = "Gender is required");
      _isValid = false;
    }
    if (StateValue == null) {
      setState(() {
        stateerror = "State is required";
      });
      _isValid = false;
    }
    if (CityValue == null) {
      setState(() {
        cityerror = "City is required";
      });
      _isValid = false;
    }
    if (_isValid) {
      STM().redirect2page(
          ctx,
          OTP(
            value: {
              'name': nameCtrl.text,
              'mobile': mobileCtrl.text,
              'email': emailCtrl.text,
              'gender': GenderValue,
              'state': StateValue,
              'city': CityValue,
              'birthdate': dobCtrl.text,
              'password': passwordCtrl.text,
              'confirmpassword': confirmpasswordCtrl.text,
            },
            type: 'register',
          ));
    }
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
