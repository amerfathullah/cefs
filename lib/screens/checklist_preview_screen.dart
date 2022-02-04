import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/checklists.dart';
import '../providers/checklist.dart';
import '../widgets/app_drawer.dart';

class ChecklistPreviewScreen extends StatefulWidget {
  static const routeName = '/checklist-preview';

  @override
  State<ChecklistPreviewScreen> createState() => _ChecklistPreviewScreenState();
}

class _ChecklistPreviewScreenState extends State<ChecklistPreviewScreen>
    with SingleTickerProviderStateMixin {
  PdfColor baseColor = PdfColors.black;
  PdfColor accentColor = PdfColors.black;

  var _isInit = true;
  var _editedChecklist = Checklist(
    id: null,
    foamTender: '',
    regNo: '',
    dateTime: null,
    shiftDay: null,
    shiftNight: null,
    foamCapacity: 0.0,
    waterCapacity: 0.0,
    c1e1day: 0,
    c1e1night: 0,
    c1e2day: 0,
    c1e2night: 0,
    c1e3day: 0,
    c1e3night: 0,
    c1e4day: 0,
    c1e4night: 0,
    c2e1day: 0,
    c2e1night: 0,
    c2e2day: 0,
    c2e2night: 0,
    inspectNameDay: '',
    inspectNameNight: '',
    watchNameDay: '',
    watchNameNight: '',
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final checklistId = ModalRoute.of(context).settings.arguments as String;
      if (checklistId != null) {
        _editedChecklist = Provider.of<Checklists>(context, listen: false)
            .findById(checklistId);
      }
      products = <Equipment>[
        Equipment('CO2 FIRE EXTINGUISHER', _editedChecklist.c1e1day,
            _editedChecklist.c1e1night),
        Equipment('D/P EXTINGUISHER (PORTABLE)', _editedChecklist.c1e2day,
            _editedChecklist.c1e2night),
        Equipment('WATER CURTAIN', _editedChecklist.c1e3day,
            _editedChecklist.c1e3night),
        Equipment('BLITZ FIRE MONITOR', _editedChecklist.c1e4day,
            _editedChecklist.c1e4night),
        Equipment('ADAPTOR 5” SURE LOCK TO 4” SCREW', _editedChecklist.c2e1day,
            _editedChecklist.c2e1night),
        Equipment('ADAPTOR FEMALE SCREW MALE SCREW', _editedChecklist.c2e2day,
            _editedChecklist.c2e2night),
      ];
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  var products = <Equipment>[
    Equipment('CO2 FIRE EXTINGUISHER', 0, 0),
    Equipment('D/P EXTINGUISHER (PORTABLE)', 0, 0),
    Equipment('WATER CURTAIN', 0, 0),
    Equipment('BLITZ FIRE MONITOR', 0, 0),
    Equipment('ADAPTOR 5” SURE LOCK TO 4” SCREW', 0, 0),
    Equipment('ADAPTOR FEMALE SCREW MALE SCREW', 0, 0),
  ];

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'CENTRAL EMERGENCY & FIRE SERVICES RESPONSE',
                      style: pw.TextStyle(
                        // color: PdfColors.teal,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'VEHICLES & EQUIPMENT CHECKLIST',
                      style: pw.TextStyle(
                        // color: PdfColors.teal,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 50),
                  pw.Row(children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'FOAM TENDER (FT): ${_editedChecklist.foamTender}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'REGISTRATION NUMBER: ${_editedChecklist.regNo}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 50),
                  pw.Row(children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'DATE: ${DateFormat('dd/MM/yyyy hh:mm').format(_editedChecklist.dateTime)}',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 50),
                  pw.Row(children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'TIME : 0800 – 2000 SHIFT: ',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftDay == ShiftDay.A ? 'A' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftDay == ShiftDay.B ? 'B' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftDay == ShiftDay.C ? 'C' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftDay == ShiftDay.D ? 'D' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.only(left: 100),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'FOAM CAPACITY: ${_editedChecklist.foamCapacity} LITRES',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'TIME : 2000 – 0800 SHIFT: ',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftNight == ShiftNight.A ? 'A' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftNight == ShiftNight.B ? 'B' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftNight == ShiftNight.C ? 'C' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _editedChecklist.shiftNight == ShiftNight.D ? 'D' : '',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.only(left: 100),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'WATER CAPACITY: ${_editedChecklist.waterCapacity} LITRES',
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 50)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Expanded(flex: 1, child: pw.Container()),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'INSPECT BY',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'WATCH COMMANDER',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Expanded(flex: 1, child: pw.Container()),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '0800-2000',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '2000-0800',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '0800-2000',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '2000-0800',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Expanded(
              flex: 1,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'NAME',
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
              )),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '${_editedChecklist.inspectNameDay}',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '${_editedChecklist.inspectNameNight}',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '${_editedChecklist.watchNameDay}',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '${_editedChecklist.watchNameDay}',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = ['LIST OF EQUIPMENT', 'QTY', '0800-2000', '2000-0800'];

    return pw.Table.fromTextArray(
      border: pw.TableBorder(
        top: pw.BorderSide(color: PdfColors.black),
        bottom: pw.BorderSide(color: PdfColors.black),
        left: pw.BorderSide(color: PdfColors.black),
        right: pw.BorderSide(color: PdfColors.black),
        verticalInside: pw.BorderSide(color: PdfColors.black),
        horizontalInside: pw.BorderSide(color: PdfColors.black),
      ),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.white,
      ),
      // headerHeight: 25,
      // cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.black,
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 14,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: 1,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }

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

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          pw.SizedBox(height: 50),
          _contentTable(context),
          pw.SizedBox(height: 50),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
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
        build: buildPdf,
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }
}

class Equipment {
  const Equipment(
    this.name,
    this.dayQ,
    this.nightQ,
  );

  final String name;
  int get quantity => dayQ + nightQ;
  final int dayQ;
  final int nightQ;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return name;
      case 1:
        return quantity.toString();
      case 2:
        return dayQ.toString();
      case 3:
        return nightQ.toString();
    }
    return '';
  }
}
