import 'dart:io';
import 'package:ekayzone/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class SaveFile {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName, apiLevel, context) async {

    try {
      if(Platform.isAndroid){
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");

        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/Download";
        directory = Directory(newPath);

        if (kDebugMode) {
          print(directory.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          File file = File('${directory.path}/$fileName');
          await file.writeAsBytes(bytes, flush: true);


          if(apiLevel == 33){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invoice Saved Successfully"),
                  // action: SnackBarAction(label: "Open", onPressed: () {
                  //   OpenFile.open('/storage/emulated/0/Download/mtgpro_$filename.pdf');
                  // },),
            ),
            );
          }
          else {
            OpenFile.open('${directory.path}/$fileName');
          }

        }


      }
      else if (Platform.isMacOS || Platform.isIOS){
        Directory? directory;
        directory = await getDownloadsDirectory();

        directory ??= await getLibraryDirectory();

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          File file = File('${directory.path}${Platform.pathSeparator}$fileName');
          await file.writeAsBytes(bytes, flush: true);

          OpenFile.open('${directory.path}/$fileName');
        }
      }
    }catch (e){
      print(e);
      Utils.toastMsg("Something went wrong..");
    }
  }

}

