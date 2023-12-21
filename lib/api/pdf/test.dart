import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
Future<Uint8List> generateDocument(
    PdfPageFormat format, double fontSize) async {
  final doc = Document(pageMode: PdfPageMode.outlines);
  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();

  doc.addPage(
    Page(
      pageTheme: PageTheme(
        pageFormat: format.copyWith(
          marginBottom: 10,
          marginLeft: 10,
          marginRight: 10,
          marginTop: 10,
        ),
        orientation: PageOrientation.portrait,
        // buildBackground: (context) => SvgImage(svg: )
        theme: ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
      ),
      build: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Random Person' '\n',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          //color: PdfColors.grey600,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'City, State' '\n',
                        style: TextStyle(
                          //ontWeight: FontWeight.bold,
                          //color: PdfColors.grey600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '+91 XXXXXXXXXX   yourmailid@mailId   linkedin.com/random-person'
                            '\n',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          //color: PdfColors.grey600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'github.com/random-person    codeforces.com/coder   codechef.com/coder   leetcode.com/coder'
                            '\n',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          //color: PdfColors.grey600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              RichText(
                text: TextSpan(
                  text: 'Education' '\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              //Divider()
              Divider(
                indent: 0,
                endIndent: 0,
                height: 3,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Some Random Engineering College' '\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Month Year - Month Year' '\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              RichText(
                text: const TextSpan(
                  text: 'Bachelors in this and that with a CGPA of X.XX' '\n',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Spacer(),

              RichText(
                text: TextSpan(
                  text: 'Technical Skills' '\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Languages: ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'C, C++, Dart, Python',
                            style: TextStyle(
                              //fontWeight: FontWeight,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Technologies: ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'VS code, Jupyter, IntelliJ',
                            style: TextStyle(
                              //fontWeight: FontWeight,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Frameworks: ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'Flutter, React',
                            style: TextStyle(
                              //fontWeight: FontWeight,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Libraries/Backend: ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'Firebase, MongoDB',
                            style: TextStyle(
                              //fontWeight: FontWeight,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Divider()
              Spacer(),

              RichText(
                text: TextSpan(
                  text: 'Experience' '\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Amazon' '\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Month Year - Month Year' '\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Software Development Engineer' '\n',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'City Country' '\n',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  Bullet(
                    bulletSize: 3.5,
                    text:
                        'Created a backend + frontend internal tool to see all the statistics related to the seller with edit functionality, this allowed us to track who made the changes and when.'
                        'Adding this feature saved the manual borrowing time of the SDE over DB to find these things.'
                        'On every task related to this, the SDE was saving on an average 15 minutes',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text:
                        'Wrote multiple APIs for the team which returned the extracted data data from DynamoDB by doing some computations on the basis of business requirement.'
                        'These APIs made the system feature rich',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Google' '\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Month Year - Month Year' '\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Software Development Engineer' '\n',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'City Country' '\n',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  Bullet(
                    bulletSize: 3.5,
                    text:
                        'Created a backend + frontend internal tool to see all the statistics related to the seller with edit functionality, this allowed us to track who made the changes and when.'
                        'Adding this feature saved the manual borrowing time of the SDE over DB to find these things.'
                        'On every task related to this, the SDE was saving on an average 15 minutes',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text:
                        'Wrote multiple APIs for the team which returned the extracted data data from DynamoDB by doing some computations on the basis of business requirement.'
                        'These APIs made the system feature rich',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                ],
              ),
              Spacer(),

              RichText(
                text: TextSpan(
                  text: 'Projects' '\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 3,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Resume Builder Application | ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Flutter, Firebase, MongoDB' '\n',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Bullet(
                    bulletSize: 3.5,
                    text:
                        'Created a android and a web application for making resumes',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Allows cloud Synchronization',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'OCR Text Recognition Application | ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Flutter, Firebase, Sembast' '\n',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Bullet(
                    bulletSize: 3.5,
                    text:
                        'Created a android and a web application for making resumes',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Allows cloud Synchronization',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                ],
              ),
              Spacer(),

              RichText(
                text: TextSpan(
                  text: 'Achievements' '\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 3,
              ),
              Column(
                children: [
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                  Bullet(
                    bulletSize: 3.5,
                    text: 'Won the first prize in this and that',
                    style: const TextStyle(
                      fontSize: 10,
                      lineSpacing: 1,
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        );
      },
    ),
  );
  return await doc.save();
}

