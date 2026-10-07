import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';

class FinancesBackButtonWidget extends ConsumerWidget {
  const FinancesBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntroButtonWidget(
      buttonText: 'Back',
      onPressedCallBack: () async {
        LazyLoader lazyLoader = LazyLoader(context: context);
        lazyLoader.showLoader();

        ref.read(financesPageProvider.notifier).goBack();
        lazyLoader.hideLoader();
      },
    );
  }
}
