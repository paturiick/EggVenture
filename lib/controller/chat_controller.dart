import 'dart:convert';
import 'package:eggventure/constants/colors.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class ChatController {
  static List<types.Message> _messages = [];
  static List<types.Message> get messages => _messages;
  static types.Message? _latestMessage;
  static IOWebSocketChannel _webSocket = IOWebSocketChannel.connect('ws://echo.websocket.org');

  static final user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  static bool isEmojiVisible = false;
  static TextEditingController textController = TextEditingController();

  /// Load messages from local storage
  static Future<void> loadMessages(Function setState) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedMessages = prefs.getString('chat_messages');
      if (storedMessages != null) {
        final decodedMessages = jsonDecode(storedMessages) as List;
        _messages = decodedMessages
            .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        _messages = [];
      }
      setState(() {
        _latestMessage = _messages.isNotEmpty ? _messages.first : null;
      });
    } catch (e) {
      print("Error loading messages: $e");
    }
  }

  /// Save messages to local storage
  static Future<void> saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedMessages =
          _messages.map((message) => message.toJson()).toList();
      await prefs.setString('chat_messages', jsonEncode(encodedMessages));
    } catch (e) {
      print("Error saving messages: $e");
    }
  }

  /// Add a message to the chat list and save it locally
  static void addMessage(types.Message message, Function setState) {
    setState(() {
      _messages.insert(0, message);
      _latestMessage = message;
    });
    saveMessages();
  }

  /// Get the latest message for display
  static String getLatestMessage() {
    if (_messages.isEmpty) return "No messages yet";

    final latestMessage = _latestMessage;

    if (latestMessage is types.TextMessage) {
      return '${latestMessage.text}';
    } else if (latestMessage is types.ImageMessage) {
      return "Sent a photo";
    } else if (latestMessage is types.FileMessage) {
      return "Sent an attachment";
    } else {
      return "Unsupported message type";
    }
  }

  static String getLatestFormattedTime() {
    if (_messages.isEmpty || _latestMessage == null) return "";

    final latestMessage = _latestMessage;
    return getFormattedDateTime(latestMessage!.createdAt!);
  }

  /// Get formatted date and time
  static String getFormattedDateTime(int timeStamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Handle text message sending
  static void handleSendPressed(types.PartialText message, Function setState) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    addMessage(textMessage, setState);
    textController.clear();
    _webSocket.sink.add(message);


    _webSocket.sink.done.then((_) {
      print('Message sent successfully!');
    }).catchError((error) {
      print('Error sending message: $error');
    });
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

  /// Handle attachment selection
  static void handleAttachmentPressed(
    BuildContext context,
    Function setState,
    Function handleImageSelection,
    Function handleFileSelection,
  ) {
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
                      size: screenWidth * 0.05,
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
}
