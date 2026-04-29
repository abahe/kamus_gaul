import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDarkMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance
          Text(
            'TAMPILAN',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: SwitchListTile(
              title: const Text('Mode Gelap'),
              subtitle: Text(
                isDarkMode ? 'Aktif' : 'Nonaktif',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              secondary: Icon(
                isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: cs.primary,
              ),
              value: isDarkMode,
              onChanged: (_) {
                ref.read(themeNotifierProvider.notifier).toggleTheme();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // About
          Text(
            'TENTANG',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info_outline_rounded, color: cs.primary),
                  title: const Text('Kamus Gaul'),
                  subtitle: const Text('Versi 1.0.0'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: Icon(Icons.book_rounded, color: cs.primary),
                  title: const Text('Tentang Kamus Gaul'),
                  subtitle: const Text(
                    'Kamus bahasa gaul Indonesia. Dari zaman old sampai Gen-Z!. Bisa diakses offline lewat favorit.',
                    style: TextStyle(fontSize: 13),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
