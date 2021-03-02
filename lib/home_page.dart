import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  TextEditingController _billController;
  TextEditingController _tipController;
  String _tipAmountText;
  String _totalAmountText;

  @override
  void initState() {
    super.initState();
    _billController = new TextEditingController(text: "0");
    _tipController = new TextEditingController(text: "15");
    _tipAmountText = "Tip: \$0.00";
    _totalAmountText = "Total: \$0.00";
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Bill \$'),
            controller: _billController,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              _calculateTip();
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Tip %'),
            controller: _tipController,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              _calculateTip();
            },
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text(
              _tipAmountText,
              textAlign: TextAlign.end,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text(
              _totalAmountText,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }

  void _calculateTip() {
    // 1
    String billTxt = _billController.text;
    String tipTxt = _tipController.text;
    // 2
    billTxt = billTxt.replaceAll(new RegExp(r"[^0-9]"), "");
    tipTxt = tipTxt.replaceAll(new RegExp(r"[^0-9]"), "");

    // 3
    int bill = int.parse(billTxt.isNotEmpty
        ? billTxt : "0");
    int tip = int.parse(tipTxt.isNotEmpty
        ? tipTxt : "0");
    String finalTipAmount = "0";
    String totalBill = "0";

    // 4
    if (tip <= 100 && tip>=0 && bill>=0) {
      double tipAmount = (bill * (tip/100));
      finalTipAmount = tipAmount.toStringAsFixed(2);
      totalBill = (bill + tipAmount).toStringAsFixed(2);
    }
    // 5
    setState(() {
      _tipAmountText = "Tip: \$$finalTipAmount";
      _totalAmountText = "Total: \$$totalBill";
    });

  }

  @override
  void dispose() {
    if(_billController != null && _tipController != null ){
      _billController.dispose();
      _tipController.dispose();
    }
    super.dispose();
  }

}
