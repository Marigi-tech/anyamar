import 'package:anyamar/commons/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingRemindersCard extends StatelessWidget {
  const UpcomingRemindersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCardWidget(
      cardTitle: 'Upcoming reminders',
      buttonWidget1: TextButton(
        onPressed: () {},
        child: Text(
          'View all',
          style: GoogleFonts.inter(
            color: const Color(0xFF2469DB),
            fontSize: 12,
          ),
        ),
      ),

      child: Column(
        children: [
          const SizedBox(height: 8),

          const _Reminder(
            month: 'AUG',
            day: '10',
            title: 'Rent due from 4 tenants',
            subtitle: 'Total: Ksh 83,000',
            priority: 'High Priority',
            priorityColor: Color(0xFFEF5350),
            dateBackground: Color(0xFFF2F6FF),
          ),

          const _Reminder(
            month: 'AUG',
            day: '15',
            title: 'Lease renewal - Jane Smith',
            subtitle: 'Sunrise Estate, Unit B03',
            priority: 'Medium Priority',
            priorityColor: Color(0xFFECA018),
            dateBackground: Color(0xFFFFF3E5),
          ),

          const _Reminder(
            month: 'AUG',
            day: '20',
            title: 'Property inspection',
            subtitle: 'Green View Apartments',
            priority: 'Low Priority',
            priorityColor: Color(0xFF3971E0),
            dateBackground: Color(0xFFF2F6FF),
          ),

          const SizedBox(height: 5),

          const Divider(),

          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 2),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF2167D8),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'View calendar',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2167D8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Reminder extends StatelessWidget {
  final String month;
  final String day;
  final String title;
  final String subtitle;
  final String priority;
  final Color priorityColor;
  final Color dateBackground;

  const _Reminder({
    required this.month,
    required this.day,
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.priorityColor,
    required this.dateBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE8ECF1))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 58,
            decoration: BoxDecoration(
              color: dateBackground,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5B6780),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  day,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF26364E),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF26344B),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: const Color(0xFF6E788A),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                priority,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: const Color(0xFF354055),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
