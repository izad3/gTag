import 'package:flutter/material.dart';
import 'package:gamer_tag_task/pages/chat_page.dart';
import 'package:gamer_tag_task/utilities/consts.dart';
import 'package:gamer_tag_task/utilities/page_size_tools.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeTools.screenWidth = MediaQuery.of(context).size.width;
    SizeTools.screenHeight = MediaQuery.of(context).size.height;
    SizeTools.maxChatContainerWidth = SizeTools.screenWidth * 0.75;
    return MaterialApp(
      title: 'Gamer Tag Task',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const ChatPage(),
    );
  }
}

