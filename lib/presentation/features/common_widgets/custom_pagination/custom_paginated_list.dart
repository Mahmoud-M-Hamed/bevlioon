import 'package:bevlioon/presentation/features/common_widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPaginatedList<T> extends StatefulWidget {
  const CustomPaginatedList({
    required this.fetchPage,
    required this.itemBuilder,
    required this.firstPageErrorBuilder,
    required this.noItemsFoundBuilder,
    required this.separatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.nextPageProgressIndicatorBuilder,
    this.noMoreItemsFoundBuilder,
    this.nextPageErrorBuilder,
    super.key,
  });

  final Future<List<T>> Function(int) fetchPage;
  final Widget Function(BuildContext context, T, int, int?) itemBuilder;
  final Widget Function(BuildContext context)?
  firstPageProgressIndicatorBuilder;
  final Widget Function(BuildContext context)? nextPageProgressIndicatorBuilder;
  final Widget Function(BuildContext context, Function)? firstPageErrorBuilder;
  final Widget Function(BuildContext context)? noItemsFoundBuilder;
  final Widget Function(BuildContext context, Function)? nextPageErrorBuilder;
  final Widget Function(BuildContext context)? noMoreItemsFoundBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;

  @override
  State<CustomPaginatedList<T>> createState() => _CustomPaginatedListState<T>();
}

class _CustomPaginatedListState<T> extends State<CustomPaginatedList<T>> {
  late final PagingController<int, T> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController<int, T>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: widget.fetchPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagingListener<int, T>(
      controller: _pagingController,
      builder: (context, state, fetchNextPage) {
        return PagedListView.separated(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: (context, item, index) => widget.itemBuilder(
              context,
              item,
              index,
              (_pagingController.items?.length ?? 0),
            ),
            firstPageErrorIndicatorBuilder: widget.firstPageErrorBuilder != null
                ? (context) => widget.firstPageErrorBuilder!(
                    context,
                    () => _pagingController.refresh(),
                  )
                : null,
            noItemsFoundIndicatorBuilder: widget.noItemsFoundBuilder,
            noMoreItemsIndicatorBuilder: widget.noMoreItemsFoundBuilder,
            newPageErrorIndicatorBuilder: widget.nextPageErrorBuilder != null
                ? (context) => widget.nextPageErrorBuilder!(
                    context,
                    () => fetchNextPage(),
                  )
                : null,
            newPageProgressIndicatorBuilder:
                widget.nextPageProgressIndicatorBuilder ??
                (context) => const Center(child: CustomLoadingWidget()),
            firstPageProgressIndicatorBuilder:
                widget.firstPageProgressIndicatorBuilder ??
                (context) => const Center(child: CustomLoadingWidget()),
          ),
          separatorBuilder: widget.separatorBuilder,
        );
      },
    );
  }
}
