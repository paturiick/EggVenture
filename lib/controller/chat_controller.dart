// chat_functions.dart
import 'dart:convert';
import 'package:eggventure/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatController {
  static List<types.Message> _messages = [];

  static List<types.Message> get messages => _messages;

  static final user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  static bool isEmojiVisible = false;
  static TextEditingController textController = TextEditingController();

  static void addMessage(types.Message message, Function setState) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  static void handleAttachmentPressed(BuildContext context,
      Function handleImageSelection, Function handleFileSelection) {
        
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  handleImageSelection();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: AppColors.YELLOW,
                      size: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Photo',
                        style: 
                        TextStyle(
                          color: AppColors.BLUE, 
                          fontSize: screenWidth * 0.05)),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  handleFileSelection();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.file_copy,
                      color: AppColors.YELLOW,
                      size: 25,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text('File',
                        style: TextStyle(
                          color: AppColors.BLUE, 
                          fontSize: screenWidth * 0.05)),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: AppColors.RED,
                      size: 30,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Cancel',
                        style: TextStyle(
                          color: AppColors.RED, 
                          fontSize: screenWidth * 0.05)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> handleFileSelection(Function setState) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );
      addMessage(message, setState);
    }
  }

  static Future<void> handleImageSelection(Function setState) async {
    final result = await ImagePicker().pickImage(
        imageQuality: 70, maxWidth: 1440, source: ImageSource.gallery);
    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      addMessage(message, setState);
    }
  }

  static void handleSendPressed(types.PartialText message, Function setState) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    addMessage(textMessage, setState);
    textController.clear();
  }

  static void toggleEmojiPicker(Function setState) {
    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  static void onEmojiSelected(Emoji emoji) {
    textController.text += emoji.emoji;
  }

  static Future<void> loadMessages(Function setState) async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();
    setState(() {
      _messages = messages;
    });
  }
}
