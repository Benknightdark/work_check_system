import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PunchListWidgets extends StatelessWidget {
  final dynamic data;
  final Function(dynamic item) onShowDetail;

  PunchListWidgets({this.data, this.onShowDetail});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    }

    return ListView.builder(
      itemCount: this.data.length,
      itemBuilder: (context, index) {
        final item = this.data[index];

        return Card(
          child: ListTile(
            leading: Icon(
                item['punchType'] == "work" ? Icons.work : Icons.work_off,
                color:
                    item['punchType'] == "work" ? Colors.green : Colors.orange),
            subtitle: Text(item['punchDateTime']),
            title: Text(item['punchType'] == "work" ? "😢上班打卡" : "😊下班打卡"),
            onTap: () async {
              await onShowDetail(item);
            },
          ),
        );
      },
    );
  }
}
