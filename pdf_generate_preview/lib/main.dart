import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Generate & Preview',
      home: PDFPage(),
    );
  }
}

class PDFPage extends StatefulWidget {
  const PDFPage({Key? key}) : super(key: key);

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  final pdf = pw.Document();
  late File? file = null;

  writeOnPDF() {
    //Single Page Demo
    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Center(
    //         child: pw.Text("Hello World"),
    //       );
    //     }));

    //MultiPage Demo
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
                level: 0, child: pw.Text("Demo Sample Document First Header")),
            pw.Paragraph(
                text:
                    "The first personnel management department started at the National Cash Register Co. in 1900. The owner, John Henry Patterson, organized a personnel department to deal with grievances, discharges and safety, and training for supervisors on new laws and practices after several strikes and employee lockouts. During the 1970s, companies experienced globalization, deregulation, and rapid technological change which caused the major companies to enhance their strategic planning and focus on ways to promote organizational effectiveness. This resulted in developing more jobs and opportunities for people to show their skills which were directed to effective applying employees toward the fulfillment of individual, group, and organizational goals. Many years later the major/minor of human resource management was created at universities and colleges also known as business administration."),
            pw.Header(level: 1, child: pw.Text("Second Header")),
            pw.Paragraph(
                text:
                    "The second personnel management department started at the National Cash Register Co. in 1900. The owner, John Henry Patterson, organized a personnel department to deal with grievances, discharges and safety, and training for supervisors on new laws and practices after several strikes and employee lockouts. During the 1970s, companies experienced globalization, deregulation, and rapid technological change which caused the major companies to enhance their strategic planning and focus on ways to promote organizational effectiveness. This resulted in developing more jobs and opportunities for people to show their skills which were directed to effective applying employees toward the fulfillment of individual, group, and organizational goals. Many years later the major/minor of human resource management was created at universities and colleges also known as business administration."),
            pw.Paragraph(
                text:
                    "The third personnel management department started at the National Cash Register Co. in 1900. The owner, John Henry Patterson, organized a personnel department to deal with grievances, discharges and safety, and training for supervisors on new laws and practices after several strikes and employee lockouts. During the 1970s, companies experienced globalization, deregulation, and rapid technological change which caused the major companies to enhance their strategic planning and focus on ways to promote organizational effectiveness. This resulted in developing more jobs and opportunities for people to show their skills which were directed to effective applying employees toward the fulfillment of individual, group, and organizational goals. Many years later the major/minor of human resource management was created at universities and colleges also known as business administration.")
          ];
        }));
  }

  Future savePDF() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;

    File _file = File("$documentPath/sample.pdf");
    _file.writeAsBytes(await pdf.save());

    setState(() {
      file = _file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Generate & Preview"),
      ),
      body: file != null
          ? PdfView(path: file!.path)
          : const Center(
              child: Text("PDF"),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.picture_as_pdf),
        onPressed: () {
          writeOnPDF();
          savePDF();
        },
      ),
    );
  }
}
