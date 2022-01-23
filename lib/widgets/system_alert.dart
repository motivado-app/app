import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';

SystemWindowHeader header = SystemWindowHeader(
    title: SystemWindowText(
        text: "Incoming Call", fontSize: 10, textColor: Colors.black45),
    padding: SystemWindowPadding.setSymmetricPadding(12, 12),
    subTitle: SystemWindowText(
        text: "9898989899",
        fontSize: 14,
        fontWeight: FontWeight.BOLD,
        textColor: Colors.black87),
    decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
    button: SystemWindowButton(
        text: SystemWindowText(
            text: "Personal", fontSize: 10, textColor: Colors.black45),
        tag: "personal_btn"),
    buttonPosition: ButtonPosition.TRAILING);

SystemWindowFooter footer = SystemWindowFooter(
    buttons: [
      SystemWindowButton(
        text: SystemWindowText(
            text: "Simple button",
            fontSize: 12,
            textColor: Color.fromRGBO(250, 139, 97, 1)),
        tag: "simple_button", //useful to identify button click event
        padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
        width: 0,
        height: SystemWindowButton.WRAP_CONTENT,
        decoration: SystemWindowDecoration(
            startColor: Colors.white,
            endColor: Colors.white,
            borderWidth: 0,
            borderRadius: 0.0),
      ),
      SystemWindowButton(
        text: SystemWindowText(
            text: "Focus button", fontSize: 12, textColor: Colors.white),
        tag: "focus_button",
        width: 0,
        padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
        height: SystemWindowButton.WRAP_CONTENT,
        decoration: SystemWindowDecoration(
            startColor: Color.fromRGBO(250, 139, 97, 1),
            endColor: Color.fromRGBO(247, 28, 88, 1),
            borderWidth: 0,
            borderRadius: 30.0),
      )
    ],
    padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
    decoration: SystemWindowDecoration(startColor: Colors.white),
    buttonsPosition: ButtonPosition.CENTER);

SystemWindowBody body = SystemWindowBody(
  rows: [
    EachRow(
      columns: [
        EachColumn(
          text: SystemWindowText(
              text: "Some body", fontSize: 12, textColor: Colors.black45),
        ),
      ],
      gravity: ContentGravity.CENTER,
    ),
  ],
  padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
);


      //Using SystemWindowPrefMode.DEFAULT uses Overlay window till Android 10 and bubble in Android 11
      //Using SystemWindowPrefMode.OVERLAY forces overlay window instead of bubble in Android 11.
      //Using SystemWindowPrefMode.BUBBLE forces Bubble instead of overlay window in Android 10 & above