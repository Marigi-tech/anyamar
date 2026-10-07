import 'package:anyamar/commons/exports.dart';

class SearchlessTableWidget extends StatelessWidget {
  // final List<HeaderItem> headerItems;
  final List<TableColumnConfig> columns;
  final List<List<Widget>> rows;
  const SearchlessTableWidget({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        MyTableHeader(columns: columns),
        CardItemSeparator(),

        //Rows
        for (int index = 0; index < rows.length; index++) ...[
          MyTableRow(columns: columns, cells: rows[index]),

          if (index != rows.length - 1) const CardItemSeparator(),
        ],
      ],
    );
  }
}

// --------------------------------------------
// Table Column Config
// --------------------------------------------
class TableColumnConfig {
  final String title;
  final double flex;

  const TableColumnConfig({required this.title, this.flex = 1.1});
}

// --------------------------------------------
// Table Header
// --------------------------------------------
class MyTableHeader extends StatelessWidget {
  final List<TableColumnConfig> columns;

  const MyTableHeader({required this.columns, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, bottom: 10),
      child: Row(
        children: [
          for (final column in columns)
            Expanded(
              flex: (column.flex * 10).round(),
              child: Text(
                column.title,
                style: CustomTextStyles.cardDescriptionStyle.copyWith(
                  fontStyle: FontStyle.normal,
                  fontSize: 13,
                  color: const Color(0xFF6B7483),
                ),
              ),
            ),

          // Space for the action icon
          const SizedBox(width: 22),
        ],
      ),
    );
  }
}

// --------------------------------------------
// Item Row
// --------------------------------------------
class MyTableRow extends StatelessWidget {
  final List<TableColumnConfig> columns;
  final List<Widget> cells;

  const MyTableRow({required this.columns, required this.cells, super.key});

  @override
  Widget build(BuildContext context) {
    assert(
      cells.length == columns.length,
      'Number of cells must match number of columns.',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: cells.isEmpty
          ? Align(
              alignment: Alignment.topCenter,
              child: Text(
                '0 Results found',
                style: AppTextStylesConstant.cardDescriptionStyle,
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < columns.length; i++)
                  Expanded(
                    flex: (columns[i].flex * 10).round(),
                    child: cells[i],
                  ),

                const SizedBox(width: 22),
              ],
            ),
    );
  }
}

// --------------------------------------------
// Item Cell
// --------------------------------------------
class ItemCell extends ConsumerWidget {
  final String value;

  const ItemCell({super.key, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return Text(
      value,
      overflow: TextOverflow.ellipsis,
      style: CustomTextStyles.cardDescriptionStyle.copyWith(
        fontSize: 12,
        fontStyle: FontStyle.normal,
        color: themeIsDark == true
            ? AppColors.darkText
            : const Color(0xFF344055),
      ),
    );
  }
}
