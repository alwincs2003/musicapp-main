import 'package:flutter/material.dart';
import 'package:musicapp/core/constants/color_constants/colors.dart';
import 'package:musicapp/presentation/setting_screen/view/privacy_policy_screen.dart';
import 'package:musicapp/presentation/setting_screen/view/terms_and_condition_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
        ),
        centerTitle: false,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20, color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Version",
            //   style: TextStyle(fontSize: 20, color: textColor),
            // ),
            // Text(
            //   "version: 1.0.0+1",
            //   style: TextStyle(fontSize: 15, color: Colors.grey),
            // ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                );
              },
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionScreen(),
                  ),
                );
              },
              child: Text(
                "Terms and Conditions",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
