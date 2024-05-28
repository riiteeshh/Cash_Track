import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget verticalSpace(int height) {
  return SizedBox(
    height: height.h,
  );
}

Widget horizontalSpace(int width) {
  return SizedBox(
    width: width.w,
  );
}
