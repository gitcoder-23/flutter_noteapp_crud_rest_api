import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class QuillExample extends StatefulWidget {
  final String title;

  const QuillExample({required this.title, super.key});

  @override
  State<QuillExample> createState() => _QuillExampleState();
}

class _QuillExampleState extends State<QuillExample> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 15,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Expanded(
                child: Container(
                  child: QuillEditor(
                    controller: _controller,
                    // readOnly: false, // true for view only mode
                    placeholder: 'Add content',
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: _focusNode,
                    autoFocus: false,
                    readOnly: false,
                    expands: false,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ),
          QuillToolbar.basic(controller: _controller),
        ],
      ),
    );
  }
}
