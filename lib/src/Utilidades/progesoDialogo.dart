import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MyDialogoProgreso {
  static ProgressDialog createProgressDailog(
      BuildContext context, String text) {
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

// pegamos el codigo...
// el lemensaje le paso el text del parametro
// eliminamos  o om,netamos la prpiedad  textDirection: TextDirection.rtl,

    progressDialog.style(
        message: text,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        // textDirection: TextDirection.rtl,
        maxProgress: 70.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));

    return progressDialog;
  }
}
