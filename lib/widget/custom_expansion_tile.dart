import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/common/constant/style.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key key,
    @required this.title,
    this.titlePadding,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.indicator,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final String title;
  final EdgeInsetsGeometry titlePadding;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Widget indicator;
  final bool initiallyExpanded;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _headerColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _headerColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
        GestureDetector(
          onTap: _handleTap,
          child: Padding(
            padding: widget.titlePadding ?? const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    color: _headerColor.value,
                    fontSize: Dimens.sp_28,
                  ),
                ),
                widget.indicator ??
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: _headerColor.value,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    _headerColorTween
      ..begin = Colours.textThird
      ..end = Colours.textSecond;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}

class ExpandTile extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry titlePadding;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Widget indicator;
  final bool initiallyExpanded;
  final int maxNum = 3;

  const ExpandTile({
    Key key,
    @required this.title,
    this.titlePadding,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.indicator,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return SizedBox(
        height: 0,
      );
    }
    return Column(
      children: _contentWidget(children),
    );
  }

  List<Widget> _contentWidget(List<Widget> elements) {
    List<Widget> list = [];
    for (int i = 0; i < elements.length; i++) {
      if (i >= maxNum) break;
      Widget ele = elements[i];
      list.add(ele);
    }
    Widget last = Offstage(
      offstage: children.length <= maxNum ? true : false,
      child: CustomExpansionTile(
        title: title,
        titlePadding: titlePadding,
        indicator: indicator,
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: onExpansionChanged,
        children: children.length > maxNum ? children.sublist(maxNum) : null,
      ),
    );
    list.add(last);
    return list;
  }
}
