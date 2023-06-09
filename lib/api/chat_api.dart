import 'package:VeteBacin/models/chat_message.dart';
import 'package:VeteBacin/secrets_example.dart';
import 'package:dart_openai/openai.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    //MEINE
    OpenAI.apiKey = "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";
    OpenAI.organization = "org-bak7Xov4L1fF75fcutUiDPur";
    //R.A.
    // OpenAI.apiKey = "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";
    // OpenAI.organization = "org-5EBbGaAdHJlNNsGHkbX2hGA7";
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      maxTokens: 100,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? 'user' : 'assistant',
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
