import 'package:flutter/material.dart';
import 'package:todoapp/core/constant/AppColors.dart';
import 'package:todoapp/core/Helper/AppHelper.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.width,
    this.color,
  }) : super(key: key);
  final void Function()? onPressed;
  final double? width;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: color ?? Theme.of(context).primaryColor)),
      height: 50,
      padding: const EdgeInsets.all(0),
      minWidth: width ?? AppHelper.getDeviceWidth(context) / 3.5,
      color: color ?? Theme.of(context).primaryColor,
      disabledColor: AppColors.lightGrey,
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
