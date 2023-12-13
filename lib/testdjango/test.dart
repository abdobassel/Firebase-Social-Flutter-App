import "dart:convert";

import "package:http/http.dart" as http;

void getdatatest() async {
  var response = await http.get(Uri.parse('http://10.0.2.2:8000/core/a'));

  //var pdfText = await json.decode(json.encode(response.body));
  var pdfText = await jsonDecode(response.body);
  print(pdfText);
}
//AllowedHosts ing setting django ['*',]

/*
https://stackoverflow.com/questions/55671441/flutter-formatexception-unexpected-character-at-character-1

https://stackoverflow.com/questions/68663089/flutter-formatexception-unexpected-character-at-character-1-html
https://stackoverflow.com/questions/57545934/you-may-need-to-add-u127-0-0-1-to-allowed-hosts

ALLOWED_HOSTS=['<your host ip address>',]
or

ALLOWED_HOSTS=['*',]

*/ 