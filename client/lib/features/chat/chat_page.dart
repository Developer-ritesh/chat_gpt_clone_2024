import 'package:client/design/app_colors.dart';
import 'package:client/features/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatBloc chatBloc = ChatBloc();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ChatGPT",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: chatBloc.cachedMessages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color:
                              chatBloc.cachedMessages[index].role == 'assistant'
                                  ? AppColors.messageBgColor
                                  : Colors.transparent),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatBloc.cachedMessages[index].role == 'assistant'
                              ? Container(
                                  height: 32,
                                  width: 32,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "assets/chatgpt.jpeg",
                                          ),
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  height: 32,
                                  width: 32,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage("assets/random.jpeg"),
                                          fit: BoxFit.cover)),
                                ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              chatBloc.cachedMessages[index].content,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      promptContainer(("Tell me something about Harry Potter")),
                      promptContainer(("Tell me something about Harry Potter")),
                      promptContainer(("Tell me something about Harry Potter")),
                      promptContainer(("Tell me something about Harry Potter")),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6)),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: controller,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            hintText: "Ask Anything...",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            filled: false),
                      )),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            String text = controller.text;
                            controller.clear();
                            chatBloc.add(ChatNewPromptEvent(prompt: text));
                          }
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "ChatGPT March 2024",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      SizedBox(width: 10),
                      Text("Free Research Preview")
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget promptContainer(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Text(text),
    );
  }
}
