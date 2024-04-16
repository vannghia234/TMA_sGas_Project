String transformPhoneNumber(String phoneNumber) {
  String? result;
  if (phoneNumber.startsWith("+84")) {
    return result = "0${phoneNumber.substring(3)}";
  }
  result = phoneNumber;
  return result;
}
