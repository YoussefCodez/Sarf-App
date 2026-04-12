class PageViewState {
  final int pageIndex;
  final int totalPages;

  PageViewState({required this.pageIndex, required this.totalPages});

  PageViewState copyWith({int? pageIndex, int? totalPages}) {
    return PageViewState(
      pageIndex: pageIndex ?? this.pageIndex,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}