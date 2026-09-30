import 'package:flutter/material.dart';

class GhibliBook {
  final String title;
  final String originalTitle;
  final String coverPath;
  final String markdownContent;
  final Color themeColor;
  final String iconEmoji;
  final List<String> storyPages;

  const GhibliBook({
    required this.title,
    required this.originalTitle,
    required this.coverPath,
    required this.markdownContent,
    required this.themeColor,
    this.iconEmoji = '📖',
    this.storyPages = const [],
  });

  // Getters para mantener compatibilidad total con los widgets
  Color get coverColor => themeColor;
  String get japaneseTitle => originalTitle;
}