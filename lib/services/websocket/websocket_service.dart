import 'dart:io';

class WebSocketService {
  WebSocket? _webSocket;

  Future<void> connect(String url, Function(String) onMessageReceived) async {
    try {
      _webSocket = await WebSocket.connect(url);
      _webSocket!.listen( (message) {
        onMessageReceived(message);
      });
    } catch (e) {
      print('Error connecting to WebSocket: $e');
    }
  } 

  void sendMessage(String message) {
    if(_webSocket != null && _webSocket!.readyState == WebSocket.open) {
      _webSocket!.add(message);
    }
  }

  void closeConnection() {
    _webSocket?.close();
  }

}