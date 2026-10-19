import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/property_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tabs.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/widgets/quick_property_actions_widget.dart';

class SinglePropertyPage extends ConsumerStatefulWidget {
  final Property property;
  final String introText;
  const SinglePropertyPage({
    super.key,
    required this.property,
    required this.introText,
  });

  @override
  ConsumerState<SinglePropertyPage> createState() => _SinglePropertyPageState();
}

class _SinglePropertyPageState extends ConsumerState<SinglePropertyPage> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    final Property property = appData.properties
        .where((property) => property.propertyId == widget.property.propertyId)
        .single;
    List<Tenant> propertyTenants = appData.tenants
        .where((tenant) => tenant.propertyId == property.propertyId)
        .toList();
    final String introText = widget.introText;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Responsiveness.isMobile(context)
            ? Column(
                children: [
                  // --------------------------------------------
                  // Data Row
                  // --------------------------------------------
                  SinglePropertyPageSummaryCards(property: property),
                  SizedBox(height: 20.0),
                  // --------------------------------------------
                  // Property tabs
                  // --------------------------------------------
                  SizedBox(
                    height: 600,
                    child: SingleChildScrollView(
                      child: PropertyTabs(
                        property: property,
                        introText: widget.introText,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --------------------------------------------
                        // Data Row
                        // --------------------------------------------
                        SinglePropertyPageSummaryCards(property: property),
                        SizedBox(height: 30.0),
                        // --------------------------------------------
                        // Property tabs
                        // --------------------------------------------
                        SizedBox(
                          height: 600,
                          child: PropertyTabs(
                            property: property,
                            introText: widget.introText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --------------------------------------------
                        // Quick Actions
                        // --------------------------------------------
                        QuickActionsPropertyWidget(
                          property: property,
                          introText: introText,
                        ),
                        SizedBox(height: 20.0),
                        // --------------------------------------------
                        // Tenant List
                        // --------------------------------------------
                        if (propertyTenants.isNotEmpty)
                          TenantInformationCardWidget(
                            property: property,
                            introText: '${widget.introText} / tenant',
                            tenants: propertyTenants,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
