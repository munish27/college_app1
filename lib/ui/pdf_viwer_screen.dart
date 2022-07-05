import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';

class PdfViewerScreen extends StatefulWidget {
  late PDFDocument pdf;
  PdfViewerScreen({Key? key, required this.pdf}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFF),
      appBar: appbar(context: context, title: 'Pdf Viewer'),
      body: PDFViewer(document: widget.pdf),
    );
  }
}
