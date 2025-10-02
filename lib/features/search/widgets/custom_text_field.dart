import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.maxLines,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.onSubmitted,
    this.textInputAction,
  });
  final String? hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final IconData? suffixIcon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        // validator:
        //     validator ??
        //     (text) {
        //       if (text!.isEmpty && text.length < 3) {
        //         return 'This field is required';
        //       }
        //       return null;
        //     },
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyboardType,
        controller: controller,
        // maxLines: maxLines,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 10.w,
          ),
          hintStyle: TextStyle(fontSize: 18.sp, color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
