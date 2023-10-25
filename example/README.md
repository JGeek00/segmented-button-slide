# Segmented Button Slide

#### Example
```dart
int selectedOption = 0;

...

SegmentedButtonSlide(
  entries: const [
    SegmentedButtonSlideEntry(icon: Icons.home_rounded, label: "Home"),
    SegmentedButtonSlideEntry(icon: Icons.list_rounded, label: "List"),
    SegmentedButtonSlideEntry(icon: Icons.settings_rounded, label: "Settings"),
  ], 
  selectedEntry: selectedOption, 
  onChange: (selected) => setState(() => selectedOption = selected),
  colors: SegmentedButtonSlideColors(
    barColor: Colors.grey.withOpacity(0.2),
    backgroundSelectedColor: Colors.grey, 
    foregroundSelectedColor: Colors.white, 
    foregroundUnselectedColor: Colors.black, 
    hoverColor: Colors.grey.withOpacity(0.8)
  ),
  slideShadow: [
    BoxShadow(
      color: Colors.grey,
      blurRadius: 5,
      spreadRadius: 1
    )
  ],
  margin: const EdgeInsets.all(16),
  height: 70,
)
```