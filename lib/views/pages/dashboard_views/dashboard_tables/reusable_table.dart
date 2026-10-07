import 'package:anyamar/commons/exports.dart';

class ReusableDataTableWidget<T> extends ConsumerStatefulWidget {
  final List<T> items;

  /// Builds the table columns.
  final List<DataColumn> columns;

  /// Builds a row for each item.
  final DataRow Function(T item, int index) rowBuilder;

  /// Search callback.
  ///
  /// The parent decides how an item should be searched.
  final bool Function(T item, String query)? searchMatcher;

  final String searchHint;

  /// Whether to show the search field.
  final bool showSearch;

  /// Whether to show the filter button.
  final bool showFilter;

  /// Whether to show the export button.
  final bool showExport;

  final VoidCallback? onFilterPressed;
  final VoidCallback? onExportPressed;

  final int initialRowsPerPage;
  final List<int> availableRowsPerPage;

  final double horizontalMargin;
  final double columnSpacing;

  final double headingRowHeight;
  final double dataRowMinHeight;
  final double dataRowMaxHeight;

  final Widget? emptyWidget;
  final String? cardTitle;
  final Widget? cardTitleButtonWidget;

  const ReusableDataTableWidget({
    super.key,
    required this.items,
    required this.columns,
    required this.rowBuilder,
    this.searchMatcher,
    this.searchHint = 'Search...',
    this.showSearch = true,
    this.showFilter = true,
    this.showExport = true,
    this.onFilterPressed,
    this.onExportPressed,
    this.initialRowsPerPage = 10,
    this.availableRowsPerPage = const [5, 10, 20, 50],
    this.horizontalMargin = 10,
    this.columnSpacing = 6,
    this.headingRowHeight = 40,
    this.dataRowMinHeight = 50,
    this.dataRowMaxHeight = 50,
    this.emptyWidget,
    this.cardTitle,
    this.cardTitleButtonWidget
  });

  @override
  ConsumerState<ReusableDataTableWidget<T>> createState() =>
      _ReusableDataTableWidgetState<T>();
}

class _ReusableDataTableWidgetState<T>
    extends ConsumerState<ReusableDataTableWidget<T>> {
  late int rowsPerPage;

  int currentPage = 0;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    rowsPerPage =
        widget.availableRowsPerPage.contains(widget.initialRowsPerPage)
        ? widget.initialRowsPerPage
        : widget.availableRowsPerPage.first;
  }

  List<T> get filteredItems {
    if (searchQuery.trim().isEmpty || widget.searchMatcher == null) {
      return widget.items;
    }

    final query = searchQuery.trim().toLowerCase();

    return widget.items
        .where((item) => widget.searchMatcher!(item, query))
        .toList();
  }

  List<T> get currentPageItems {
    final items = filteredItems;

    final startIndex = currentPage * rowsPerPage;

    if (startIndex >= items.length) {
      return [];
    }

    final endIndex = (startIndex + rowsPerPage).clamp(0, items.length);

    return items.sublist(startIndex, endIndex);
  }

  int get totalPages {
    if (filteredItems.isEmpty) {
      return 1;
    }

    return (filteredItems.length / rowsPerPage).ceil();
  }

  void _changeRowsPerPage(int value) {
    setState(() {
      rowsPerPage = value;
      currentPage = 0;
    });
  }

  void _changePage(int page) {
    if (page < 0 || page >= totalPages) {
      return;
    }

    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final pageItems = currentPageItems;

    return Container(
      decoration: BoxDecoration(
        color: themeIsDark == true
            ? AppColors.darkElevatedCard
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: themeIsDark == true
              ? AppColors.darkBorder
              : const Color(0xffE5EAF1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //CARD TITILE AND ACTION BUTTONS
          widget.cardTitle != null
              ? Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cardTitle!,
                        style: AppTextStylesConstant.cardDescriptionStyle
                            .copyWith(
                              color: themeIsDark == true
                                  ? AppColors.whiteColor
                                  : AppColors.blueGreyColor,
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                            ),
                      ),
                      widget.cardTitleButtonWidget ??  SizedBox.shrink(),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          CustomDividerWidget(),
          // --------------------------------------------------
          // SEARCH / FILTER / EXPORT
          // --------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 700;

                if (isSmallScreen) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.showSearch)
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: _buildSearchField(),
                        ),

                      if (widget.showSearch &&
                          (widget.showFilter || widget.showExport))
                        const SizedBox(height: 10),

                      // Wrap(
                      //   spacing: 10,
                      //   runSpacing: 10,
                      //   children: [
                      //     if (widget.showFilter) _buildFilterButton(),

                      //     if (widget.showExport) _buildExportButton(),
                      //   ],
                      // ),
                    ],
                  );
                }

                return Row(
                  children: [
                    if (widget.showSearch)
                      SizedBox(
                        width: 360,
                        height: 42,
                        child: _buildSearchField(),
                      ),

                    if (widget.showSearch &&
                        (widget.showFilter || widget.showExport))
                      const SizedBox(width: 12),

                    // if (widget.showFilter) _buildFilterButton(),
                    const Spacer(),

                    // if (widget.showExport) _buildExportButton(),
                  ],
                );
              },
            ),
          ),

          const Divider(height: 1),

          // --------------------------------------------------
          // TABLE
          // --------------------------------------------------
          if (pageItems.isEmpty)
            widget.emptyWidget ??
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'No records found',
                      style: TextStyle(color: Color(0xff718096), fontSize: 14),
                    ),
                  ),
                )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      headingRowHeight: widget.headingRowHeight,
                      dataRowMinHeight: widget.dataRowMinHeight,
                      dataRowMaxHeight: widget.dataRowMaxHeight,
                      horizontalMargin: widget.horizontalMargin,
                      columnSpacing: widget.columnSpacing,

                      headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff44506A),
                        fontSize: 13,
                      ),

                      columns: widget.columns,

                      rows: pageItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;

                        final actualIndex = currentPage * rowsPerPage + index;

                        return widget.rowBuilder(item, actualIndex);
                      }).toList(),
                    ),
                  ),
                );
              },
            ),

          const Divider(height: 1),

          // --------------------------------------------------
          // PAGINATION
          // --------------------------------------------------
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
          currentPage = 0;
        });
      },
      decoration: CustomInputDecoration.textInputDecoration(
        hintText: widget.searchHint,
        prefixIcon: const Icon(Icons.search, size: 20),
      ),
      // decoration: InputDecoration(
      //   hintText: widget.searchHint,
      //   prefixIcon: const Icon(Icons.search, size: 20),
      //   contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(7),
      //     borderSide: const BorderSide(color: Color(0xffDDE3EC)),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(7),
      //     borderSide: const BorderSide(color: Color(0xffDDE3EC)),
      //   ),
      // ),
    );
  }

  // Widget _buildFilterButton() {
  //   return OutlinedButton.icon(
  //     onPressed: widget.onFilterPressed,
  //     icon: const Icon(Icons.filter_alt_outlined, size: 18),
  //     label: const Text('Filter', style: CustomTextStyles.cardDescriptionStyle),
  //   );
  // }

  // Widget _buildExportButton() {
  //   return OutlinedButton.icon(
  //     onPressed: widget.onExportPressed,
  //     icon: const Icon(Icons.download_outlined, size: 18),
  //     label: const Text('Export', style: CustomTextStyles.cardDescriptionStyle),
  //   );
  // }

  Widget _buildPagination() {
    final totalItems = filteredItems.length;

    if (totalItems == 0) {
      return const SizedBox(height: 60);
    }

    final start = currentPage * rowsPerPage + 1;

    final end = ((currentPage + 1) * rowsPerPage).clamp(0, totalItems);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;

          if (isSmallScreen) {
            return Column(
              children: [
                Text(
                  '$start-$end of $totalItems',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff718096),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _pageButton(
                      icon: Icons.chevron_left,
                      enabled: currentPage > 0,
                      onPressed: () {
                        _changePage(currentPage - 1);
                      },
                    ),

                    const SizedBox(width: 5),

                    Text(
                      '${currentPage + 1} / $totalPages',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(width: 5),

                    _pageButton(
                      icon: Icons.chevron_right,
                      enabled: currentPage < totalPages - 1,
                      onPressed: () {
                        _changePage(currentPage + 1);
                      },
                    ),
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              Text(
                '$start-$end of $totalItems',
                style: const TextStyle(fontSize: 13, color: Color(0xff718096)),
              ),

              const Spacer(),

              const Text(
                'Rows per page:',
                style: TextStyle(fontSize: 13, color: Color(0xff718096)),
              ),

              const SizedBox(width: 8),

              DropdownButton<int>(
                value: rowsPerPage,
                underline: const SizedBox(),
                items: widget.availableRowsPerPage
                    .map(
                      (value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _changeRowsPerPage(value);
                  }
                },
              ),

              const SizedBox(width: 20),

              _pageButton(
                icon: Icons.chevron_left,
                enabled: currentPage > 0,
                onPressed: () {
                  _changePage(currentPage - 1);
                },
              ),

              const SizedBox(width: 5),

              _pageButton(
                icon: Icons.chevron_right,
                enabled: currentPage < totalPages - 1,
                onPressed: () {
                  _changePage(currentPage + 1);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _pageButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon),
      tooltip: enabled ? 'Change page' : null,
    );
  }
}
