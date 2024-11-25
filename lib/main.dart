import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume PDF App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume PDF'),
      ),
      body: PdfPreview(
        build: (format) => _generateResumePdf(),
      ),
    );
  }

  Future<Uint8List> _generateResumePdf() async {
    final pdf = pw.Document();

    // Load the profile picture (ensure to replace with your image file as bytes).
    final Uint8List profileImage = await _loadProfileImage();

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(20),
          buildBackground: (context) => pw.Container(
            color: PdfColors.grey300,
          ),
        ),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Top Left: Name and Contact Info
              pw.Positioned(
                top: 20,
                left: 20,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Center(
                      child: pw.Text(
                        '             ABHISHEK GODARA',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    _buildSectionHeader('CONTACT'),
                    pw.Text('+91-9664022597'),
                    pw.Text('abhishekgodaranith@gmail.com'),
                    pw.Text('Churu, Rajasthan'),
                  ],
                ),
              ),
              // Top Right: Profile Picture
              pw.Positioned(
                top: 20,
                right: 20,
                child: pw.Container(
                  width: 120,
                  height: 120,
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    image: pw.DecorationImage(
                      image: pw.MemoryImage(profileImage),
                      fit: pw.BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Main Content

              pw.Padding(
                padding: const pw.EdgeInsets.only(
                    top: 150), // Adjusted to leave space at the top
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 15),
                    _drawDivider(),
                    pw.SizedBox(height: 15),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildLeftSection(),
                        pw.SizedBox(width: 20),
                        _buildRightSection(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Helper function to load the profile image (replace with your image file).
  Future<Uint8List> _loadProfileImage() async {
    // Replace with actual image loading logic.
    // You can load it from assets or network.
    return await rootBundle.load('images/rounded_profile_pic.png').then((data) {
      return data.buffer.asUint8List();
    });
  }

  // Left Section (Skills, Links)
  pw.Widget _buildLeftSection() {
    return pw.Container(
      width: 180,
      padding: const pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('SKILLS'),
          _buildBullet('Languages: C, C++, Dart, Javascript, SQL'),
          pw.SizedBox(height: 3),
          _buildBullet('Framework/Technologies: Flutter, Git, MongoDB'),
          pw.SizedBox(height: 3),
          _buildBullet(
              'Developer Tools: VS Code, Firebase, GitHub, Android Studio, MySQL'),
              pw.SizedBox(height: 3),
          _buildBullet('Relevant Coursework: Data Structures, OS, OOP, DBMS'),
          pw.SizedBox(height: 15),
          _drawDivider(),
          pw.SizedBox(height: 15),
          _buildSectionHeader(' LINKS'),
          _buildUrlText('LinkedIn',
              'https://www.linkedin.com/in/abhishek-godara-ab28a725a/'),
              pw.SizedBox(height: 3),
          _buildUrlText('GitHub', 'https://github.com/abhi123nith'),
            pw.SizedBox(height: 3),
          _buildUrlText('LeetCode', 'https://leetcode.com/u/abhigodara/'),
            pw.SizedBox(height: 3),
          _buildUrlText('Codolio', 'https://codolio.com/profile/BNcimQYt'),
            pw.SizedBox(height: 3),
          _buildUrlText('Portfolio', 'https://godaraportfolio.netlify.app/'),
        ],
      ),
    );
  }

  // Right Section (Education, Experience, Projects, Achievements)
  pw.Widget _buildRightSection() {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('EDUCATION'),
          _buildDarkBullet('National Institute Of Technology (NIT), Hamirpur'),
          pw.SizedBox(height: 2),
          pw.Text('   B.Tech - Computer Science and Engineering '),
          pw.SizedBox(height: 1),
          pw.Text(
              '   CGPA: 8.17                          (Nov 2022 - July 2026)'),
          pw.SizedBox(height: 15),
          _drawDivider(),
          pw.SizedBox(height: 10),
          _buildSectionHeader('EXPERIENCE'),
          pw.SizedBox(height: 4),
          _buildDarkBullet('Software Developer Intern'),
          pw.Text('    Wow Codes -(3 Months)'),
          pw.SizedBox(height: 4),
          _buildBullet(
              'Converted 30+ UI/UX designs into responsive Flutter pages, improving app performance and user satisfaction by 30%.'),
          pw.SizedBox(height: 2),
          _buildBullet(
              'Integrated 20+ REST APIs for seamless communication between front-end and back-end.'),
          pw.SizedBox(height: 2),
          _buildBullet(
              'Collaborated with 6 developers, consistently meeting project deadlines.'),
          pw.SizedBox(height: 7),
          _buildDarkBullet('Executive Member'),
          pw.Text('    Robotics Society (Dec 2022 - Jan 2024)'),
          pw.SizedBox(height: 4),
          _buildBullet(
              'Developed a line-following robot; secured 1st place at Exodia, IIT Mandi, and 2nd place at Techkriti, IIT Kanpur.'),
          pw.SizedBox(height: 2),
          _buildBullet(
              'Created an automated bot for fire detection and extinguishing, reducing response time by 80%.'),
          pw.SizedBox(height: 10),
          _drawDivider(),
          pw.SizedBox(height: 7),
          _buildSectionHeader('PROJECTS'),
          pw.SizedBox(height: 5),
          _buildDarkBullet('CampusTracker'),
          pw.SizedBox(height: 2),
          _buildBullet(
              'Developed a responsive app and web application for campus use, reducing lost-and-found issue resolution time by 50%.'),
          pw.SizedBox(height: 2),
          _buildBullet(
              'Integrated secure email-based login with multi-factor authentication.'),
          pw.SizedBox(height: 6),
          _buildDarkBullet('Sampark App'),
          pw.SizedBox(height: 4),
          _buildBullet(
              'Developed a chat app with text, image, video messaging, one-to-one and group video calls, and live streaming.'),
          pw.SizedBox(height: 15),
          _drawDivider(),
          pw.SizedBox(height: 10),
          _buildSectionHeader('ACHIEVEMENTS'),
          pw.SizedBox(height: 7),
          _buildBullet('Rajasthan State Topper in Class 12 with 100% marks'),
          pw.SizedBox(height: 2),
          _buildBullet('Second College Topper on Coding Ninjas platform'),
          pw.SizedBox(height: 2),
          _buildBullet('Solved 500+ DSA problems on LeetCode and Code 360'),
        ],
      ),
    );
  }

  pw.Widget _buildSectionHeader(String text) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 16,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blue800,
      ),
    );
  }

  pw.Widget _buildUrlText(String text, String url) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(
        text,
        style: const pw.TextStyle(
          decoration: pw.TextDecoration.underline,
          color: PdfColors.blue800,
        ),
      ),
    );
  }

  pw.Widget _buildBullet(String text) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 5,
          height: 5,
          margin: const pw.EdgeInsets.only(top: 5, right: 5),
          decoration: const pw.BoxDecoration(
            color: PdfColors.black,
            shape: pw.BoxShape.circle,
          ),
        ),
        pw.Expanded(child: pw.Text(text)),
      ],
    );
  }

  pw.Widget _buildDarkBullet(String text) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 6,
          height: 6,
          margin: const pw.EdgeInsets.only(top: 7, right: 5),
          decoration: const pw.BoxDecoration(
            color: PdfColors.blue800,
            shape: pw.BoxShape.circle,
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            text,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }

  pw.Widget _drawDivider() {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(horizontal: 10),
      height: 1,
      color: PdfColors.black,
    );
  }
}
