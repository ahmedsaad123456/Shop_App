import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';

//==========================================================================================================================================================

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

//==========================================================================================================================================================

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required final String? label,
  required String? Function(String?)? validate,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  Function()? onTap,
  Function(String)? onSubmit,
  var onChange,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

//==========================================================================================================================================================

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
//==========================================================================================================================================================
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
//==========================================================================================================================================================

Widget buildBoardingItem(BoardingModel boarding) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(boarding.image),
        )),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          boarding.title,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          boarding.body,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );

//================================================================================================================================

Widget defaultTextButton({required VoidCallback fun, required String text}) {
  return TextButton(onPressed: fun, child: Text(text));
}

//================================================================================================================================



Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

//================================================================================================================================

Future<bool?> messageScreen({
  required String? message,
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int time = 5,
  required ToastStates state,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}){
  return Fluttertoast.showToast(
        msg: message?? "Error",
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: time,
        backgroundColor: chooseToastColor(state),
        textColor: textColor,
        fontSize: fontSize,
    );
}


//================================================================================================================================



enum ToastStates{SUCCESS, ERROR , WARNING}

//================================================================================================================================

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
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

//================================================================================================================================
