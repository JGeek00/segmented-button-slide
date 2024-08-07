import 'package:flutter/material.dart';

import 'package:segmented_button_slide/segmented_button_slide.dart';

void main() {
  runApp(const SegmentedButtonDemo());
}

class SegmentedButtonDemo extends StatefulWidget {
  const SegmentedButtonDemo({super.key});

  @override
  State<SegmentedButtonDemo> createState() => _SegmentedButtonDemoState();
}

class _SegmentedButtonDemoState extends State<SegmentedButtonDemo> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Segmented Button Demo',
        home: Scaffold(
          body: Center(
              child: FractionallySizedBox(
            widthFactor: 0.5,
            child: SegmentedButtonSlide(
              entries: const [
                SegmentedButtonSlideEntry(
                  icon: Icons.home_rounded,
                  label: "Home",
                ),
                SegmentedButtonSlideEntry(
                  icon: Icons.list_rounded,
                  label: "List",
                ),
                SegmentedButtonSlideEntry(
                  icon: Icons.settings_rounded,
                  label: "Settings",
                ),
              ],
              selectedEntry: _selected,
              onChange: (selected) => setState(() => _selected = selected),
              colors: SegmentedButtonSlideColors(
                barColor: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5),
                backgroundSelectedColor:
                    Theme.of(context).colorScheme.primaryContainer,
              ),
              slideShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(1),
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ],
              margin: const EdgeInsets.all(16),
              height: 70,
              padding: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(8),
              selectedTextStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
              unselectedTextStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
              hoverTextStyle: const TextStyle(
                color: Colors.orange,
              ),
            ),
          )),
        ));
  }
}
