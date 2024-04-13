import 'package:first_project/shared/network/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultButton({
  double width= double.infinity,
  Color background= Colors.blue,
  bool isUpperCase = true,
  required Function() onpressed,
  //required void Function()? function,

  required String text,}) => Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(isUpperCase ? text.toUpperCase() : text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      ),
    );
//----------------------------------------------------------------------------
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function(String)? onSubmit,
  Function()? ontap,
  Function(String)? onchange,
  //required Function() validate,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  validator: validate,
  onChanged: onchange,
  onTap : ontap,
  decoration: InputDecoration(
    labelText: label,
    //labelStyle: TextStyle(color: Colors.blue),
    prefixIcon: Icon(
      prefix,color: Colors.blue,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,//color: Colors.blue,
      ),
    ) : null,
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(borderSide :BorderSide(color: Colors.blue), )


  ),
);
//-------------------------------------------------------------------------------

void ShowToast({required String mesg ,required Color color }) => Fluttertoast.showToast(
msg: mesg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: color,
textColor: Colors.white,
fontSize: 16.0
);
//------------------------------------------------------------------------------
Widget Divider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
//-------------------------------------------------------------------------
