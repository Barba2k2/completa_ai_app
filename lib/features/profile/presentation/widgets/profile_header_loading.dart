import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeaderLoading extends StatelessWidget {
  const ProfileHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 36.r,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
                width: 120.w,
                color: Colors.grey[300],
              ),
              SizedBox(height: 8.h),
              Container(
                height: 14.h,
                width: 180.w,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
