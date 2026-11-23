import 'package:anyamar/commons/exports.dart';

class PageDisplayCardsWidget extends ConsumerWidget {
  final int gridCount;
  final List<SummaryCard> cards;
  const PageDisplayCardsWidget({
    super.key,
    required this.gridCount,
    required this.cards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 5,
        mainAxisExtent: 150, // Fixed card height
      ),
      itemBuilder: (context, index) => cards[index],
    );
  }
}
