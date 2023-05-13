import 'package:VeteBacin/api/chat_api.dart';
import 'package:VeteBacin/chat_page.dart';
import 'package:VeteBacin/loginpage.dart';
import 'package:VeteBacin/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/azureApiHelper.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChatApp(chatApi: ChatApi()));

}

class ChatApp extends StatefulWidget {
  const ChatApp({required this.chatApi, Key? key}) : super(key: key);

  final ChatApi chatApi;

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {


  late bool _isLoggedIn = false;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return MaterialApp(
        title: 'Main',
        home: ChatPage(chatApi: widget.chatApi),
      );
    } else {
      return const MaterialApp(
        title: 'Main',
        home: LoginPage(),
      );
    }
  }
}

