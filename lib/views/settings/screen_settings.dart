// ignore_for_file: file_names

import 'package:animations/animations.dart';
import 'package:chordsic/dialogs/policy_dialog.dart';
import 'package:chordsic/views/settings/widgets/fact_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        title: Text(
          'Settings',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      //<<<<<Settings_List>>>>>//
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: ListView(
          children: [
            //<<<<<Share>>>>>//
            InkWell(
              onTap: () async {
                await Share.share('Share this text');
              },
              child: const SettingsData(
                settext: "  Share",
                seticon: Icons.share_outlined,
              ),
            ),
            const SizedBox(height: 10),

            //<<<<<Privacy_Policy>>>>>//
            InkWell(
              onTap: () {
                showModal(
                  context: context,
                  configuration: const FadeScaleTransitionConfiguration(),
                  builder: (context) {
                    return PrivacyDialog(
                      mdFileName: 'Privacy_Policy.md',
                    );
                  },
                );
              },
              child: const SettingsData(
                settext: "  Privacy Policy",
                seticon: Icons.privacy_tip_outlined,
              ),
            ),
            const SizedBox(height: 10),

            //<<<<<T_&_C>>>>>//
            InkWell(
              onTap: () {
                showModal(
                  context: context,
                  configuration: const FadeScaleTransitionConfiguration(),
                  builder: (context) {
                    return PrivacyDialog(
                      mdFileName: 'Terms_and_Conditions.md',
                    );
                  },
                );
              },
              child: const SettingsData(
                settext: "  Terms and Conditions",
                seticon: Icons.event_note_outlined,
              ),
            ),
            const SizedBox(height: 10),

            //<<<<<Feedback>>>>>//
            const SettingsData(
              settext: "  Feedback",
              seticon: Icons.feedback_outlined,
            ),
            const SizedBox(height: 10),

            //<<<<<About>>>>>//
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutData(),
                  ),
                );
              },
              child: const SettingsData(
                settext: "  About",
                seticon: Icons.info_outline,
              ),
            ),

            //<<<<<Version>>>>>//
            Padding(
              padding: const EdgeInsets.only(top: 460),
              child: Column(
                children: const [
                  Text(
                    'Version',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: "Montserrat Alter3",
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '1.3.2',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Montserrat Alter3",
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//<<<<<About>>>>>//
class AboutData extends StatelessWidget {
  const AboutData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primaryColorDark: const Color.fromARGB(255, 221, 255, 252),
          cardColor: const Color.fromARGB(255, 221, 255, 252),
          backgroundColor: const Color.fromARGB(255, 221, 255, 252),
          accentColor: const Color.fromARGB(255, 221, 255, 252),
        ),
      ),
      child: LicensePage(
        //applicationName: 'ChoordSIC',
        applicationVersion: '1.3.2',
        applicationIcon: Image.asset('assets/images/Chordsic_Logo.png',
            width: 200, height: 200
            //applicationIcon: ,
            ),
            applicationLegalese: "Developed By RINCE BOBY",
      ),
    );
  }
}
