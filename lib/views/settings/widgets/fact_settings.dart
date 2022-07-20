import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsData extends StatelessWidget {
  //final setbullets;
  final settext;
  final seticon;

  const SettingsData({
    Key? key,
    required this.settext,
    //required this.setbullets,
    required this.seticon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Icon(
            Icons.circle_rounded,
            size: 8,
            color: Colors.black,
          ),
        ),
        Text(
          settext,
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            seticon,
            color: Colors.black,
            size: 30,
          ),
        ),
      ],
    );
  }
}
