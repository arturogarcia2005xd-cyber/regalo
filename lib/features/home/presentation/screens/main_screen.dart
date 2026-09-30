import 'package:flutter/material.dart';

// 1. Jardín
import 'package:lu/features/garden/presentation/screen/garden_screen.dart';

// 2. Cocina (corregido a 'screens' en plural)
import 'package:lu/features/kitchen/presentation/screens/kitchen_game_screen.dart';

// 3. Mundo Mágico (corregido subiendo 3 niveles con ../../../)
import 'package:lu/features/magic_world/presentation/screen/magic_world_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F5),
      appBar: AppBar(
        title: const Text(
          'Regalo para Lucía',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C1D11),
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          children: [
            const Text(
              'Selecciona una sección',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7A6855),
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontFamily: 'Times New Roman',
              ),
            ),
            const SizedBox(height: 20),

            // 1. Biblioteca / Mundo Mágico
            _buildMenuOption(
              context,
              title: 'Biblioteca Mágica',
              subtitle: 'Libros e historias de Ghibli para leer',
              icon: Icons.auto_stories,
              accentColor: Colors.amber.shade800,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MagicWorldScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // 2. Jardín Encantado
            _buildMenuOption(
              context,
              title: 'Jardín Encantado',
              subtitle: 'Ramos de flores animadas dibujados por código',
              icon: Icons.local_florist,
              accentColor: const Color(0xFFE91E63),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GardenScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // 3. La Cocina
            _buildMenuOption(
              context,
              title: 'La Cocina',
              subtitle: 'Recetas y minijuegos mágicos de cocina',
              icon: Icons.soup_kitchen,
              accentColor: const Color(0xFFFF9800),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KitchenGameScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color accentColor,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFFFFFDF9),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: accentColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        color: Color(0xFF2C1D11),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        fontFamily: 'Times New Roman',
                        color: Color(0xFF7A6855),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFC0B29A),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}