import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onFieldSubmitted,
  Function(String)? onChange,
  //required Function onTap,
  required Function validate,
  required String Label,
  required IconData prefix,
  bool isClickable = true, IconData? suffix, bool? isPassword, Null Function()? suffixPressed,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      //onTap:  ()
      // {
      //  onTap();
      //},
      validator: (String? value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: Label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget defaultTextButton({
  required VoidCallback? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback? onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
}
) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  title: Text(title!),
  titleSpacing: 0.0,
  actions: actions,
);