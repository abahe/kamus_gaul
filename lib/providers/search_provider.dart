import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kamus_model.dart';
import '../services/api_service.dart';
import 'home_provider.dart';

final searchDataProvider = StateNotifierProvider<SearchNotifier, SearchState>((
  ref,
) {
  final apiService = ref.watch(apiServiceProvider);
  return SearchNotifier(apiService);
});

class SearchNotifier extends StateNotifier<SearchState> {
  final ApiService _api;
  Timer? _debounce;

  SearchNotifier(this._api) : super(const SearchState());

  void onSearchChanged(String value) {
    state = state.copyWith(query: value);
    _debounce?.cancel();

    if (value.trim().isEmpty) {
      state = state.copyWith(results: [], total: 0, hasSearched: false);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      search(value.trim());
    });
  }

  Future<void> search(String q) async {
    if (q.isEmpty) return;

    state = state.copyWith(isLoading: true, hasSearched: true);
    try {
      final data = await _api.searchKamus(query: q);
      state = state.copyWith(
        isLoading: false,
        results: data['items'] as List<KamusModel>,
        total: data['total'] ?? 0,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        results: [],
        error: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

class SearchState {
  final bool isLoading;
  final List<KamusModel> results;
  final String query;
  final int total;
  final bool hasSearched;
  final String? error;

  const SearchState({
    this.isLoading = false,
    this.results = const [],
    this.query = '',
    this.total = 0,
    this.hasSearched = false,
    this.error,
  });

  SearchState copyWith({
    bool? isLoading,
    List<KamusModel>? results,
    String? query,
    int? total,
    bool? hasSearched,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      query: query ?? this.query,
      total: total ?? this.total,
      hasSearched: hasSearched ?? this.hasSearched,
      error: error,
    );
  }
}
