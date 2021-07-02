import 'package:dgv_btp/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppInfoScreen extends StatefulWidget {
  final AppInfo app;

  AppInfoScreen(this.app);

  @override
  _AppInfoScreenState createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  DateTime before, after;

  void stop(BuildContext ctx) {
    after = DateTime.now();
    Duration flowTime = after.difference(before);
    Navigator.of(ctx).pop();
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ResultScreen(flowTime);
        },
      ),
    );
  }

  void capture(BuildContext context) {
    before = DateTime.now();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Capturing Features'),
              ),
              LinearProgressIndicator(
                semanticsLabel: 'Linear progess indicator',
              ),
              TextButton(
                onPressed: () => stop(context),
                child: Text('Stop'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    InstalledApps.startApp(widget.app.packageName);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app.name),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Image.memory(widget.app.icon),
              Divider(
                height: 15,
              ),
              Text('Package Name : ' + widget.app.packageName),
              Text('Version : ' + widget.app.versionName),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => capture(context),
        label: Text('Capture'),
        icon: Icon(Icons.scatter_plot),
      ),
    );
  }
}
