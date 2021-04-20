import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:work_check_app/pages/dashboard_page.dart';
import 'package:work_check_app/view_models/dashboard_view_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() {
  Provider.debugCheckInvalidValueType = null;
  initializeDateFormatting().then((value) => runApp(App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    var detroit = tz.getLocation('Asia/Taipei');
    tz.setLocalLocation(detroit);

    return MaterialApp(
      title: "WorkCheckApp",
      home: ChangeNotifierProvider(
        create: (context) => DashboardViewModel(), //DashboardViewModel(),
        child: DashboardPage(),
        lazy: true,
      ),
      builder: EasyLoading.init(),
    );
  }
}
