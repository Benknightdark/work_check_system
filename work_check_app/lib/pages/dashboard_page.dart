import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_check_app/pages/login_page.dart';
import 'package:work_check_app/pages/punchlist_page.dart';
import 'package:work_check_app/view_models/dashboard_view_model.dart';
import 'package:work_check_app/view_models/login_view_model.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:work_check_app/view_models/punchlist_view_model.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<List<double>> charts = [
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];
  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  DashboardViewModel vm = new DashboardViewModel();
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<DashboardViewModel>(context, listen: false);
    vm.fetchDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardViewModel>(context);
    void initData() {
      Future.delayed(Duration(milliseconds: 500))
          .then((value) => setState(() async {
                await vm.fetchDashboard();
              }));
    }

    if (vm?.dashboard?.displayName == null) {
      return Container();
    } else {
      return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Colors.white,
            title: Text('手殘也照打不誤',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0)),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        if (vm?.dashboard?.displayName == "登入") {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Provider(
                                create: (context) => LoginViewModel(),
                                builder: (context, child) => LoginPage(),
                              ),
                            ),
                          )
                              .then((value) {
                            if (value != null) {
                              initData();
                            }
                            EasyLoading.dismiss();
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => NetworkGiffyDialog(
                                    image: Image.network(
                                      "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                                      fit: BoxFit.cover,
                                    ),
                                    entryAnimation: EntryAnimation.TOP,
                                    buttonOkText: Text('是'),
                                    buttonCancelText: Text('否'),
                                    title: Text(
                                      '是否要登出',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onOkButtonPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.clear();
                                      initData();
                                      Navigator.of(context).pop();
                                    },
                                  ));
                        }
                      },
                      child: Text(vm?.dashboard?.displayName),
                    )
                  ],
                ),
              )
            ],
          ),
          body: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                '${(new DateFormat("yyyy/M").format(new DateTime.now()))}月工作時數',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 17)),
                            Text('${vm?.dashboard?.workHour}小時',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 23.0))
                          ],
                        ),
                        Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.lock_clock,
                                  color: Colors.white, size: 30.0),
                            )))
                      ]),
                ),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ListenableProvider<PunchlistViewModel>.value(
                              value:
                                  PunchlistViewModel(), //MovieListViewModel(),
                              child: PunchlistPage() //MovieListPage(),
                              ),
                      // builder: (BuildContext context) => Provider(
                      //   create: (context) =>
                      //       MovieListViewModel(), // PunchlistViewModel(),
                      //   builder: (context, child) =>
                      //       MovieListPage(), //PunchlistPage(),
                      // ),
                    ),
                  );
                },
              ),
              _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.teal,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.work,
                                    color: Colors.white, size: 30.0),
                              )),
                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Text('😢上班打卡',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0)),
                        ]),
                  ), onTap: () async {
                EasyLoading.show(status: '打卡中...');
                var resData = await vm?.punch('work');
                if (resData != null) {
                  EasyLoading.showToast(resData['title'] != "200"
                      ? resData["data"]["detail"]
                      : "😢上班打卡成功");
                }
              }),
              _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.amber,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.work_off,
                                    color: Colors.white, size: 30.0),
                              )),
                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Text('😊下班打卡',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0)),
                        ]),
                  ), onTap: () async {
                EasyLoading.show(status: '打卡中...');

                var resData = await vm?.punch('work_off');
                if (resData != null) {
                  EasyLoading.showToast(resData['title'] != "200"
                      ? resData["data"]["detail"]
                      : "😊下班打卡成功");
                }
              }),
              // _buildTile(
              //   Padding(
              //       padding: const EdgeInsets.all(24.0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Text('Revenue',
              //                       style: TextStyle(color: Colors.green)),
              //                   Text('\$16K',
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontWeight: FontWeight.w700,
              //                           fontSize: 34.0)),
              //                 ],
              //               ),
              //               DropdownButton(
              //                   isDense: true,
              //                   value: actualDropdown,
              //                   onChanged: (String value) => setState(() {
              //                         actualDropdown = value;
              //                         actualChart = chartDropdownItems
              //                             .indexOf(value); // Refresh the chart
              //                       }),
              //                   items: chartDropdownItems.map((String title) {
              //                     return DropdownMenuItem(
              //                       value: title,
              //                       child: Text(title,
              //                           style: TextStyle(
              //                               color: Colors.blue,
              //                               fontWeight: FontWeight.w400,
              //                               fontSize: 14.0)),
              //                     );
              //                   }).toList())
              //             ],
              //           ),
              //           Padding(padding: EdgeInsets.only(bottom: 4.0)),
              //           Sparkline(
              //             data: charts[actualChart],
              //             lineWidth: 5.0,
              //             lineColor: Colors.greenAccent,
              //           )
              //         ],
              //       )),
              // ),
              // _buildTile(
              //   Padding(
              //     padding: const EdgeInsets.all(24.0),
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Text('Shop Items',
              //                   style: TextStyle(color: Colors.redAccent)),
              //               Text('173',
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontWeight: FontWeight.w700,
              //                       fontSize: 34.0))
              //             ],
              //           ),
              //           Material(
              //               color: Colors.red,
              //               borderRadius: BorderRadius.circular(24.0),
              //               child: Center(
              //                   child: Padding(
              //                 padding: EdgeInsets.all(16.0),
              //                 child: Icon(Icons.store,
              //                     color: Colors.white, size: 30.0),
              //               )))
              //         ]),
              //   ),
              //   onTap: () => Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (BuildContext context) => ChangeNotifierProvider(
              //         create: (context) => MovieListViewModel(),
              //         builder: (context, child) => MovieListPage(),
              //       ),
              //     ),
              //   ),
              // )
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(2, 220.0),
              StaggeredTile.extent(2, 110.0),
            ],
          ));
    }
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
