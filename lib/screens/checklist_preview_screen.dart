import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';

import '../widgets/app_drawer.dart';
import 'examples.dart';

class ChecklistPreviewScreen extends StatefulWidget {
  static const routeName = '/checklist-preview';

  @override
  State<ChecklistPreviewScreen> createState() => _ChecklistPreviewScreenState();
}

class _ChecklistPreviewScreenState extends State<ChecklistPreviewScreen>
    with SingleTickerProviderStateMixin {
  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + 'document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      PdfPreviewAction(
        icon: const Icon(Icons.save),
        onPressed: _saveAsFile,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      drawer: AppDrawer(),
      body: PdfPreview(
        maxPageWidth: 700,
        build: (format) => examples[0].builder(format),
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }
}
