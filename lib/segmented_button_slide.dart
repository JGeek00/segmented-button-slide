library segmented_button_slide;

import 'package:flutter/material.dart';

class SegmentedButtonSlideEntry {
  /// [icon] defines the icon of the tile
  final IconData? icon;

  /// [icon] defines the label of the tile
  final String? label;

  const SegmentedButtonSlideEntry({
    this.icon,
    this.label,
  });
}

class SegmentedButtonSlideColors {
  /// [barColor] defines the background color of the full bar.
  final Color barColor;

  /// [backgroundSelectedColor] defines the background color of the item that's currently selected.
  final Color backgroundSelectedColor;

  /// [foregroundSelectedColor] defines the color of the icon and text of the item that's currently selected.
  final Color foregroundSelectedColor;

  /// [foregroundUnselectedColor] defines the color of the icon and text of the items that aren't selected.
  final Color foregroundUnselectedColor;

  /// [hoverColor] defines the color of the icon and text when the mouse is over that entry.
  final Color hoverColor;

  const SegmentedButtonSlideColors({
    required this.barColor,
    required this.backgroundSelectedColor,
    required this.foregroundSelectedColor,
    required this.foregroundUnselectedColor,
    required this.hoverColor,
  });
}

class SegmentedButtonSlide extends StatelessWidget {
  /// [entries] accepts a list of SegmentedButtonSlideEntry.
  /// Each SegmentedButtonSlideEntry is formed by an icon and a label.
  /// You must declare at least one of the two
  final List<SegmentedButtonSlideEntry> entries;

  /// [selectedEntry] accepts an int. Defines the item that's currently selected.
  final int selectedEntry;

  /// [onChange] returns the selected value when the user changes the selection.
  final void Function(int) onChange;

  /// [colors] accepts an instance of SegmentedButtonSlideColors.
  /// All of it's attributes are mandatory.
  final SegmentedButtonSlideColors colors;

  /// [animationDuration] defines the duration of all the animations of the widget.
  /// By default it's set to 250 milliseconds.
  final Duration animationDuration;

  /// [curve] defines the curve of all the animations of the widget.
  /// By default it's set to ease.
  final Curve curve;

  /// [slideShadow] defines the boxShadow of the slider (item that's currently selected).
  final List<BoxShadow>? slideShadow;

  /// [barShadow] defines the boxShadow of the full bar (the background).
  final List<BoxShadow>? barShadow;

  /// [margin] creates a margin around the whole widget.
  final EdgeInsets? margin;

  /// [height] defines the height of the widget.
  final double height;

  /// [fontSize] sets the fontSize of the text. It doesn't affect to the icon.
  final double? fontSize;

  /// [iconSize] sets the size of the icon. It doesn't affect to the text.
  final double? iconSize;

  /// [textOverflow] defines how the text (only) should overflow.
  final TextOverflow textOverflow;

  const SegmentedButtonSlide({
    super.key,
    required this.entries,
    required this.selectedEntry,
    required this.onChange,
    required this.colors,
    this.animationDuration = const Duration(milliseconds: 250),
    this.curve = Curves.ease,
    this.slideShadow,
    this.barShadow,
    this.margin,
    this.height = 50,
    this.fontSize,
    this.iconSize,
    this.textOverflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Center(
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height),
            color: colors.barColor,
            boxShadow: barShadow,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                AnimatedPositioned(
                  duration: animationDuration,
                  curve: curve,
                  left:
                      (constraints.maxWidth / entries.length) * (selectedEntry),
                  child: Container(
                    height: height,
                    width: constraints.maxWidth / entries.length,
                    decoration: BoxDecoration(
                      color: colors.backgroundSelectedColor,
                      borderRadius: BorderRadius.circular(height),
                      boxShadow: slideShadow,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: entries
                      .asMap()
                      .entries
                      .map(
                        (e) => _ButtonEntry(
                          index: e.key,
                          entry: e.value,
                          onSelect: onChange,
                          isSelected: e.key == selectedEntry,
                          colors: colors,
                          animationDuration: animationDuration,
                          height: height,
                          curve: curve,
                          fontSize: fontSize,
                          iconSize: iconSize,
                          textOverflow: textOverflow,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonEntry extends StatefulWidget {
  final int index;
  final SegmentedButtonSlideEntry entry;
  final void Function(int) onSelect;
  final bool isSelected;
  final SegmentedButtonSlideColors colors;
  final Duration animationDuration;
  final Curve curve;
  final double height;
  final double? fontSize;
  final double? iconSize;
  final TextOverflow textOverflow;

  const _ButtonEntry({
    required this.index,
    required this.entry,
    required this.onSelect,
    required this.isSelected,
    required this.colors,
    required this.animationDuration,
    required this.curve,
    required this.height,
    required this.fontSize,
    required this.iconSize,
    required this.textOverflow,
  });

  @override
  State<_ButtonEntry> createState() => _ButtonEntryState();
}

class _ButtonEntryState extends State<_ButtonEntry>
    with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    if (widget.entry.label == null && widget.entry.icon == null) {
      throw Exception("No icon or label specified.");
    }

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => widget.onSelect(widget.index),
            onHover: (v) => setState(() => _hover = v),
            child: SizedBox(
              height: widget.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.entry.icon != null)
                    _AnimatedIcon(
                      icon: widget.entry.icon!,
                      activeColor: widget.colors.foregroundSelectedColor,
                      normalColor: widget.colors.foregroundUnselectedColor,
                      hoverColor: widget.colors.hoverColor,
                      isActive: widget.isSelected,
                      isHover: _hover,
                      size: widget.iconSize,
                      duration: widget.animationDuration,
                      curve: widget.curve,
                    ),
                  if (widget.entry.label != null && widget.entry.icon != null)
                    const SizedBox(width: 12),
                  if (widget.entry.label != null)
                    AnimatedDefaultTextStyle(
                      duration: widget.animationDuration,
                      curve: widget.curve,
                      style: TextStyle(
                        color: widget.isSelected
                            ? widget.colors.foregroundSelectedColor
                            : _hover
                                ? widget.colors.hoverColor
                                : widget.colors.foregroundUnselectedColor,
                        fontWeight: widget.isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        fontSize: widget.fontSize,
                      ),
                      child: Flexible(
                        child: Text(
                          widget.entry.label!,
                          overflow: widget.textOverflow,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  final IconData icon;
  final Color activeColor;
  final Color normalColor;
  final Color hoverColor;
  final bool isActive;
  final bool isHover;
  final double? size;
  final Duration duration;
  final Curve curve;

  const _AnimatedIcon({
    Key? key,
    required this.icon,
    required this.activeColor,
    required this.normalColor,
    required this.hoverColor,
    required this.isActive,
    required this.isHover,
    this.size,
    required this.duration,
    required this.curve,
  }) : super(key: key);

  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon>
    with TickerProviderStateMixin {
  late AnimationController _activeController;
  late AnimationController _hoverController;
  late Animation<Color?> _activeAnimation;
  late Animation<Color?> _hoverAnimation;

  @override
  void initState() {
    super.initState();

    _activeController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _activeAnimation = ColorTween(
      begin: widget.normalColor,
      end: widget.activeColor,
    ).animate(CurvedAnimation(parent: _activeController, curve: widget.curve))
      ..addListener(() => setState(() => {}));

    _hoverController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _hoverAnimation = ColorTween(
      begin: widget.normalColor,
      end: widget.hoverColor,
    ).animate(CurvedAnimation(parent: _hoverController, curve: widget.curve))
      ..addListener(() => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActive) {
      _activeController.forward();
    } else {
      _activeController.reverse();
    }

    if (widget.isHover && !widget.isActive) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }

    return Icon(
      widget.icon,
      color: _activeController.isAnimating
          ? _activeAnimation.value
          : _hoverController.isAnimating
              ? _hoverAnimation.value
              : widget.isActive
                  ? widget.activeColor
                  : widget.isHover
                      ? widget.hoverColor
                      : widget.normalColor,
      size: widget.size,
    );
  }
}
