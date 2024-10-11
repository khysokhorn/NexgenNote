extension EnumExtension on Enum {
  String getName() {
    return toString().split('.')[1];
  }
}
