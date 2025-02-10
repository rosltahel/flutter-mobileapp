import 'package:flutter/material.dart';

// lib/helpPage/help.dart
// lib/helpPage/help.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class helpPage extends StatefulWidget {
  @override
  _helpPageState createState() => _helpPageState();
}

class _helpPageState extends State<helpPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add({"role": "user", "message": message});
    });

    // Simulate a delay as if an API call is being made
    await Future.delayed(Duration(seconds: 1));

    // Placeholder responses based on the user input
    String response;
    if (message.toLowerCase().contains("hello") || message.contains("مرحبا")) {
      response = Intl.getCurrentLocale() == 'ar'
          ? "مرحبا! كيف يمكنني مساعدتك اليوم؟"
          : "Hello! How can I help you today?";
    } else if (message.toLowerCase().contains("help") || message.contains("مساعدة")) {
      response = Intl.getCurrentLocale() == 'ar'
          ? "بالتأكيد، ماذا تحتاج؟"
          : "Sure, what do you need help with?";
    } else if (message.toLowerCase().contains("what is lensScout") || message.contains("ما هو اليوني تريد")) {
      response = Intl.getCurrentLocale() == 'ar'
          ? "اليوني تريد هو منصة إلكترونية تسهل عملية التجارة الإلكترونية بين المستخدمين. يمكنك شراء وبيع المنتجات بسهولة من خلال هذه المنصة."
          : "Uni-Trade is an online platform that facilitates e-commerce between users. You can easily buy and sell products through this platform.";
    } else {
      response = Intl.getCurrentLocale() == 'ar'
          ? "لست متأكدًا من كيفية الرد على ذلك. هل يمكنك إعادة صياغة السؤال؟"
          : "I'm not sure how to respond to that. Can you please rephrase?";
    }

    setState(() {
      _messages.add({"role": "bot", "message": response});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Intl.getCurrentLocale() == 'ar' ? 'مساعدة' : 'Help',
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: _messages[index]['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: _messages[index]['role'] == 'user'
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        _messages[index]['role'] == 'user' ? 'You' : 'lensScout helper',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: _messages[index]['role'] == 'user'
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          _messages[index]['message']!,
                          style: TextStyle(color: _messages[index]['role'] == 'user' ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: Intl.getCurrentLocale() == 'ar' ? 'اكتب رسالتك...' : 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
