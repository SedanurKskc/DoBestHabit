import 'package:flutter/material.dart';

class TextParser {
  // Metni belirli desenlere göre parçalayan ve her parçaya uygun stil uygulayan statik fonksiyon.
  static List<TextSpan> parseMessage(String text) {
    final boldPattern = RegExp(r'\* \*\*.*?(?=\n|$)');
    final italicPattern = RegExp(r'\*.*?(?=\n|$)');

    List<TextSpan> spans = [];
    int startIndex = 0;

    final boldMatches = boldPattern.allMatches(text);
    final italicMatches = italicPattern.allMatches(text);

    final allMatches = [...boldMatches, ...italicMatches]..sort((a, b) => a.start.compareTo(b.start));

    for (final match in allMatches) {
      if (match.start > startIndex) {
        spans.add(TextSpan(text: text.substring(startIndex, match.start)));
      }

      if (boldPattern.hasMatch(match.group(0)!)) {
        spans.add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: TextStyle(color: Colors.black),
          ),
        );
      } else if (italicPattern.hasMatch(match.group(0)!)) {
        spans.add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        );
      }
      else if (italicPattern.hasMatch(match.group(0)!)) {
        spans.add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        );
      }

      startIndex = match.end;
    }

    if (startIndex < text.length) {
      spans.add(TextSpan(text: text.substring(startIndex)));
    }

    return spans;
  }
}
