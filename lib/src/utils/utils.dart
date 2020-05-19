class Utils {
  isFieldEmpty(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }
}
