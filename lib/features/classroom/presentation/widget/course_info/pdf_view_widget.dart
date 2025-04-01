import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfView extends StatefulWidget {
  final String url;

  const PdfView({
    super.key,
    required this.url,
  });

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/document.pdf');
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      Logger().e('Error loading PDF: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(child: const Center(child: CircularProgressIndicator()))
        : localPath == null
            ? Expanded(child: const Center(child: Text('Error loading PDF')))
            : Expanded(
                child: PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onError: (error) {
                    Logger().e('Error rendering PDF: $error');
                  },
                ),
              );
  }
}
