import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lu/core/constants/app_colors.dart';
import 'package:lu/features/tastes/presentation/widgets/floating_bubble_widget.dart';
import 'package:lu/features/tastes/presentation/widgets/ocean_background.dart';

// --- MODELOS DE DATOS ---

class GhibliCardData {
  final String imageUrl;
  final String movieTitle;
  final String quote;

  GhibliCardData({
    required this.imageUrl,
    required this.movieTitle,
    required this.quote,
  });
}

class TasteItem {
  final String title;
  final String subtitle;
  final String fullDescription;
  final IconData icon;
  final Color accentColor;
  final List<String> interactiveDetails;
  final String interactiveTitle;
  final List<GhibliCardData>? ghibliCards;

  TasteItem({
    required this.title,
    required this.subtitle,
    required this.fullDescription,
    required this.icon,
    required this.accentColor,
    required this.interactiveTitle,
    required this.interactiveDetails,
    this.ghibliCards,
  });
}

// --- PANTALLA PRINCIPAL ---

class TastesScreen extends StatefulWidget {
  const TastesScreen({super.key});

  @override
  State<TastesScreen> createState() => _TastesScreenState();
}

class _TastesScreenState extends State<TastesScreen> {
  final List<TasteItem> _tastes = [
    // Burbuja 1: Studio Ghibli
    TasteItem(
      title: 'Studio Ghibli & Ponyo',
      subtitle: 'La magia del océano',
      fullDescription:
      'Como en el mágico mar de Ponyo, donde las olas guardan secretos y la amistad vence a cualquier tormenta. El universo de Studio Ghibli refleja esa luz, inocencia y maravilla que tú traes al mundo.',
      icon: Icons.water_drop_rounded,
      accentColor: AppColors.sereneBlue,
      interactiveTitle: '✨ Películas & Frases para ti:',
      interactiveDetails: [
        '🌊 Valentía como la de Ponyo para explorar el mundo.',
        '🍵 La calidez de un té caliente en un día de lluvia.',
        '✨ Magia oculta en los detalles más pequeños del día a día.',
      ],
      ghibliCards: [
        GhibliCardData(
          movieTitle: 'Ponyo en el acantilado',
          imageUrl: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?auto=format&fit=crop&w=600&q=80',
          quote: '«No importa cuán grandes sean las olas, tu alegría siempre encuentra la forma de brillar.»',
        ),
        GhibliCardData(
          movieTitle: 'El viaje de Chihiro',
          imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80',
          quote: '«Jamás olvides lo lejos que has llegado y lo mágica que es tu esencia al crecer.»',
        ),
        GhibliCardData(
          movieTitle: 'El castillo ambulante',
          imageUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80',
          quote: '«Un corazón es una carga pesada, pero el tuyo siempre sabe llenar de luz a los demás.»',
        ),
        GhibliCardData(
          movieTitle: 'Mi vecino Totoro',
          imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=600&q=80',
          quote: '«Que tus 17 años estén llenos de pequeñas maravillas e instantes inolvidables.»',
        ),
      ],
    ),
    // Burbuja 2: Repostería
    TasteItem(
      title: 'Repostería Casera',
      subtitle: 'Amor horneado',
      fullDescription:
      'El aroma dulce de unos brownies recién horneados o unas galletas hechas con tanto detalle. Cocinar no es solo seguir una receta, es tu forma de regalarle cariño a quienes te rodean.',
      icon: Icons.cookie_rounded,
      accentColor: AppColors.starlightYellow,
      interactiveTitle: '🍪 Receta Secreta de Lucía:',
      interactiveDetails: [
        '🍫 200g de chocolate derretido con mucha paciencia.',
        '✨ Una pizca de magia y dedicación constante.',
        '❤️ El ingrediente principal: compartir con quienes amas.',
      ],
    ),
    // Burbuja 3: Tulipanes
    TasteItem(
      title: 'Azul & Tulipanes',
      subtitle: 'Elegancia y serenidad',
      fullDescription:
      'La tranquilidad profunda de los tonos azules combinada con la delicadeza de los tulipanes en flor. Un reflejo perfecto de tu calma, belleza y personalidad única.',
      icon: Icons.local_florist_rounded,
      accentColor: AppColors.lavenderGlow,
      interactiveTitle: '🌷 Simbolismo de tus 17:',
      interactiveDetails: [
        '💙 Azul: La serenidad y profundidad de tu personalidad.',
        '🌷 Tulipán: El florecer de nuevos sueños en esta etapa.',
        '✨ Brillo: Tu capacidad única de iluminar a los demás.',
      ],
    ),
    // Burbuja 4: Momentos
    TasteItem(
      title: 'Momentos Especiales',
      subtitle: 'Colección de recuerdos',
      fullDescription:
      'Cada risa compartida, las pláticas largas y las pequeñas aventuras se guardan aquí. Cumplir 17 es el inicio de un capítulo lleno de memorias inolvidables por construir.',
      icon: Icons.star_rounded,
      accentColor: const Color(0xFFFFB74D),
      interactiveTitle: '🌟 Deseos para este año:',
      interactiveDetails: [
        '🎉 Que nunca te falten razones para sonreír.',
        '✈️ Nuevos lugares y experiencias por descubrir.',
        '🍰 Muchos pasteles y postres deliciosos por hornear.',
      ],
    ),
  ];

  void _showTasteModal(BuildContext context, TasteItem item) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.oceanDeep.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: item.accentColor.withOpacity(0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: item.accentColor.withOpacity(0.3),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.accentColor.withOpacity(0.2),
                        border: Border.all(color: item.accentColor, width: 2),
                      ),
                      child: Icon(
                        item.icon,
                        size: 38,
                        color: AppColors.starlightYellow,
                      ),
                    ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
                    const SizedBox(height: 12),

                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        color: AppColors.warmWhite,
                      ),
                    ),
                    const SizedBox(height: 4),

                    TabBar(
                      indicatorColor: item.accentColor,
                      labelColor: item.accentColor,
                      unselectedLabelColor: AppColors.mutedText,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'Historia'),
                        Tab(text: 'Detalles ✨'),
                      ],
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 180,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Text(
                              item.fullDescription,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 14,
                                height: 1.5,
                                color: AppColors.warmWhite.withOpacity(0.9),
                              ),
                            ),
                          ),

                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.interactiveTitle,
                                  style: TextStyle(
                                    color: item.accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                if (item.ghibliCards != null && item.ghibliCards!.isNotEmpty)
                                  SizedBox(
                                    height: 140,
                                    child: PageView.builder(
                                      itemCount: item.ghibliCards!.length,
                                      controller: PageController(viewportFraction: 0.85),
                                      itemBuilder: (context, index) {
                                        final ghibli = item.ghibliCards![index];
                                        return Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            image: DecorationImage(
                                              image: NetworkImage(ghibli.imageUrl),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.45),
                                                BlendMode.darken,
                                              ),
                                            ),
                                            border: Border.all(
                                              color: item.accentColor.withOpacity(0.6),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ghibli.movieTitle,
                                                style: const TextStyle(
                                                  color: AppColors.starlightYellow,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                ghibli.quote,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontStyle: FontStyle.italic,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                else
                                  ...item.interactiveDetails.map(
                                        (detail) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.nightNavy.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: item.accentColor.withOpacity(0.2),
                                          ),
                                        ),
                                        child: Text(
                                          detail,
                                          style: const TextStyle(
                                            color: AppColors.warmWhite,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.accentColor,
                        foregroundColor: AppColors.nightNavy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      ),
                      child: const Text(
                        'Cerrar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.8, 0.8)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OceanBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                'El Océano de Lucía',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 24,
                  shadows: [
                    Shadow(
                      color: AppColors.lavenderGlow.withOpacity(0.6),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3, end: 0),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Explora cada burbuja para descubrir sus secretos',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.lavenderGlow,
                    fontSize: 12,
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 800.ms),

              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 20,
                      left: 25,
                      child: FloatingBubbleWidget(
                        title: _tastes[0].title,
                        icon: _tastes[0].icon,
                        accentColor: _tastes[0].accentColor,
                        floatOffset: 0.0,
                        size: 100,
                        onTap: () => _showTasteModal(context, _tastes[0]),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                    Positioned(
                      top: 110,
                      right: 25,
                      child: FloatingBubbleWidget(
                        title: _tastes[1].title,
                        icon: _tastes[1].icon,
                        accentColor: _tastes[1].accentColor,
                        floatOffset: 0.25,
                        size: 110,
                        onTap: () => _showTasteModal(context, _tastes[1]),
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

                    Positioned(
                      bottom: 120,
                      left: 30,
                      child: FloatingBubbleWidget(
                        title: _tastes[2].title,
                        icon: _tastes[2].icon,
                        accentColor: _tastes[2].accentColor,
                        floatOffset: 0.5,
                        size: 100,
                        onTap: () => _showTasteModal(context, _tastes[2]),
                      ),
                    ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

                    Positioned(
                      bottom: 30,
                      right: 35,
                      child: FloatingBubbleWidget(
                        title: _tastes[3].title,
                        icon: _tastes[3].icon,
                        accentColor: _tastes[3].accentColor,
                        floatOffset: 0.75,
                        size: 105,
                        onTap: () => _showTasteModal(context, _tastes[3]),
                      ),
                    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}