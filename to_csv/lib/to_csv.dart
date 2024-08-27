library to_csv;

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as pth_prov;
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

Future myCSV(
    List<String> headerRow,
    List<List<String>> listOfListOfStrings, {
      bool setHeadersInFirstRow = true,
      bool includeNoRow = true,
      bool sharing = false,
      String? fileName,
      String? fileTimeStamp,
      Map<int, int>? emptyRowsConfig,
      bool removeDuplicates = false,
      bool showDuplicateValue = false,
      int? noDuplicatedCheckAfterSpecificRow,
      int? transposeAfterRow, // New parameter to specify the row index after which to transpose
    }) async {

  if (kDebugMode) {
    print("***** Gonna Create csv");
  }

  String givenFileName = "${fileName ?? 'item_export'}_";
  DateTime now = DateTime.now();
  String formattedDate = fileTimeStamp ?? DateFormat('MM-dd-yyyy-HH-mm-ss').format(now);

  List<List<String>> headerAndDataList = [];

  if (setHeadersInFirstRow) {
    headerAndDataList.add(includeNoRow ? headerRow : headerRow.sublist(1));
    headerAndDataList.addAll(
      listOfListOfStrings.map((row) => includeNoRow ? row : row.sublist(1)).toList(),
    );
  } else {
    for (int i = 0; i < headerRow.length; i++) {
      if (includeNoRow || i > 0) {
        List<String> rowData = [headerRow[i]];
        for (int j = 0; j < listOfListOfStrings.length; j++) {
          rowData.add(listOfListOfStrings[j][i]);
        }
        headerAndDataList.add(rowData);
      }
    }
  }

  // Transpose after a specific row
  if (transposeAfterRow != null && transposeAfterRow < headerAndDataList.length) {
    List<List<String>> preTranspose = headerAndDataList.sublist(0, transposeAfterRow);
    List<List<String>> toTranspose = headerAndDataList.sublist(transposeAfterRow);

    List<List<String>> transposedData = [];

    for (int i = 0; i < toTranspose[0].length; i++) {
      List<String> newRow = [];
      for (int j = 0; j < toTranspose.length; j++) {
        newRow.add(toTranspose[j][i]);
      }
      transposedData.add(newRow);
    }

    headerAndDataList = [...preTranspose, ...transposedData];
  }

  // Duplicate removal, empty rows insertion logic, etc., remains the same
  // ...

  String csvData = const ListToCsvConverter().convert(headerAndDataList);

  if (kIsWeb) {
    final bytes = utf8.encode(csvData);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = '$givenFileName$formattedDate.csv';
    html.document.body!.children.add(anchor);
    anchor.click();
    html.Url.revokeObjectUrl(url);
  } else if (Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isWindows ||
      Platform.isMacOS) {
    final bytes = utf8.encode(csvData);
    Uint8List bytes2 = Uint8List.fromList(bytes);
    MimeType type = MimeType.csv;
    if (sharing == true) {
      String? unknownValue = await FileSaver.instance.saveAs(
          name: '$givenFileName$formattedDate',
          bytes: bytes2,
          ext: 'csv',
          mimeType: type);
      XFile? myFile;
      if (unknownValue != null) {
        myFile = await convertFilePathToXFile(unknownValue);
      }
      if (myFile != null) {
        await Share.shareXFiles([myFile], text: 'Csv File');
      }
    } else {
      await FileSaver.instance.saveAs(
          name: '$givenFileName$formattedDate',
          bytes: bytes2,
          ext: 'csv',
          mimeType: type);
    }
  }
}

Future<XFile?> convertFilePathToXFile(String filePath) async {
  final file = File(filePath);
  if (!await file.exists()) {
    return null;
  }

  final directory = await pth_prov.getApplicationDocumentsDirectory();
  final fileName = basename(filePath);

  final targetPath = join(directory.path, fileName);
  await file.copy(targetPath);
  return XFile(targetPath);
}
