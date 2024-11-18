import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class UserChatScreen extends StatefulWidget {
  @override
  _UserChatScreenState createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  void initState() {
    super.initState();
    ChatController.loadMessages(setState);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Chat(
                messages: ChatController.messages,
                onSendPressed: (message) =>
                    ChatController.handleSendPressed(message, setState),
                user: ChatController.user,
                onAttachmentPressed: () =>
                    ChatController.handleAttachmentPressed(
                        context,
                        setState,
                        () => ChatController.handleImageSelection(setState),
                        () => ChatController.handleFileSelection(setState)),
                showUserAvatars: true,
                showUserNames: true,
                theme: DefaultChatTheme(
                  primaryColor: AppColors.BLUE,
                  secondaryColor: Colors.grey[300]!,
                ),
                customBottomWidget: SizedBox.shrink(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        ChatController.isEmojiVisible = false;
                      });
                      ChatController.handleAttachmentPressed(
                        context, 
                        setState,
                        () => ChatController.handleImageSelection(setState),
                        () => ChatController.handleFileSelection(setState),
                      );
                    },
                    icon: Icon(Icons.add_circle_outline, color: Colors.grey),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: ChatController.textController,
                          cursorColor: AppColors.YELLOW,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(color: AppColors.BLUE),
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => ChatController.toggleEmojiPicker(setState),
                    icon: Icon(Icons.emoji_emotions_outlined,
                        color: AppColors.YELLOW),
                  ),
                  IconButton(
                    onPressed: () {
                      if (ChatController.textController.text.isNotEmpty) {
                        ChatController.handleSendPressed(
                            types.PartialText(
                                text: ChatController.textController.text),
                            setState);
                      }
                    },
                    icon: Icon(Icons.send, color: AppColors.BLUE),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !ChatController.isEmojiVisible,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  textEditingController: ChatController.textController,
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: AppColors.YELLOW,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: AppColors.BLUE, size: screenWidth * 0.06),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.04,
                      backgroundImage:
                          AssetImage("assets/stores/white_feathers.jpg"),
                      backgroundColor: Colors.grey[200],
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
