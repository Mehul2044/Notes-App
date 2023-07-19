import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../models/notes_model.dart';

class InputArea extends StatefulWidget {
  final bool isTitle;
  final Note noteObj;
  final String? initialText;

  const InputArea({
    super.key,
    required this.initialText,
    required this.noteObj,
    required this.isTitle,
  });

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  TextEditingController textEditingController = TextEditingController();
  Timer? debounceTimer;

  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = widget.initialText ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  void _debouncedUpdate(String? value) async {
    debounceTimer?.cancel();
    debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (widget.isTitle) {
          widget.noteObj.updateNote(value, null);
        } else {
          widget.noteObj.updateNote(null, value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: widget.isTitle ? "Add Title" : "Add Body",
      ),
      maxLines: widget.isTitle ? 2 : null,
      style: widget.isTitle
          ? Theme.of(context).textTheme.titleLarge
          : Theme.of(context).textTheme.bodyMedium,
      onChanged: _debouncedUpdate,
    );
  }
}
