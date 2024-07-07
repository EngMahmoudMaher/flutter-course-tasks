import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ContactUsApp());
}

class ContactUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactUsScreen(),
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  final String designerImage = 'assets/designer.svg'; // Replace with your designer's image file path
  final String facebookUrl = 'https://www.facebook.com'; // Replace with your Facebook profile URL
  final String whatsappNumber = '+1234567890'; // Replace with your WhatsApp number
  final String linkedinUrl = 'https://www.linkedin.com'; // Replace with your LinkedIn profile URL

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              designerImage,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 24),
            Text(
              'Contact the Designer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () {
                    _launchURL(facebookUrl);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    _launchURL('https://wa.me/$whatsappNumber');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () {
                    _launchURL(linkedinUrl);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
