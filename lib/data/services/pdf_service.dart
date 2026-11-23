import 'package:anyamar/commons/exports.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_saver/file_saver.dart';

class PdfDocumentService {
  PdfDocumentService._();

  static final PdfDocumentService instance = PdfDocumentService._();

  // ============================================================
  // DOCUMENT STYLING
  // ============================================================

  static const PdfColor primaryBlue = PdfColor.fromInt(0xFF246BCE);
  static const PdfColor darkText = PdfColor.fromInt(0xFF263445);
  static const PdfColor mutedText = PdfColor.fromInt(0xFF718096);
  static const PdfColor lightBackground = PdfColor.fromInt(0xFFF3F6FA);
  static const PdfColor borderColor = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor successGreen = PdfColor.fromInt(0xFF15966B);

  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  String _formatAmount(double amount, String currency) {
    return '$currency ${NumberFormat('#,##0.00').format(amount)}';
  }

  String _formatDate(DateTime date) => _dateFormat.format(date);

  String _cleanId(String value) {
    return value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
  }

  // ============================================================
  // 1. GENERATE TENANT MONTHLY INVOICE
  // ============================================================

  Future<void> generateTenantInvoice({
    required Tenant tenant,
    required Unit unit,
    required Property property,
    required String rentalMonth,
    required RentHistory rentHistory,

    // Historical rent snapshot, if available.
    RentalMonth? monthRecord,

    // Outstanding balance from previous months.
    // double previousBalance = 0,
  }) async {
    final previousBalance = calculatePreviousOutstandingBalance(
      rentHistory: rentHistory,
      unit: unit,
      invoiceRentalMonth: rentalMonth,
    );

    // Prefer the historical monthly rent snapshot.
    final Rent rentDetails =
        monthRecord?.unitRent ??
        unit.unitRent ??
        Rent(rentAmount: unit.rentPerMonth);

    final currency = rentDetails.rentCurrency ?? 'KSh';

    final rentAmount = rentDetails.rentAmount;

    final utilities = rentDetails.utilities ?? [];

    final utilityTotal = utilities.fold<double>(
      0,
      (sum, utility) => sum + utility.amountPayable,
    );

    final monthlyTotal = rentAmount + utilityTotal;

    final totalDue = monthlyTotal + previousBalance;

    final invoiceId =
        'INV-${generateInvoiceNumber(tenantName: tenant.tenantName, rentalMonth: rentalMonth)}';

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _documentHeader(
            title: 'RENT INVOICE',
            documentNumber: invoiceId,
            date: _formatDate(DateTime.now()),
          ),

          pw.SizedBox(height: 30),

          _sectionTitle('BILL TO'),

          _informationCard([
            _infoRow('Tenant', tenant.tenantName),
            _infoRow('Phone', tenant.tenantPhoneNumber ?? 'Not provided'),
            _infoRow('Email', tenant.tenantEmail ?? 'Not provided'),
            _infoRow('Property', property.propertyName),
            _infoRow('Unit', unit.unitName),
            _infoRow('Billing period', rentalMonth),
          ]),

          pw.SizedBox(height: 25),

          _sectionTitle('INVOICE BREAKDOWN'),

          _buildAmountTable(
            currency: currency,
            rows: [
              ['Monthly rent', rentAmount],
              ...utilities.map(
                (utility) => [utility.utilityName.label, utility.amountPayable],
              ),
            ],
          ),

          pw.SizedBox(height: 15),

          _totalRow('Current month charges', monthlyTotal, currency),

          if (previousBalance > 0) ...[
            pw.SizedBox(height: 8),
            _totalRow(
              'Previous outstanding balance',
              previousBalance,
              currency,
            ),
          ],

          pw.SizedBox(height: 15),

          _grandTotalRow('TOTAL AMOUNT DUE', totalDue, currency),

          pw.SizedBox(height: 30),

          _sectionTitle('PAYMENT INFORMATION'),

          _informationCard([
            _infoRow('Property', property.propertyName),
            _infoRow('Location', property.propertyLocation),
            _infoRow(
              'Property manager',
              property.propertyManager?.personName ?? 'Not provided',
            ),
            _infoRow(
              'Contact',
              property.propertyManager?.personPhone ?? 'Not provided',
            ),
          ]),

          pw.SizedBox(height: 30),

          pw.Center(
            child: pw.Text(
              'Thank you for choosing ANYAMAR.',
              style: pw.TextStyle(
                color: mutedText,
                fontSize: 10,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ),
        ],
        footer: _documentFooter,
      ),
    );

    final bytes = await pdf.save();

    await _downloadPdf(bytes: bytes, fileName: invoiceId);
  }

  // ============================================================
  // 2. GENERATE PAYMENT RECEIPT
  // ============================================================

  Future<void> generatePaymentReceipt({
    required Tenant tenant,
    required Unit unit,
    required Property property,
    required SingleRentEntry rentEntry,
  }) async {
    if (rentEntry.amountPaid <= 0) {
      throw ArgumentError('Payment amount must be greater than zero.');
    }

    final currency = unit.unitRent?.rentCurrency ?? 'KSh';

    final outstandingBalance =
        rentEntry.balance ??
        (rentEntry.amountPayable - rentEntry.amountPaid)
            .clamp(0, double.infinity)
            .toDouble();

    final isFullyPaid = outstandingBalance <= 0;

    final receiptReference =
        rentEntry.rentEntryId ??
        rentEntry.transactionCode ??
        '${rentEntry.paymentDate.millisecondsSinceEpoch}';

    final receiptId = 'RCP-${_cleanId(receiptReference)}';

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _documentHeader(
            title: 'PAYMENT RECEIPT',
            documentNumber: receiptId,
            date: _formatDate(rentEntry.paymentDate),
          ),

          pw.SizedBox(height: 30),

          _sectionTitle('PAYMENT RECEIVED FROM'),

          _informationCard([
            _infoRow('Tenant', tenant.tenantName),
            _infoRow('Phone', tenant.tenantPhoneNumber ?? 'Not provided'),
            _infoRow('Property', property.propertyName),
            _infoRow('Unit', unit.unitName),
            _infoRow('Rental period', rentEntry.rentalMonth),
          ]),

          pw.SizedBox(height: 25),

          _sectionTitle('PAYMENT DETAILS'),

          _informationCard([
            _infoRow('Payment date', _formatDate(rentEntry.paymentDate)),
            _infoRow('Payment method', rentEntry.paymentMethod.label),
            _infoRow(
              'Transaction code',
              rentEntry.transactionCode ?? 'Not provided',
            ),
            _infoRow(
              'Payment reference',
              rentEntry.rentEntryId ?? 'Not provided',
            ),
          ]),

          pw.SizedBox(height: 25),

          _sectionTitle('PAYMENT SUMMARY'),

          _buildAmountTable(
            currency: currency,
            rows: [
              ['Amount payable', rentEntry.amountPayable],
              ['Amount received', rentEntry.amountPaid],
              ['Outstanding balance', outstandingBalance],
            ],
          ),

          pw.SizedBox(height: 25),

          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              color: lightBackground,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: borderColor),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'AMOUNT RECEIVED',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: mutedText,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  _formatAmount(rentEntry.amountPaid, currency),
                  style: pw.TextStyle(
                    fontSize: 23,
                    color: primaryBlue,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  isFullyPaid ? 'PAYMENT COMPLETED' : 'PARTIAL PAYMENT',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: isFullyPaid ? successGreen : PdfColors.orange800,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 30),

          pw.Center(
            child: pw.Text(
              'Thank you for your payment.',
              style: pw.TextStyle(
                color: mutedText,
                fontSize: 10,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ),
        ],
        footer: _documentFooter,
      ),
    );

    final bytes = await pdf.save();

    await _downloadPdf(bytes: bytes, fileName: receiptId);
  }

  //!=====================================================
  //!3. GENERATE TENANT MONTHLY PAYMENT RECEIPT
  //!=====================================================

  Future<void> generateMonthlyRentalReceipt({
    required Tenant tenant,
    required Unit unit,
    required Property property,
    required RentalMonth rentalMonth,
  }) async {
    final entries = [...rentalMonth.rentEntries]
      ..sort((a, b) => a.paymentDate.compareTo(b.paymentDate));

    if (entries.isEmpty) {
      throw ArgumentError(
        'There are no payment entries for this rental month.',
      );
    }

    // Prefer the historical rent snapshot.
    final rentDetails =
        rentalMonth.unitRent ??
        unit.unitRent ??
        Rent(rentAmount: unit.rentPerMonth);

    final currency = rentDetails.rentCurrency ?? 'KSh';

    // Monthly charges.
    final rentAmount = rentDetails.rentAmount;

    final utilities = rentDetails.utilities ?? [];

    final utilitiesTotal = utilities.fold<double>(
      0,
      (sum, utility) => sum + utility.amountPayable,
    );

    final monthlyAmountDue = rentAmount + utilitiesTotal;

    // Total payments received during this rental month.
    final totalAmountPaid = entries.fold<double>(
      0,
      (sum, entry) => sum + entry.amountPaid,
    );

    // Remaining balance for this rental month.
    final outstandingBalance = (monthlyAmountDue - totalAmountPaid)
        .clamp(0, double.infinity)
        .toDouble();

    final isFullyPaid = outstandingBalance <= 0;

    // Use the tenant and rental month to identify the document.
    final receiptId =
        'MRC-${_cleanId(tenant.tenantId ?? tenant.unitId)}-'
        '${_cleanId(rentalMonth.rentalMonth)}';

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // DOCUMENT HEADER
          _documentHeader(
            title: 'MONTHLY RENT RECEIPT',
            documentNumber: receiptId,
            date: _formatDate(DateTime.now()),
          ),

          pw.SizedBox(height: 30),

          // TENANT INFORMATION
          _sectionTitle('TENANT INFORMATION'),

          _informationCard([
            _infoRow('Tenant', tenant.tenantName),
            _infoRow('Phone', tenant.tenantPhoneNumber ?? 'Not provided'),
            _infoRow('Property', property.propertyName),
            _infoRow('Location', property.propertyLocation),
            _infoRow('Unit', unit.unitName),
            _infoRow('Rental month', rentalMonth.rentalMonth),
          ]),

          pw.SizedBox(height: 25),

          // MONTHLY RENT BREAKDOWN
          _sectionTitle('MONTHLY RENT BREAKDOWN'),

          _buildAmountTable(
            currency: currency,
            rows: [
              ['Monthly rent', rentAmount],
              ...utilities.map(
                (utility) => [utility.utilityName.label, utility.amountPayable],
              ),
            ],
          ),

          pw.SizedBox(height: 15),

          _totalRow('Total monthly charges', monthlyAmountDue, currency),

          pw.SizedBox(height: 25),

          // INDIVIDUAL PAYMENT ENTRIES
          _sectionTitle('PAYMENT HISTORY'),

          pw.Text(
            'The following payments were received for '
            '${rentalMonth.rentalMonth}.',
            style: const pw.TextStyle(fontSize: 9, color: mutedText),
          ),

          pw.SizedBox(height: 12),

          _buildMonthlyPaymentTable(entries: entries, currency: currency),

          pw.SizedBox(height: 20),

          // PAYMENT SUMMARY
          _sectionTitle('PAYMENT SUMMARY'),

          _informationCard([
            _infoRow(
              'Total monthly charges',
              _formatAmount(monthlyAmountDue, currency),
            ),
            _infoRow('Number of payments', entries.length.toString()),
            _infoRow(
              'Total amount received',
              _formatAmount(totalAmountPaid, currency),
            ),
            _infoRow(
              'Outstanding balance',
              _formatAmount(outstandingBalance, currency),
            ),
          ]),

          pw.SizedBox(height: 20),

          // PAYMENT STATUS
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(18),
            decoration: pw.BoxDecoration(
              color: lightBackground,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: borderColor),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'MONTHLY PAYMENT STATUS',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: mutedText,
                  ),
                ),

                pw.SizedBox(height: 8),

                pw.Text(
                  isFullyPaid ? 'FULLY PAID' : 'PARTIALLY PAID',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                    color: isFullyPaid ? successGreen : PdfColors.orange800,
                  ),
                ),

                if (!isFullyPaid) ...[
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Remaining amount: '
                    '${_formatAmount(outstandingBalance, currency)}',
                    style: const pw.TextStyle(fontSize: 10, color: mutedText),
                  ),
                ],
              ],
            ),
          ),

          pw.SizedBox(height: 30),

          pw.Center(
            child: pw.Text(
              'Thank you for your payments.',
              style: pw.TextStyle(
                fontSize: 10,
                color: mutedText,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ),
        ],
        footer: _documentFooter,
      ),
    );

    final bytes = await pdf.save();

    await _downloadPdf(bytes: bytes, fileName: receiptId);
  }

  pw.Widget _buildMonthlyPaymentTable({
    required List<SingleRentEntry> entries,
    required String currency,
  }) {
    return pw.Table(
      border: pw.TableBorder(
        horizontalInside: pw.BorderSide(color: borderColor),
        bottom: pw.BorderSide(color: borderColor),
      ),
      columnWidths: {
        0: const pw.FlexColumnWidth(1.5),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(1.5),
        3: const pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: lightBackground),
          children: [
            _tableCell('DATE', isHeader: true),
            _tableCell('REFERENCE', isHeader: true),
            _tableCell('METHOD', isHeader: true),
            _tableCell('AMOUNT PAID', isHeader: true, alignRight: true),
          ],
        ),

        ...entries.map(
          (entry) => pw.TableRow(
            children: [
              _tableCell(_formatDate(entry.paymentDate)),
              _tableCell(entry.transactionCode ?? entry.rentEntryId ?? '-'),
              _tableCell(entry.paymentMethod.label),
              _tableCell(
                _formatAmount(entry.amountPaid, currency),
                alignRight: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SHARED PDF WIDGETS
  // ============================================================

  pw.Widget _documentHeader({
    required String title,
    required String documentNumber,
    required String date,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'ANYAMAR',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: pw.BoxDecoration(
                color: primaryBlue,
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        pw.SizedBox(height: 18),

        pw.Divider(color: borderColor),

        pw.SizedBox(height: 10),

        _infoRow('Document number', documentNumber),
        _infoRow('Date issued', date),
      ],
    );
  }

  pw.Widget _sectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 11,
          fontWeight: pw.FontWeight.bold,
          color: darkText,
        ),
      ),
    );
  }

  pw.Widget _infoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 125,
            child: pw.Text(
              label,
              style: const pw.TextStyle(fontSize: 9, color: mutedText),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 9,
                color: darkText,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _informationCard(List<pw.Widget> children) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: lightBackground,
        borderRadius: pw.BorderRadius.circular(7),
        border: pw.Border.all(color: borderColor),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  pw.Widget _buildAmountTable({
    required String currency,
    required List<List<dynamic>> rows,
  }) {
    return pw.Table(
      border: pw.TableBorder(
        horizontalInside: pw.BorderSide(color: borderColor),
        bottom: pw.BorderSide(color: borderColor),
      ),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1.5),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: lightBackground),
          children: [
            _tableCell('DESCRIPTION', isHeader: true),
            _tableCell('AMOUNT', isHeader: true, alignRight: true),
          ],
        ),
        ...rows.map(
          (row) => pw.TableRow(
            children: [
              _tableCell(row[0].toString()),
              _tableCell(
                _formatAmount(row[1] as double, currency),
                alignRight: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _tableCell(
    String value, {
    bool isHeader = false,
    bool alignRight = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: pw.Align(
        alignment: alignRight
            ? pw.Alignment.centerRight
            : pw.Alignment.centerLeft,
        child: pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isHeader ? 9 : 10,
            fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: isHeader ? mutedText : darkText,
          ),
        ),
      ),
    );
  }

  pw.Widget _totalRow(String label, double amount, String currency) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 10, color: mutedText),
        ),
        pw.Text(
          _formatAmount(amount, currency),
          style: pw.TextStyle(
            fontSize: 10,
            color: darkText,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget _grandTotalRow(String label, double amount, String currency) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: primaryBlue,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            _formatAmount(amount, currency),
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _documentFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(top: 20),
      padding: const pw.EdgeInsets.only(top: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: borderColor)),
      ),
      child: pw.Text(
        'ANYAMAR | Page ${context.pageNumber} of ${context.pagesCount}',
        style: const pw.TextStyle(fontSize: 8, color: mutedText),
      ),
    );
  }

  // ============================================================
  // DOWNLOAD PDF
  // ============================================================

  Future<void> _downloadPdf({
    required List<int> bytes,
    required String fileName,
  }) async {
    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: Uint8List.fromList(bytes),
      fileExtension: 'pdf',
      mimeType: MimeType.pdf,
    );
  }

  /// Calculates the outstanding balance from all rental months
  /// preceding the month currently being invoiced.
  double calculatePreviousOutstandingBalance({
    required RentHistory rentHistory,
    required Unit unit,
    required String invoiceRentalMonth,
  }) {
    // Convert the invoice month into a comparable DateTime.
    DateTime parseRentalMonth(String value) {
      try {
        return DateFormat('MMMM/yyyy', 'en_US').parseStrict(value);
      } catch (_) {
        throw FormatException(
          'Invalid rental month format: $value. '
          'Expected format: August/2026.',
        );
      }
    }

    final invoiceDate = parseRentalMonth(invoiceRentalMonth);

    double outstandingBalance = 0;

    for (final month in rentHistory.rentalMonths) {
      final monthDate = parseRentalMonth(month.rentalMonth);

      // Only consider months before the invoice month.
      if (!monthDate.isBefore(invoiceDate)) continue;

      // Prefer the rent snapshot saved for that particular month.
      final rentDetails =
          month.unitRent ??
          unit.unitRent ??
          Rent(rentAmount: unit.rentPerMonth);

      final rentAmount = rentDetails.rentAmount;

      final utilitiesTotal = (rentDetails.utilities ?? []).fold<double>(
        0,
        (sum, utility) => sum + utility.amountPayable,
      );

      final totalMonthlyCharges = rentAmount + utilitiesTotal;

      // Calculate the total amount received for this month.
      final totalPaid = month.rentEntries.fold<double>(
        0,
        (sum, entry) => sum + entry.amountPaid,
      );

      // Do not allow one month's overpayment to create a negative
      // outstanding balance for that month.
      final monthBalance = (totalMonthlyCharges - totalPaid)
          .clamp(0, double.infinity)
          .toDouble();

      outstandingBalance += monthBalance;
    }

    return outstandingBalance;
  }

  //!GENERATE INVOICE NUMBER
  String generateInvoiceNumber({
    required String tenantName,
    required String rentalMonth,
  }) {
    final initials = getInitials(tenantName);
    //month and year
    String info = getMonthAndYearInNumericForm(rentalMonth);
    return '$initials${info.toString().padLeft(4, '0')}';
  }
}
