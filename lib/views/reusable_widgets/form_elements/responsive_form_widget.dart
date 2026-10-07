import 'package:anyamar/commons/exports.dart';

class ResponsiveFormWidget extends ConsumerWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const ResponsiveFormWidget({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 20,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),

          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final columns = width >= 1100
                  ? 2
                  : width >= 700
                  ? 2
                  : 1;

              final itemWidth = (width - ((columns - 1) * spacing)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: runSpacing,
                children: [
                  for (final child in children)
                    SizedBox(width: itemWidth, child: child),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
