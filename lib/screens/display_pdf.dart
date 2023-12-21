import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:resumex/api/pdf/layout1.dart';
import 'package:resumex/providers/providers.dart';
import 'package:resumex/screens/login_page.dart';

import '../../api/pdf/pdfs.dart';
import '../models/resume_model.dart';

class DisplayPdf extends StatefulWidget {
  const DisplayPdf({Key? key}) : super(key: key);
  static const routeName = '/display-pdf';

  @override
  State<DisplayPdf> createState() => _DisplayPdfState();
}

class _DisplayPdfState extends State<DisplayPdf> {
  double _marginLr = 20;
  double _marginTb = 40;
  double textScale = 1;
  double _gap = 2;
  @override
  Widget build(BuildContext context) {
    final res = Provider.of<ResumeModelProvider>(context);
    final infos = Provider.of<InfosModel>(context);
    Future<Uint8List> generateDoc(
      PdfPageFormat format,
      List<double> fontSize,
      Resume resume,
      double? marginLR,
      double? marginTB,
      double? textScale,
      double? gap,
      InfosModel model,
    ) {
      if (infos.currentDesign == 2) {
        return generateDocumentLayout1(
          PdfPageFormat.a4,
          [0, 10, 12, 25],
          res.currentResume(),
          _marginLr,
          _marginTb,
          textScale,
          _gap,
          infos,
        );
      }
      return generateDocument2(
        PdfPageFormat.a4,
        [0, 10, 15, 25],
        res.currentResume(),
        _marginLr,
        _marginTb,
        textScale,
        _gap,
        infos,
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 1.5,
            child: PdfPreview(
              previewPageMargin: const EdgeInsets.all(5),
              build: (format) => generateDoc(
                PdfPageFormat.a4,
                [0, 10, 15, 25],
                res.currentResume(),
                _marginLr,
                _marginTb,
                textScale,
                _gap,
                infos,
              ),
              canDebug: false,
              canChangeOrientation: false,
              canChangePageFormat: false,
              pdfFileName: 'resume',
              loadingWidget: const LoadingSpinner(),
            ),
          ),
          const Text(
            'Use the print icon to save',
            style: TextStyle(height: 2),
            textAlign: TextAlign.center,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 8),
            child: Text('Margin sideways'),
          ),
          Slider(
            value: _marginLr,
            max: 50,
            divisions: 5,
            label: _marginLr.round().toString(),
            onChanged: (double value) {
              setState(() {
                _marginLr = value;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 8),
            child: Text('Margin up down'),
          ),
          Slider(
            value: _marginTb,
            max: 80,
            divisions: 8,
            label: _marginTb.round().toString(),
            onChanged: (double value) {
              setState(() {
                _marginTb = value;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 8),
            child: Text('Gap between sections'),
          ),
          Slider(
            value: _gap,
            max: 10,
            divisions: 10,
            label: _gap.round().toString(),
            onChanged: (double value) {
              setState(() {
                _gap = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
