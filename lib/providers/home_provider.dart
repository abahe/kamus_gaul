import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kamus_model.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final homeDataProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return HomeNotifier(apiService);
});

class HomeNotifier extends StateNotifier<HomeState> {
  final ApiService _api;

  HomeNotifier(this._api) : super(const HomeState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _api.getRandomKamus(count: 6),
        _api.getStats(),
      ]);
      final randomWords = results[0] as List<KamusModel>;
      final stats = results[1] as Map<String, dynamic>;
      final totalKata = stats['total_kata'] ?? 0;

      state = state.copyWith(
        isLoading: false,
        randomWords: randomWords,
        totalKata: totalKata,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refreshRandom() async {
    try {
      final newWords = await _api.getRandomKamus(count: 6);
      state = state.copyWith(randomWords: newWords);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

class HomeState {
  final bool isLoading;
  final List<KamusModel> randomWords;
  final int totalKata;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.randomWords = const [],
    this.totalKata = 0,
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    List<KamusModel>? randomWords,
    int? totalKata,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      randomWords: randomWords ?? this.randomWords,
      totalKata: totalKata ?? this.totalKata,
      error: error,
    );
  }
}
