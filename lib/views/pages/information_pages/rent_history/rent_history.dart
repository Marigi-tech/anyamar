import 'package:flutter/material.dart';
import 'package:test_app/data/models/rent_history_model.dart';
import 'package:test_app/data/models/single_rental_entry_model.dart';
import 'package:test_app/views/tables/rent_history.dart';

class RentHistoryPage extends StatelessWidget {
  final RentHistory rentHistory;
  const RentHistoryPage({super.key, required this.rentHistory});

  @override
  Widget build(BuildContext context) {
    List<SingleRentEntry>? rentEntries = rentHistory.rentEntries;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
            child: RentHistoryTable(rentEntries: rentEntries ?? []),
          ),
        ),
      ),
    );
  }
}
