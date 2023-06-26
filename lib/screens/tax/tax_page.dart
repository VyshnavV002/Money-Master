import 'package:flutter/material.dart';

class TaxCalculatorPage extends StatefulWidget {
  const TaxCalculatorPage({super.key});

  @override
  _TaxCalculatorPageState createState() => _TaxCalculatorPageState();
}

class _TaxCalculatorPageState extends State<TaxCalculatorPage> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _gstRateController = TextEditingController();
  TextEditingController _otherTaxRateController = TextEditingController();

  double _totalAmount = 0.0;
  double _gstAmount = 0.0;
  double _otherTaxAmount = 0.0;
  double _netAmount = 0.0;

  void calculateTax() {\
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    double gstRate = double.tryParse(_gstRateController.text) ?? 0.0;
    double otherTaxRate = double.tryParse(_otherTaxRateController.text) ?? 0.0;

    // Calculate GST amount
    _gstAmount = (amount * gstRate) / 100;

    // Calculate other tax amount
    _otherTaxAmount = (amount * otherTaxRate) / 100;

    // Calculate total amount
    _totalAmount = amount + _gstAmount + _otherTaxAmount;

    setState(() {
      // Update the net amount
      _netAmount = _totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _gstRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'GST Rate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _otherTaxRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Other Tax Rate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateTax,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 16.0),
            Text('Total Amount: $_totalAmount',
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('GST Amount: $_gstAmount',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Other Tax Amount: $_otherTaxAmount',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Net Amount: $_netAmount',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
