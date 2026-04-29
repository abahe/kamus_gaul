import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';
import '../providers/favorite_provider.dart';
import '../models/kamus_model.dart';
import 'detail_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cari Kata')),
      // bottomNavigationBar: const BannerAdWidget(),
      body: Column(
        children: [
          // Search input
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                ref.read(searchDataProvider.notifier).onSearchChanged(value);
              },
              decoration: InputDecoration(
                hintText: 'Ketik kata gaul...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: searchState.query.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          ref
                              .read(searchDataProvider.notifier)
                              .onSearchChanged('');
                        },
                        icon: const Icon(Icons.close_rounded),
                      )
                    : const SizedBox(),
              ),
            ),
          ),

          // Results
          Expanded(
            child: Builder(
              builder: (context) {
                if (searchState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!searchState.hasSearched) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Cari kata gaul favoritmu',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (searchState.results.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied_rounded,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Kata "${searchState.query}" tidak ditemukan',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            '${searchState.total} hasil ditemukan',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: searchState.results.length,
                        itemBuilder: (context, index) {
                          final item = searchState.results[index];
                          return _SearchResultCard(item: item);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultCard extends ConsumerWidget {
  final KamusModel item;

  const _SearchResultCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final favoriteState = ref.watch(favoriteDataProvider);
    final isFav = favoriteState.favoriteIds.contains(item.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailScreen(kamus: item)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    item.kata.isNotEmpty ? item.kata[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.kata,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.arti,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(favoriteDataProvider.notifier).toggleFavorite(item);
                },
                icon: Icon(
                  isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFav ? const Color(0xFFFF6B6B) : Colors.grey.shade400,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
