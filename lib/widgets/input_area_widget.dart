import 'package:async/async.dart';
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
  CancelableOperation? _debounceOperation;
  final List<String?> _changeBuffer = [];

  @override
  void dispose() {
    // TODO: implement dispose
    widget.textEditingController.dispose();
    _debounceOperation?.cancel();
    super.dispose();
  }

  void _debouncedUpdate(String? value) {
    _changeBuffer.add(value);
    _debounceOperation?.cancel();
    _debounceOperation = CancelableOperation.fromFuture(
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (_changeBuffer.isNotEmpty) {
          final batchUpdate = _changeBuffer.join();
          _changeBuffer.clear();
          if (widget.isTitle) {
            widget.noteObj.updateNote(batchUpdate, null);
          } else {
            widget.noteObj.updateNote(null, batchUpdate);
          }
        }
      }),
    );
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
      onChanged: _debouncedUpdate,
    );
  }
}
