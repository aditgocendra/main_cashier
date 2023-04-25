class ColorAppEntity {
  int id;
  int primary;
  int primaryLight;
  int background;
  int canvas;
  int border;

  ColorAppEntity({
    required this.id,
    required this.primary,
    required this.primaryLight,
    required this.background,
    required this.canvas,
    required this.border,
  });

  getIndex(int index) {
    switch (index) {
      case 0:
        return primary;
      case 1:
        return primaryLight;
      case 2:
        return background;
      case 3:
        return canvas;
      case 4:
        return border;
    }
  }
}
