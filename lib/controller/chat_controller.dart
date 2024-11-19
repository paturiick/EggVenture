import 'dart:convert';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:file_picker/file_picker.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatController {
  static List<types.Message> _messages = [];
  static List<types.Message> get messages => _messages;
  static types.Message? _latestMessage;

  static final user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  static bool isEmojiVisible = false;
  static TextEditingController textController = TextEditingController();

  /// Get formatted date and time
  static String getFormattedDateTime(int timeStamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Add a message to the chat list
  static void addMessage(types.Message message, Function setState) {
    setState(() {
      _messages.insert(0, message); // Add message at the start of the list
      _latestMessage = message; // Update the latest message
    });
  }

  /// Get the latest message as a formatted string
  static String getLatestMessage() {
    if (_messages.isEmpty) {
      return "No messages yet";
    }

    final latestMessage = _latestMessage;

    if (latestMessage is types.TextMessage) {
      return latestMessage.text;
    } else if (latestMessage is types.ImageMessage) {
      return "Sent a photo";
    } else if (latestMessage is types.FileMessage) {
      return "Sent an attachment";
    } else {
      return "Unsupported message type";
    }
  }

  /// Handle attachment selection (image or file)
  static void handleAttachmentPressed(
    BuildContext context,
    Function setState,
    Function handleImageSelection,
    Function handleFileSelection,
  ) {
    final ImagePickerController _imagePickerController =
        ImagePickerController();
    XFile? imageFile;

    void imageSelection(ImageSource source) async {
      try {
        final XFile? pickedFile =
            await _imagePickerController.pickImage(source);

        if (pickedFile != null) {
          imageFile = pickedFile;

          // Create the image message
          final bytes = await pickedFile.readAsBytes();
          final image = await decodeImageFromList(bytes);
          final message = types.ImageMessage(
            author: user,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            height: image.height.toDouble(),
            id: const Uuid().v4(),
            name: pickedFile.name,
            size: bytes.length,
            uri: pickedFile.path,
            width: image.width.toDouble(),
          );

          addMessage(message, setState);
        }
      } catch (e) {
        print("Error selecting image: $e");
      }
    }

    final screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 250,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  imageSelection(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.camera_solid,
                      color: AppColors.YELLOW,
                      size: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Take a Photo',
                        style: TextStyle(
                            color: AppColors.BLUE,
                            fontSize: screenWidth * 0.05)),
                  ],
                ),
              ),
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
                    Text('Upload an Image',
                        style: TextStyle(
                            color: AppColors.BLUE,
                            fontSize: screenWidth * 0.05)),
                  ],
                ),
              ),
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
                    Text('Upload a File',
                        style: TextStyle(
                            color: AppColors.BLUE,
                            fontSize: screenWidth * 0.05)),
                  ],
                ),
              ),
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

  /// Handle file selection
  static Future<void> handleFileSelection(Function setState) async {
    try {
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
    } catch (e) {
      print("Error selecting file: $e");
    }
  }

  /// Handle image selection
  static Future<void> handleImageSelection(Function setState) async {
    try {
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
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  /// Handle sending a text message
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

  /// Toggle emoji picker visibility
  static void toggleEmojiPicker(Function setState) {
    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  /// Add emoji to the text controller
  static void onEmojiSelected(Emoji emoji) {
    textController.text += emoji.emoji;
  }

  /// Load messages from a JSON file
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
