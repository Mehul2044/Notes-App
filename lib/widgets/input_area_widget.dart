import 'package:flutter/material.dart';

import '../models/notes_model.dart';

class InputArea extends StatefulWidget {
  final bool isTitle;
  final Note noteObj;
  final TextEditingController textEditingController;

  const InputArea({
    super.key,
    required this.textEditingController,
    required this.noteObj,
    required this.isTitle,
  });

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: widget.isTitle ? "Add Title" : "Add Body",
      ),
      maxLines: widget.isTitle ? 2 : null,
      style: widget.isTitle
          ? Theme.of(context).textTheme.titleLarge
          : Theme.of(context).textTheme.bodyMedium,
      onChanged: (value) {
        if (widget.isTitle) {
          widget.noteObj.updateNote(value, null);
        } else {
          widget.noteObj.updateNote(null, value);
        }
      },
    );
  }
}
