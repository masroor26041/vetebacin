import 'package:VeteBacin/api/chat_api.dart';
import 'package:VeteBacin/loginpage.dart';
import 'package:VeteBacin/models/chat_message.dart';
import 'package:VeteBacin/widgets/message_bubble.dart';
import 'package:VeteBacin/widgets/message_composer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/colorpalatte.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatApi,
    super.key,
  });

  final ChatApi chatApi;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[    ChatMessage('Si mund të ndihmoj?', false),  ];
  var _awaitingResponse = false;
  final _scrollController = ScrollController();

  final ColorPalette colors = ColorPalette();
  final List<PopupMenuItem<String>> _menuItems = [
    const PopupMenuItem(
      value: 'profile',
      child: Text('Profile',style: TextStyle(color: Colors.white)),
    ),
    const PopupMenuItem(
      value: 'help',
      child: Text('Help',style: TextStyle(color: Colors.white)),
    ),
    const PopupMenuItem(
      value: 'logout',
      child: Text('Logout',style: TextStyle(color: Colors.white)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
    child:Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chatbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  ..._messages.map(
                        (msg) => MessageBubble(
                      content: msg.content,
                      isUserMessage: msg.isUserMessage,
                    ),
                  ),
                ],
              ),
            ),
            MessageComposer(
              onSubmitted: _onSubmitted,
              awaitingResponse: _awaitingResponse,
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        leading: PopupMenuButton<String>(
          color: colors.primaryAppBar,
          itemBuilder: (BuildContext context) => _menuItems,
          onSelected: (String value) {
            switch (value) {
              case 'profile':
              // Handle settings menu item press
                break;
              case 'help':
                print("help");
                break;
              case 'logout':

                SharedPreferences.getInstance().then((prefs) {
                  setState(() {
                    prefs.setBool('isLoggedIn', false);
                  });
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                break;
            }
          },
          child: const IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: null,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              setState(() {
                _messages.clear();
              });
            },
          ),
        ],
        backgroundColor: colors.primaryAppBar,
        elevation: 0,
      ),

      backgroundColor: Colors.transparent,
    ),
    );
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.add(ChatMessage(message, true));
      _awaitingResponse = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
    try {
      final response = await widget.chatApi.completeChat(_messages);
      setState(() {
        _messages.add(ChatMessage(response, false));
        _awaitingResponse = false;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (err) {
      print("ERROR:______");
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Ndodhi një gabim. Ju lutemi provoni përsëri.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}
