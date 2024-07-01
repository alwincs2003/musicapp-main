import 'package:flutter/material.dart';
import 'package:zmusic/core/constants/color_constants/colors.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

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
        centerTitle: true,
        title: Text(
          "Terms And Conditions",
          style: TextStyle(
              fontSize: 20, color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Terms and Conditions for zmusic',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'By Using the Musiapp mobile application ("App"), you agree to comply with and be bound by the following terms and conditions. please read these terms carefully before using the App.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Acceptance of Terms',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'By accessing or using the App, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use the App.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'User Responsibilities',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device. You agree to accept responsibility for all activities that occur under your account or password.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Prohibited Activities',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'You may not engage in any activities that violate the law or the rights of others while using the App. Prohibited activities include, but are not limited to, unauthorized access, data mining, or any action that disrupts the normal functioning of the App.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Intellectual Property',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'The content, features, and functionality of the App are the exclusive property of zmusic. You may not reproduce, distribute, modify, or creat derivative works of any part of the App without our express consent.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Limitation of Liability',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'zmusic and its affiliates shall not be liable for any indirect,incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectily, or any loss of data, use, goodwill, or other intangible losses, resulting from your use of the App.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Governing Law',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'These Terms and Conditions are governed by and construed in accordance with the laws of [Your Country], and you irrevocably submit to the exclusive jurisdiction  of the courts in that state or location.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Changes to Terms',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'We reserve the right, at our sole discrection, to modify or replace these Terms and Conditions at any time. By continuing to access or use the App after those revisions become effective, you agree to be bound by the revised terms.',
              style: TextStyle(fontSize: 10, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 16),
            Text(
              """If you have any questions about this Privacy Policy, You can contact us:

By email: alwincs02@gmail.com """,
              style: TextStyle(fontSize: 10, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
