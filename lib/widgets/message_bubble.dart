import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../helper/colorpalatte.dart';

class MessageBubble extends StatelessWidget {
  final String content;
  final bool isUserMessage;

  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final ColorPalette colors = ColorPalette();

    Color responseText = Colors.white;
    Color responseTextBG = colors.primaryMessageBubble;
    Color responseTextTitle = colors.primaryMessageBubble;


    if(content.contains("```")){
      responseTextTitle=Colors.white;
      responseText=Colors.blueGrey;
      responseTextBG= Colors.black54;
    }else{
      responseTextTitle=Colors.white;
      responseText=Colors.white;
      responseTextBG= colors.primaryMessageBubble;
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: isUserMessage
                ? const EdgeInsets.only(left: 60, top: 5, right: 12, bottom: 2)
                : const EdgeInsets.only(left: 12, top: 5, right: 60, bottom: 2),
            decoration: BoxDecoration(
              color: isUserMessage
                    ? colors.primaryNeon
                    :
              responseTextBG,

              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isUserMessage ? 'You' : 'Bacin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isUserMessage ? null : responseTextTitle,
                        ),
                      ),

                    ],
                  ),
                  Markdown(

                    padding: const EdgeInsets.only(
                        left: 0, top: 8, right: 0, bottom: 0),
                    selectable: true,
                    physics: PageScrollPhysics(),
                    styleSheet: MarkdownStyleSheet.fromTheme(
                      Theme.of(context).copyWith(
                         textTheme: Theme
                            .of(context)
                            .textTheme
                            .apply(
                          bodyColor: isUserMessage ? Colors.black : responseText,
                          // Set the text color to black when isUserMessage is "You", otherwise set it to white
                          displayColor: Colors.white, // Set the color of links and headings to white
                        ),
                      ),
                    ),
                    data: content,
                    shrinkWrap: true,
                  ),

                  if (!isUserMessage)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: content));
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Copied to clipboard')),
                          // );
                        },
                        child: const Padding(
                        padding: EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 2),
                        child: Icon(Icons.copy, size: 18, color: Colors.white),
                        ),
                      ),
                  ),


    ],
              ),
            ),
          ),
        ),
      //   if (isUserMessage)
      //     Padding(
      //       padding: const EdgeInsets.only(left: 8),
      //       child: CircleAvatar(
      //         child: Text('Y'),
      //       ),
      //     ),
      ],
    );
  }
}