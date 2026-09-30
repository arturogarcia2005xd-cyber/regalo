import 'package:flutter/material.dart';

class LetterScreen extends StatefulWidget {
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  bool _isEnvelopeOpen = false;

  // Texto dedicatorio para los 17 años de Lucía
  final String _letterContent = '''
¡Felices 17 años, Lucía! 🎉✨

Hoy celebras un año más de vida, y quería regalarte algo único, pensado especialmente para ti. 

Desde tu amor por el mar navegando al estilo de Ponyo y el universo mágico de Ghibli, hasta esos momentos dulces horneando deliciosas galletas o la calma que transmiten los tulipanes. Todo en esta pequeña aplicación fue programado para sacarte una sonrisa.

Deseo que este nuevo año de vida venga lleno de recetas perfectas, historias mágicas, risas y momentos inolvidables. Gracias por ser esa persona tan especial y llenar de luz a todos los que te rodean.

¡Disfruta mucho tu día! 🥳🍰🌷
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Azul noche / océano profundo
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Carta para Lucía 💌',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 1. SOBRE INTERACTIVO
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEnvelopeOpen = !_isEnvelopeOpen;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 280,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A), // Azul océano
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF93C5FD).withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: _isEnvelopeOpen ? 0.8 : 1.0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2C94C), // Dorado
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: const Text('🌷', style: TextStyle(fontSize: 32)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _isEnvelopeOpen ? '¡Haz tap para cerrar!' : 'Tócame para abrir 💌',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. CARTA DESPLEGABLE CON HOJA DE PERGAMINO
            Expanded(
              child: AnimatedCrossFade(
                firstChild: const Center(
                  child: Text(
                    'Toca el sobre con el tulipán para abrir la carta... 🌷',
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ),
                secondChild: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDF7), // Pergamino
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('🌷', style: TextStyle(fontSize: 20)),
                            Text(
                              '17 Años ✨',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                            Text('🌷', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        const Divider(height: 24, thickness: 1, color: Color(0xFFE2E8F0)),
                        SelectableText(
                          _letterContent,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.8,
                            color: Color(0xFF2D3748),
                            fontFamily: 'Serif',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                crossFadeState: _isEnvelopeOpen
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}