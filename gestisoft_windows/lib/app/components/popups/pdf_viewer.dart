import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:printing/printing.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({
    Key? key,
    required this.bytes,
    required this.fileName,
    required this.extension,
    required this.title,
  }) : super(key: key);

  final Uint8List bytes;
  final String fileName;
  final String extension;
  final String title;
  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  Future<Uint8List> getBytes() async {
    return widget.bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.withOpacity(.9),
        title: Text(widget.title),
      ),
      body: PdfPreview(
        allowSharing: false,
        allowPrinting: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        maxPageWidth: 1000,
        actions: [
          PdfPreviewAction(
            icon: const Icon(
              Icons.file_download_rounded,
              color: Colors.white,
            ),
            onPressed: (context, getBytes, format) async {
              String path = '';
              MimeType type = MimeType.PDF;
              try {
                path = await FileSaver.instance.saveFile(
                    widget.fileName, widget.bytes, widget.extension,
                    mimeType: type);
                if (path.isNotEmpty) {
                  Alert.show(
                    message: "Se ha guardado el archivo en $path",
                    type: 0,
                    context: context,
                  );
                  await Future.delayed(const Duration(seconds: 2));
                  Modular.to.pop();
                } else {
                  Alert.show(
                    message: "No se ha podido guardar el archivo",
                    type: 2,
                    context: context,
                  );
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
        ],
        onPrintError: (context, error) => Text(error),
        build: (format) => widget.bytes,
      ),
    );
  }
}
