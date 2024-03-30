String removeCharAtIndex(String str, int index) {
   // Trả về chuỗi mới bằng cách nối các phần tử từ 0 đến index và từ index + 1 đến cuối chuỗi
  return str.substring(0, index) + str.substring(index + 1);
 // otp 123456 : 12346
}


String replaceCharAtIndex(String str, int index, String char) {
  return str.replaceRange(index, index + 1, char);
}
