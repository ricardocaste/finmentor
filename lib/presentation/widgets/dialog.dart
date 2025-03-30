import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogHelper {
  static void showDeleteDialog(BuildContext context, String title, String middleText, Function onConfirm) {

    Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: middleText,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          } ,
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}