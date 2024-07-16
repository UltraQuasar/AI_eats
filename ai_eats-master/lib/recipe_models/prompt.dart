// import 'package:ai_eats/recipe_models/secrets_example.dart';
import 'package:ai_eats/recipe_models/secrets_example.dart';
import 'package:dart_openai/dart_openai.dart';

import '../prompt_model/prompt_content.dart';

class API {
  static const _model = 'gpt-3.5-turbo-1106';
  late PromptGeneration promptGeneration;

  API(this.promptGeneration ) {
    promptGeneration = promptGeneration;
    OpenAI.apiKey = openAiApiKey;
    OpenAI.organization = openAiOrg;
    //OpenAI.showResponsesLogs = true;
    //OpenAI.showLogs = true;
  }

  Future generatePromptFunction() async {
// the system message that will be sent to the request.
    promptGeneration.setPromptFinished(false); // starts the prompt
    promptGeneration.setPromptFailed(false);
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          //persona - tone, and vocab. pro cooking teacher, professional, reassuring, youthful tone
            "When generating, use professional and concise, but easy to understand language."

            //format - highlight all ingredients that are not listed in the ingredients list
                "The recipe should have the following structure: Titel, Ingredients, Step by step guideline, Additional Commentary."
                "Dont give any other output then the structure which is given to you"
               // "Divide every Section with 'DIVIDER' e.g:"
                "Titel: titel"
              //  "DIVIDER"
                "Ingredients:"
               // "DIVIDER"
                "Step by Step guideline: "
                "1."
                "2..."
                //"DIVIDER"
                "Additional Commentary: "
               // "END"
                "If any ingredients needed in the recipe are not at hand, mark them as bold."

        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            promptGeneration.createPrompt()
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );
    print(promptGeneration.createPrompt());
    // all messages to be sent.
    final requestMessages = [
      systemMessage,
      userMessage,
    ];

    try {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: _model,
        messages: requestMessages,
      );
      String r = chatCompletion.choices.first.message.content?.first
          .text as String;
      print(r);
      promptGeneration.setRecipe(r); // Recipe is shown on the recipe page
      return chatCompletion;
    } on RequestFailedException catch(e) {
      promptGeneration.setPromptFailed(true);
      print(e);
      return Future.delayed(Duration(seconds: 1));
    }
  }
}
