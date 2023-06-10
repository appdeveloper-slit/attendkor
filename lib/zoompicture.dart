import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomingPic extends StatefulWidget {
  final img;
  const ZoomingPic({Key? key,this.img}) : super(key: key);

  @override
  State<ZoomingPic> createState() => _ZoomingPicState();
}

class _ZoomingPicState extends State<ZoomingPic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Dim().d340,width: double.infinity,child: PhotoView(imageProvider: NetworkImage(widget.img))),
        ],
      ),
    );
  }
}
