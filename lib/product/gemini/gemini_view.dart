import 'package:dobesthabit/core/base/state/base_state.dart';
import 'package:dobesthabit/core/base/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gemini_viewmodel.dart';
import 'widgets/gemini_text.dart';

class GeminiView extends StatefulWidget {
  @override
  _GeminiViewState createState() => _GeminiViewState();
}

class _GeminiViewState extends BaseState<GeminiView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final String collectionName = "habits"; // Kullanmak istediğin Firebase koleksiyon adı.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GeminiViewmodel(),
      child: Scaffold(
        appBar: CivcivAppBar(title: 'Gemini Sohbet'),
        body: Consumer<GeminiViewmodel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: paddings.b(sizes.s40) +
                  paddings.h(
                    sizes.s4,
                  ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: viewModel.messages.length,
                      itemBuilder: (context, index) {
                        final message = viewModel.messages[index];
                        final isUserMessage = message.containsKey('user');
                        final text = isUserMessage ? message['user'] : message['gemini'];
                        final color = isUserMessage ? Colors.grey[300] : colorScheme.primary;
                        final alignment = isUserMessage ? Alignment.centerRight : Alignment.centerLeft;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          child: Align(
                            alignment: alignment,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.8, // Baloncuk genişliği
                              ),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 16.0, color: Colors.black), // Genel metin stili
                                  children: TextParser.parseMessage(text ?? ""), // TextParser sınıfındaki parseMessage fonksiyonunu çağırıyoruz
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Mesajınızı yazın...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            if (_messageController.text.isNotEmpty) {
                              final message = _messageController.text;

                              await Provider.of<GeminiViewmodel>(context, listen: false).fetchGeminiResponse(message);

                              _messageController.clear();
                              _scrollToBottom();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
