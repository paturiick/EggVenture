import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await picker.pickImage(source: source);
      return image;
    } catch (e) {
      return null;
    }
  }
}
