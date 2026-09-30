import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../models/ghibli_book_model.dart';

class BookReaderScreen extends StatefulWidget {
  final GhibliBook book;

  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // División por capítulos detectando '## '
    final chapters = widget.book.markdownContent
        .split(RegExp(r'\n(?=## )'))
        .where((c) => c.trim().isNotEmpty)
        .toList();

    final totalChapters = chapters.isNotEmpty ? chapters.length : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F5), // Fondo blanco tono papel cálido
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4A3728)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.book.title,
          style: const TextStyle(
            color: Color(0xFF2C1D11),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: totalChapters,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final content = chapters.isNotEmpty
                      ? chapters[index]
                      : widget.book.markdownContent;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    child: MarkdownBody(
                      data: content,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          color: Color(0xFF2C2C2C),
                          fontSize: 17,
                          height: 1.8,
                          fontFamily: 'Times New Roman',
                        ),
                        h1: const TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                          height: 1.5,
                        ),
                        h2: const TextStyle(
                          color: Color(0xFF4A3728),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                          height: 1.5,
                        ),
                        em: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Times New Roman',
                        ),
                        strong: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Indicador de página elegante
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE0D8C8), width: 1),
                ),
              ),
              child: Text(
                'Capítulo ${_currentPage + 1} de $totalChapters',
                style: const TextStyle(
                  color: Color(0xFF7A6855),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}