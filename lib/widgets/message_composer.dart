import 'package:flutter/material.dart';

import '../helper/colorpalatte.dart';

class MessageComposer extends StatelessWidget {
  MessageComposer({
    required this.onSubmitted,
    required this.awaitingResponse,
     super.key,
  });

  final TextEditingController _messageController = TextEditingController();

  final void Function(String) onSubmitted;
  final bool awaitingResponse;
  final ColorPalette colors = ColorPalette();



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left:10,top:5,right: 10, bottom: 10),
      padding: const EdgeInsets.only(left:20,top:2,right: 2, bottom: 2),
      decoration: BoxDecoration(
        color: colors.primaryInputs,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: !awaitingResponse
                  ? TextField(
                style: TextStyle(color: Colors.white),
                      controller: _messageController,
                      onSubmitted: onSubmitted,
                      decoration: const InputDecoration(
                        hintText: 'Shkruani mesazhin tuaj...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white38),
                      ),
                     )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(119, 212, 0, 1))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Një moment...',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                color: colors.primaryNeon,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: IconButton(
                onPressed: !awaitingResponse
                    ? () => onSubmitted(_messageController.text)
                    : null,


                icon: const Icon(
                  Icons.send,

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
