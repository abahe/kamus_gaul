import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kamus_model.dart';
import '../services/db_helper.dart';

final dbHelperProvider = Provider((ref) => DbHelper());

final favoriteDataProvider =
    StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
      final dbHelper = ref.watch(dbHelperProvider);
      return FavoriteNotifier(dbHelper);
    });

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final DbHelper _db;

  FavoriteNotifier(this._db) : super(const FavoriteState()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true);
    try {
      final list = await _db.getFavorites();
      final ids = list.map((e) => e.id).toSet();

      state = state.copyWith(
        isLoading: false,
        favorites: list,
        favoriteIds: ids,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  bool isFavorite(int id) => state.favoriteIds.contains(id);

  Future<void> toggleFavorite(KamusModel kamus) async {
    try {
      if (isFavorite(kamus.id)) {
        await _db.removeFavorite(kamus.id);

        final newIds = {...state.favoriteIds};
        newIds.remove(kamus.id);

        final newFavorites = state.favorites
            .where((e) => e.id != kamus.id)
            .toList();

        state = state.copyWith(
          favorites: newFavorites,
          favoriteIds: newIds,
          removeMessage: '"${kamus.kata}" dihapus dari favorit',
        );
      } else {
        await _db.addFavorite(kamus);

        final newIds = {...state.favoriteIds};
        newIds.add(kamus.id);

        var newFavorites = [...state.favorites, kamus];
        newFavorites.sort((a, b) => a.kata.compareTo(b.kata));

        state = state.copyWith(
          favorites: newFavorites,
          favoriteIds: newIds,
          addMessage: '"${kamus.kata}" ditambahkan ke favorit',
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<List<KamusModel>> searchFavorites(String query) async {
    if (query.isEmpty) return state.favorites;
    try {
      return await _db.searchFavorites(query);
    } catch (e) {
      return [];
    }
  }

  void clearMessages() {
    state = state.copyWith(addMessage: null, removeMessage: null);
  }
}

class FavoriteState {
  final bool isLoading;
  final List<KamusModel> favorites;
  final Set<int> favoriteIds;
  final String? addMessage;
  final String? removeMessage;
  final String? error;

  const FavoriteState({
    this.isLoading = false,
    this.favorites = const [],
    this.favoriteIds = const {},
    this.addMessage,
    this.removeMessage,
    this.error,
  });

  FavoriteState copyWith({
    bool? isLoading,
    List<KamusModel>? favorites,
    Set<int>? favoriteIds,
    String? addMessage,
    String? removeMessage,
    String? error,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      addMessage: addMessage,
      removeMessage: removeMessage,
      error: error,
    );
  }
}
