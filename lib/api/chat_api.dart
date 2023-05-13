import 'package:VeteBacin/models/chat_message.dart';
import 'package:VeteBacin/secrets_example.dart';
import 'package:dart_openai/openai.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = "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";
    OpenAI.organization = "org-bak7Xov4L1fF75fcutUiDPur";
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
