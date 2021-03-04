import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:work_check_app/pages/map_page.dart';
import 'package:work_check_app/view_models/punchlist_view_model.dart';
import 'package:work_check_app/widgets/calender.dart';
import 'package:work_check_app/widgets/punch_list.dart';

class PunchlistPage extends StatefulWidget {
  @override
  _PunchlistPageState createState() => _PunchlistPageState();
}

class _PunchlistPageState extends State<PunchlistPage> {
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: '載入中');

    Provider.of<PunchlistViewModel>(context, listen: false)
        .fetchPunchList()
        .then((value) => EasyLoading.dismiss());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showDetail(dynamic item) {
    print(item);
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (
        BuildContext context,
        Animation animation,
        Animation secondaryAnimation,
      ) {
        return Center(
            child: Card(
                // height: 400,
                // width: 250,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, //just set this property
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: item['punchType'] == "work"
                              ? Colors.blueAccent
                              : Colors.greenAccent,
                        ),
                        // width: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              item['punchType'] == "work" ? "😢上班打卡" : "😊下班打卡",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      leading: const Icon(Icons.lock_clock),
                      title: Text('打卡時間'),
                      subtitle: Text(item['punchDateTime']),
                    ),
                    ListTile(
                      leading: const Icon(Icons.place),
                      title: Text('經緯度'),
                      subtitle: Text("(" +
                          item['latitude'] +
                          "," +
                          item['longtitude'] +
                          ")"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (
                            context,
                          ) =>
                                  MapPage(
                                      data: item, onShowDetail: _showDetail)),
                        );
                      },
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    ),
                    ListTile(
                      leading: const Icon(Icons.network_check_rounded),
                      title: Text('wifiBSSId'),
                      subtitle: Text(item['wifiBSSId']),
                    ),
                    ListTile(
                      leading: const Icon(Icons.network_check_rounded),
                      title: Text('wifiIP'),
                      subtitle: Text(item['wifiIP']),
                    ),
                    ListTile(
                      leading: const Icon(Icons.network_check_rounded),
                      title: Text('wifiName'),
                      subtitle: Text(item['wifiName']),
                    ),
                  ],
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PunchlistViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('打卡歷史資料'),
        actions: [
          IconButton(
            icon: Icon(vm.showCalendar ? Icons.calendar_today : Icons.list),
            tooltip: vm.showCalendar ? '日歷顯示' : "列表顯示",
            onPressed: () {
              vm.changeDisplay();
              // print(vm.showCalendar);
            },
          ),
        ], //PunchListWidgets(data: vm?.punchlist)
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await vm.fetchPunchList();
        },
        child: InkWell(
          child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
                vm.showCalendar == false
                    ? Expanded(
                        child: PunchListWidgets(
                        data: vm.punchlist,
                        onShowDetail: _showDetail,
                      ))
                    : Expanded(
                        child: CalenderWidget(
                            data: vm.punchlist, onShowDetail: _showDetail))
              ])),
        ),
      ),
    );
  }
}
