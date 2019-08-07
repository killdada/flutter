import 'package:flutter/material.dart';
import 'package:myapp/common/utils/appsize.dart';

class ImageCheckBox extends StatefulWidget {
  final double size;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget checked;
  final Widget unchecked;

  ImageCheckBox({
    key,
    this.size,
    this.value,
    this.onChanged,
    this.checked,
    this.unchecked,
  }) : super(key: key);

  @override
  _ImageCheckBoxState createState() {
    return _ImageCheckBoxState();
  }
}

class _ImageCheckBoxState extends State<ImageCheckBox> {
  bool _checked;

  @override
  void initState() {
    _checked = widget.value ?? false;
    super.initState();
  }

  @override
  void didUpdateWidget(ImageCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checked = widget.value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked = !_checked;
          if (widget.onChanged != null) {
            widget.onChanged(_checked);
          }
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: AppSize.width(200.0),
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSize.width(46.0), right: AppSize.width(25.0)),
          child: SizedBox.fromSize(
            size: Size.square(
              widget.size ?? AppSize.width(70.0),
            ),
            child: _checked
                ? widget.checked ?? Image.asset('assets/images/icn_checked.png')
                : widget.unchecked ??
                    Image.asset('assets/images/icn_unchecked.png'),
          ),
        ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          _checked = !_checked;
          if (widget.onChanged != null) {
            widget.onChanged(_checked);
          }
        });
      },
      child: SizedBox.fromSize(
        size: Size.square(
          widget.size ?? AppSize.width(70.0),
        ),
        child: _checked
            ? widget.checked ?? Image.asset('assets/images/icn_checked.png')
            : widget.unchecked ??
                Image.asset('assets/images/icn_unchecked.png'),
      ),
    );
  }
}

typedef CheckBoxBuilder = Widget Function(bool checked);

class CommonCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final CheckBoxBuilder checkBoxBuilder;

  CommonCheckBox({
    key,
    this.value,
    this.onChanged,
    @required this.checkBoxBuilder,
  }) : super(key: key);

  @override
  _CommonCheckBoxState createState() {
    return _CommonCheckBoxState();
  }
}

class _CommonCheckBoxState extends State<CommonCheckBox> {
  bool _checked;
  Widget _child;

  @override
  void initState() {
    _checked = widget.value ?? false;
    _callCheckBoxBuilder();
    super.initState();
  }

  void _callCheckBoxBuilder() {
    if (widget.checkBoxBuilder != null) {
      _child = widget.checkBoxBuilder(_checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked = !_checked;
          if (widget.onChanged != null) {
            widget.onChanged(_checked);
          }
          _callCheckBoxBuilder();
        });
      },
      child: _child ?? Text('null'),
    );
  }
}
