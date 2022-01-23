import 'dart:io';

class FetchWords {
  static List<String> getWords() {

    // Get all the words from the file
    var file = File('words.json');

    // Convert into string
    var words = file.readAsStringSync();

    // Remove the leading and the training square brackets
    words = words.substring(1, words.length - 1);

    // Replace double quotes with empty string and spaces with commas
    words = words.replaceAll(' ', '');
    words = words.replaceAll('"', '');

    // Get the list of words
    var wordsList = words.split(',');
    return wordsList;
  }
}