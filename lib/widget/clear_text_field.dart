import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import 'package:myapp/common/utils/appsize.dart';

class ClearTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextStyle style;
  final List<TextInputFormatter> inputFormatters;
  final bool autofocus;
  final bool obscureText;
  final int maxLines;
  final int maxLength;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;

  ClearTextField({
    this.controller,
    this.onChanged,
    this.style,
    this.inputFormatters,
    this.autofocus,
    this.obscureText,
    this.maxLines,
    this.maxLength,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
  });

  @override
  _ClearTextFieldState createState() {
    return _ClearTextFieldState();
  }
}

class _ClearTextFieldState extends State<ClearTextField> {
  bool canClear = false;
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    _controller =
        widget.controller == null ? TextEditingController() : widget.controller;
    _focusNode = widget.focusNode == null ? FocusNode() : widget.focusNode;

    canClear = _focusNode.hasFocus && _controller.text.isNotEmpty;
    _focusNode.addListener(() {
      setState(() {
        canClear = _focusNode.hasFocus && _controller.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            controller: _controller,
            onChanged: (input) {
              setState(() {
                canClear = input.isNotEmpty;
              });
              if (widget.onChanged != null) {
                widget.onChanged(input);
              }
            },
            style: widget.style,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus ?? false,
            obscureText: widget.obscureText ?? false,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            focusNode: _focusNode,
            decoration: widget.decoration,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
          ),
        ),
        Offstage(
          offstage: !canClear,
          child: GestureDetector(
            onTap: () {
              widget.controller?.clear();
              setState(() {
                canClear = false;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(AppSize.width(15.0)),
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                size: AppSize.width(55.0),
                color: Color(0xFFBDBDBD),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
