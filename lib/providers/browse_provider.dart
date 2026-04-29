import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kamus_model.dart';
import '../services/api_service.dart';
import 'home_provider.dart';

final browseDataProvider = StateNotifierProvider<BrowseNotifier, BrowseState>((
  ref,
) {
  final apiService = ref.watch(apiServiceProvider);
  return BrowseNotifier(apiService);
});

class BrowseNotifier extends StateNotifier<BrowseState> {
  final ApiService _api;

  BrowseNotifier(this._api) : super(BrowseState()) {
    loadKamus();
  }

  Future<void> loadKamus({bool reset = true}) async {
    int page = reset ? 1 : state.currentPage;
    List<KamusModel> kamusList = reset ? [] : state.kamusList;

    state = state.copyWith(isLoading: true, currentPage: page);
    try {
      final data = await _api.getKamus(
        page: page,
        perPage: 20,
        huruf: state.selectedHuruf.isEmpty ? null : state.selectedHuruf,
      );
      kamusList.addAll(data['items'] as List<KamusModel>);

      state = state.copyWith(
        isLoading: false,
        kamusList: kamusList,
        lastPage: data['last_page'] as int,
        total: data['total'] as int,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;
    if (state.currentPage >= state.lastPage) return;

    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.currentPage + 1;
      final data = await _api.getKamus(
        page: nextPage,
        perPage: 20,
        huruf: state.selectedHuruf.isEmpty ? null : state.selectedHuruf,
      );
      final newList = [...state.kamusList];
      newList.addAll(data['items'] as List<KamusModel>);

      state = state.copyWith(
        isLoadingMore: false,
        kamusList: newList,
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  void filterByHuruf(String huruf) {
    if (state.selectedHuruf == huruf) {
      state = state.copyWith(selectedHuruf: '');
    } else {
      state = state.copyWith(selectedHuruf: huruf);
    }
    loadKamus();
  }
}

class BrowseState {
  final bool isLoading;
  final bool isLoadingMore;
  final List<KamusModel> kamusList;
  final int currentPage;
  final int lastPage;
  final int total;
  final String selectedHuruf;
  final String? error;

  final List<String> alphabet = List.generate(
    26,
    (i) => String.fromCharCode(65 + i),
  );

  BrowseState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.kamusList = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.total = 0,
    this.selectedHuruf = '',
    this.error,
  });

  BrowseState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<KamusModel>? kamusList,
    int? currentPage,
    int? lastPage,
    int? total,
    String? selectedHuruf,
    String? error,
  }) {
    return BrowseState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      kamusList: kamusList ?? this.kamusList,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      selectedHuruf: selectedHuruf ?? this.selectedHuruf,
      error: error,
    );
  }
}
