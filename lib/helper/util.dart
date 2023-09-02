import 'package:flutter/material.dart';

Widget vSize(double size1) {
  return SizedBox(height: size1);
}

Widget verticalDivider({double? height}) => Container(
      height: height ?? 30,
      width: 3,
      color: Color.fromARGB(255, 112, 109, 108),
    );

Widget columnConatiner(BuildContext context,
        {required String title, required String value}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: Color.fromARGB(255, 91, 72, 177),
            ),
            Text(title)
          ],
        ),
        Text(value, textAlign: TextAlign.center),
      ],
    );
