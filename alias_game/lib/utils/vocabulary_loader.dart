import 'package:flutter/services.dart';

const String filePath = "data/vocab.txt";

Future<String> _loadAsset() async {
    return await rootBundle.loadString(filePath);
}


Future<List<String>> loadVocabulary() async {
    var fileContent = _loadAsset().then((value)=>value.split('\n'));

    return fileContent;
}