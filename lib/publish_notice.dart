import 'dart:convert';
import 'dart:io';

import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:attend_kor_teacher/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class PublishNotice extends StatefulWidget {
  @override
  State<PublishNotice> createState() => _PublishNoticeState();
}

class _PublishNoticeState extends State<PublishNotice> {
  late BuildContext ctx;
  TextEditingController noticeCtrl = TextEditingController();
  File? imageFile;
  var profile;
  String? TeacherToken;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
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
    return WillPopScope(
      onWillPop: () async {
        STM().back2Previous(ctx);
        return false;
      },
      child: Scaffold(
        backgroundColor: Clr().white,
        resizeToAvoidBottomInset: false,
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
            'Publish Notice',
            style: Sty()
                .largeText
                .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Column(
            children: [
              SizedBox(height: Dim().d12),
              InkWell(
                  onTap: () {
                    STM().canceldialog(
                        context: ctx,
                        message: 'Are you sure want to cancel?',
                        funtion: () {
                          setState(() {
                            imageFile = null;
                            noticeCtrl.clear();
                            STM().back2Previous(ctx);
                          });
                        });
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close))),
              SizedBox(
                height: Dim().d20,
              ),
              imageFile == null
                  ? Container()
                  : SizedBox(
                height: Dim().d200,
                width: double.infinity,
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: TextFormField(
                    controller: noticeCtrl,
                    cursorColor: Clr().textcolor,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    decoration: Sty().TextFormFieldOutlineStyle1.copyWith(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'What’s Up ?',
                        hintStyle: Sty().mediumText.copyWith(
                          color: Clr().hintColor,
                          fontSize: 14,
                        ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: InkWell(
                        onTap: () {
                          showModel();
                        },
                        child: SvgPicture.asset('assets/add_image.svg')),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        STM().canceldialog(
                            context: ctx,
                            message: 'Are you sure want to publish?',
                            funtion: () {
                              STM().back2Previous(ctx);
                              publishNotice();
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Clr().textcolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Text(
                        'Publish',
                        style: TextStyle(
                          // fontFamily: 'Merriweather',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
                ],
              ),
              SizedBox(height: Dim().d20),
            ],
          ),
        ),
      ),
    );
  }

  /// shoe model sheet
  showModel() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Clr().background1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dim().d14),
                topRight: Radius.circular(Dim().d14))),
        builder: (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dim().d12, vertical: Dim().d20),
                child: Text('Notice Photo', style: Sty().mediumBoldText),
              ),
              SizedBox(height: Dim().d28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _getProfile(ImageSource.camera, CropStyle.rectangle);
                    },
                    child: SvgPicture.asset('assets/camera.svg'),
                  ),
                  InkWell(
                    onTap: () {
                      _getProfile(ImageSource.gallery, CropStyle.rectangle);
                    },
                    child: SvgPicture.asset('assets/gallery.svg'),
                  ),
                ],
              ),
              SizedBox(height: Dim().d40),
            ],
          );
        });
  }

  /// get profile photo for Teacher
  _getProfile(source, cropstyle) async {
    final pickedFile = await ImagePicker().getImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      CroppedFile? file = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressFormat: ImageCompressFormat.jpg,
          cropStyle: cropstyle);
      setState(() {
        imageFile = File(file!.path.toString());
        STM().back2Previous(ctx);
        var image = imageFile!.readAsBytesSync();
        profile = base64Encode(image);
      });
    }
  }

  /// publish notice
  void publishNotice() async {
    FormData body = FormData.fromMap({
      'notice': noticeCtrl.text,
      'image': profile,
    });
    final result = await STM().postWithToken(
        ctx, Str().processing, 'add_notice', body, TeacherToken, 'teacher/');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().successDialogWithAffinity(ctx, message, Home());
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
