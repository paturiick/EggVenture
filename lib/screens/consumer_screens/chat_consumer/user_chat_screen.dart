import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;
import 'package:eggventure/constants/colors.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:uuid/uuid.dart';

class UserChatScreen extends StatefulWidget {
  @override
  _UserChatScreenState createState() =>
      _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  bool _isEmojiVisible = false;
  TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 200,
          color:
              Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.image,
                      color: AppColors.BLUE,
                      size: 25,
                    ),
                    SizedBox(
                        width: 10), // Add some space between the icon and text
                    Text(
                      'Photo',
                      style: TextStyle(color: AppColors.BLUE,
                      fontSize: 20),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.file_circle_plus_solid,
                      color: AppColors.BLUE,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'File',
                      style: TextStyle(color: AppColors.BLUE,
                      fontSize: 20),
                    ),
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
                    SizedBox(width: 10),
                    Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.RED,
                      fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
    _textController.clear();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiVisible = !_isEmojiVisible;
    });
  }

  void _onEmojiSelected(Emoji emoji) {
    _textController.text += emoji.emoji;
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Chat Messages Section (Expanded to take all available space)
            Expanded(
              child: Chat(
                messages: _messages,
                onSendPressed: _handleSendPressed,
                user: _user,
                onAttachmentPressed: _handleAttachmentPressed,
                onPreviewDataFetched: _handlePreviewDataFetched,
                showUserAvatars: true,
                showUserNames: true,
                theme: DefaultChatTheme(
                  primaryColor: AppColors.BLUE,
                  secondaryColor: Colors.grey[300]!,
                ),
                // Do not add the default input widget
                customBottomWidget: SizedBox.shrink(),
              ),
            ),
            // Custom Input Bar Section (Message input stays here)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  // Attachment Button
                  IconButton(
                    onPressed: _handleAttachmentPressed,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey,
                    ),
                  ),
                  // Text Input Field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: _textController,
                          cursorColor: AppColors.YELLOW,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Emoji Button
                  IconButton(
                    onPressed: _toggleEmojiPicker,
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: AppColors.YELLOW,
                    ),
                  ),
                  // Send Button
                  IconButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        _handleSendPressed(
                            types.PartialText(text: _textController.text));
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: AppColors.BLUE,
                    ),
                  ),
                ],
              ),
            ),
            // Emoji Picker
            Offstage(
              offstage: !_isEmojiVisible,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  textEditingController: _textController,
                  config: Config(
                    height: 256,
                    checkPlatformCompatibility: true,
                    viewOrderConfig: const ViewOrderConfig(),
                    emojiViewConfig: EmojiViewConfig(
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      emojiSizeMax: 15 *
                          (foundation.defaultTargetPlatform ==
                                  TargetPlatform.android
                              ? 1.2
                              : 1.0),
                    ),
                ),
              ),
            ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: AppColors.YELLOW,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.BLUE,
              size: screenWidth * 0.06,
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // Add navigation to user profile logic here
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.05,
                      backgroundImage:
                          AssetImage('assets/stores/white_feathers.jpg'),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "Farmer User #1",
                      style: TextStyle(
                        color: AppColors.BLUE,
                        fontSize: screenWidth * 0.048,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
