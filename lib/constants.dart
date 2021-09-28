import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var inputDecoration = InputDecoration(
  hintText: 'Add a value',
  hintStyle: const TextStyle(
    fontFamily: 'Poppins',
    color: Color(0xFF303030),
    fontSize: 14,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
);

var kSubmitButton=Row(
  children: const [
    Expanded(
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 20),
      child: Icon(
        Icons.post_add,
        color: Colors.black,
        size: 24,
      ),
    )
  ],
);

var kWeightEntriesStyle=const TextStyle(
  fontFamily: 'Poppins',
  color: Colors.white,
  fontSize: 18,
);

var kTextStyle=const TextStyle(
    fontFamily: 'Poppins',
    color: Color(0xFF303030),
    fontSize: 14,
    fontWeight: FontWeight.w600
);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(BuildContext context,String message)
{
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(message,
          style: const TextStyle(
              fontSize:17
          ),
        ),
        action: SnackBarAction(onPressed: () {}, label: 'Close',
          textColor: Colors.yellow,
        ),
        duration: const Duration(seconds: 7)
    ),
  );
}

Future<bool?> alertBox(BuildContext context,dynamic error)
{
  return Alert(
    context: context,
    type: AlertType.error,
    title: "Process Status",
    desc: error.toString(),
    buttons: [
      DialogButton(
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}