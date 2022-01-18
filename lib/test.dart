import 'dart:math';
String textForChatIcon(String text) {
  String result = ''; 
  result += text[0];
  result += text[1];
  if (text.length >= 4) {
    if(text[4] != '') {
      result += text[4].toUpperCase(); 
    }
  }
  else if (text.length >= 3) {
    if(text[2] != '') {
      result += text[2];
    }
  }
    return result;
}


    

void main() {
  // print(textForChatIcon('11Б абобус'));
  List colors = ['1'];
}