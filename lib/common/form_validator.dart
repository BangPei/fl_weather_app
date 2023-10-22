class ValidForm {
  static String? emptyValue(String? value) {
    if (value!.isEmpty) {
      return "value could not be empty";
    }
    return null;
  }

  static String? matchValue(String? value, String? data, String title) {
    if (value!.isEmpty) {
      return "value could not be empty";
    } else {
      if (value != data) {
        return "$title Not match";
      }
    }
    return null;
  }
}
