String removeCharAtIndex(String str, int index) {
  // Trả về chuỗi mới bằng cách nối các phần tử từ 0 đến index và từ index + 1 đến cuối chuỗi
  return str.substring(0, index) + str.substring(index + 1);
}
