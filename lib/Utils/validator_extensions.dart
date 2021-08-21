extension EmailValidator on String {
  bool isEmail() {
    if (this == null || this.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }
}