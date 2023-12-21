import 'dart:typed_data';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:resumex/providers/infos_model_provider.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

Future<Uint8List> generateDocument2(
  PdfPageFormat format,
  List<double> fontSize,
  Resume resume,
  double? marginLR,
  double? marginTB,
  double? textScale,
  double? gap,
  InfosModel model,
) async {
  final doc = Document(
    pageMode: PdfPageMode.outlines,
  );
  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();
  final font3 = await PdfGoogleFonts.openSansItalic();
  // int fontSize = 12;

  List<Widget> workText = [];
  for (var i = 0; i < resume.workExperiences!.length; i++) {
    workText.add(transform(resume.workExperiences![i].getWork(), fontSize[1]));
  }

  List<Widget> projectText = [];
  for (var i = 0; i < resume.projects!.length; i++) {
    projectText.add(transform(resume.projects![i].getDesc(), fontSize[1]));
  }
  doc.addPage(
    MultiPage(
      pageTheme: PageTheme(
        pageFormat: format.copyWith(
          marginBottom: marginTB ?? 20,
          marginLeft: marginLR ?? 40,
          marginRight: marginLR ?? 40,
          marginTop: marginTB ?? 20,
        ),
        orientation: PageOrientation.portrait,
        theme: ThemeData.withFont(
          base: font1,
          bold: font2,
          italic: font3,
        ),
      ),
      build: (Context context) => [
        Flex(
          direction: Axis.vertical,
          children: [
            if (model.infosAvail[0])
              resume.contact != null
                  ? Partition(
                      child: Column(
                        children: [
                          Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${resume.contact != null ? resume.contact!.name : ''}'
                                        '\n',
                                    style: TextStyle(
                                      fontSize: fontSize[3],
                                      font: font1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text:
                                  '${resume.contact != null ? resume.contact!.email : ''} | '
                                  '${resume.contact != null ? resume.contact!.phoneNumber : ''} | '
                                  '${resume.contact != null ? resume.contact!.city ?? '' : ''} '
                                  '${resume.contact != null ? resume.contact!.province ?? '' : ''} '
                                  '${resume.contact != null ? resume.contact!.country ?? '' : ''} '
                                  '\n',
                              style: TextStyle(
                                fontSize: fontSize[1],
                                font: font1,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    )
                  : SizedBox(),
            if (model.infosAvail[4])
              resume.onlineProfiles != null
                  ? Partition(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: resume.onlineProfiles?.map((e) {
                              return UrlText(text: e.platform, url: e.link);
                            }).toList() ??
                            [],
                      ),
                    )
                  : SizedBox(),
            if (model.infosAvail[3])
              resume.educations != null
                  ? Partition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Education'),
                          Divider(),
                          ListView.builder(
                            itemCount: resume.educations!.length,
                            itemBuilder: (Context context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(font: font1),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${resume.educations![index].institute}\n',
                                                style: TextStyle(
                                                    font: font2,
                                                    fontSize: fontSize[1]),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${resume.educations![index].programme} - '
                                                    '${resume.educations![index].course} '
                                                    '${resume.educations![index].score} ',
                                                style: TextStyle(
                                                  // font: font2,
                                                  fontSize: fontSize[1],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${resume.educations![index].startDate} - '
                                          '${resume.educations![index].endDate}',
                                          style: TextStyle(
                                              font: font3,
                                              fontSize: fontSize[1]),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            SizedBox(height: gap),
            if (model.infosAvail[1])
              resume.workExperiences != null
                  ? Partition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Experience'),
                          Divider(),
                          ListView.builder(
                            itemCount: resume.workExperiences!.length,
                            itemBuilder: (Context context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${resume.workExperiences![index].companyName} | '
                                          '${resume.workExperiences![index].role}',
                                          style: TextStyle(
                                            font: font2,
                                            fontSize: fontSize[1],
                                          ),
                                        ),
                                        Text(
                                          '${resume.workExperiences![index].address} | '
                                          '${resume.workExperiences![index].startDate} - '
                                          '${resume.workExperiences![index].endDate}',
                                          style: TextStyle(
                                            font: font3,
                                            fontSize: fontSize[1],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    workText[index],
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
            SizedBox(height: gap),
            if (model.infosAvail[2])
              resume.projects != null
                  ? Partition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Projects'),
                          Divider(),
                          ListView.builder(
                            itemCount: resume.projects!.length,
                            itemBuilder: (Context context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${resume.projects![index].projectName} |',
                                          style: TextStyle(font: font2),
                                        ),
                                        UrlText(
                                          text: 'Link',
                                          url: resume.projects![index].link,
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          resume.projects![index].tools,
                                          style: TextStyle(
                                            font: font3,
                                            fontSize: fontSize[1],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    projectText[index],
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
            SizedBox(height: gap),
            if (model.infosAvail[5])
              resume.skills != null
                  ? Partition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Skills'),
                          Divider(),
                          ListView.builder(
                            itemCount: resume.skills!.length,
                            itemBuilder: (Context context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Text(
                                      '${resume.skills![index].domain}:   ${resume.skills![index].skills}',
                                      style: TextStyle(fontSize: fontSize[1]),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
            SizedBox(height: gap),
            if (model.infosAvail[6])
              resume.acheivements != null
                  ? Partition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Achievements'),
                          Divider(),
                          ListView.builder(
                            itemCount: resume.acheivements!.length,
                            itemBuilder: (Context context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bullet),
                                    SizedBox(width: 5),
                                    SizedBox(
                                      width: 450,
                                      child: Text(
                                        resume.acheivements![index].achievement,
                                        style: TextStyle(fontSize: fontSize[1]),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
            SizedBox(height: gap),
            if (model.infosAvail[7])
              resume.activities != null
                  ? Partition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Extra Curricular Activities'),
                          Divider(),
                          ListView.builder(
                            itemCount: resume.activities!.length,
                            itemBuilder: (Context context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    resume.activities![index].activity,
                                    style: TextStyle(fontSize: fontSize[1]),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
          ],
        ),
      ],
    ),
  );

  return await doc.save();
}

List<String> processBulletedText(String text) {
  List<String> res = [];
  String currentLine = '';
  for (var i = 1; i < text.length; i++) {
    if (text[i] == '\n') {
      res.add(currentLine);
      i++;
      currentLine = '';
    } else if (text[i] == bullet) {
      debugPrint('Found One');
      continue;
    } else {
      currentLine += text[i];
    }
  }
  debugPrint(Resume.sampleRes.workExperiences![0].getWork().toString());
  return res;
}

Widget transform(List<String> text, double size) {
  List<Widget> list = [];
  for (var i = 0; i < text.length; i++) {
    list.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bullet),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 450,
            child: Text(text[i], style: TextStyle(fontSize: size)),
          ),
        ],
      ),
    );
  }
  return Column(children: list);
}
