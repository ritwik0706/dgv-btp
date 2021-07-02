import 'package:dgv_btp/app_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  void scan(BuildContext context, AppInfo app) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Opening Application"),
            ),
          ],
        ),
      );
    },
  );
  new Future.delayed(new Duration(seconds: 2), () {
    Navigator.pop(context); //pop dialog
    scanApp(context, app);
  });
}

  void scanApp(BuildContext ctx, AppInfo app) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return AppInfoScreen(app);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Installed Apps"),
        ),
        body: FutureBuilder<List<AppInfo>>(
            future: InstalledApps.getInstalledApps(true, true),
            builder: (BuildContext buildContext,
                AsyncSnapshot<List<AppInfo>> snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            AppInfo app = snapshot.data[index];
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.memory(app.icon),
                                ),
                                title: Text(app.name),
                                subtitle: Text(app.getVersionInfo()),
                                onTap: () => scan(context, app),
                                onLongPress: () =>
                                    InstalledApps.openSettings(app.packageName),
                              ),
                            );
                          })
                      : Center(
                          child: Text(
                              "Error occurred while getting installed apps ...."))
                  : Center(child: Text("Getting installed apps ...."));
            }));
  }
}
