import 'package:dgv_btp/features.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Duration flowTime;

  ResultScreen(this.flowTime);

  void showResult(BuildContext ctx) {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: ListTile(
            title: Text('Class : Malware'),
            subtitle: Text('Category : SMS Malware'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Flow Time'),
                subtitle: Text(flowTime.inMilliseconds.toString() + 'milliseconds'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(features.keys.toList()[index]),
                      subtitle:
                          Text(features.values.toList()[index].toString()),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showResult(context),
        label: Text('Classify'),
        icon: Icon(Icons.adb_sharp),
      ),
    );
  }
}
