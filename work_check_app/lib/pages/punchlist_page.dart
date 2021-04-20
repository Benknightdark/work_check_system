import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PunchlistViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('打卡歷史資料'),
        actions: [
          IconButton(
            icon: Icon(vm.showCalendar ? Icons.list : Icons.calendar_today),
            tooltip: vm.showCalendar ? '切換為列表顯示' : "切換為日歷顯示",
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
                    ? Expanded(child: PunchListWidgets(data: vm.punchlist))
                    : Expanded(child: CalenderWidget(data: vm.punchlist))
              ])),
        ),
      ),
    );
  }
}
