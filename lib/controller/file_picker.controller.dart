import 'package:file_picker/file_picker.dart';

class FilePicker {
  static var platform;

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.single.path != null) {
      final String fileName = result.files.single.name;
      final String? filePath = result.files.single.path;
      final int fileSize = result.files.single.size;

      print('File Name: $fileName');
      print('File Path: $filePath');
      print('File Size: $fileSize bytes');
    } else {
      print('No file selected');
    }
  }
}
