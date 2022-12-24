extension NumberParsing on String {
  int parseInt() {
    // ignore: unnecessary_this
    if (this.isEmpty) {
      return 0;
    }
    return int.parse(this);
  }
}
