import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_check_app/pages/map_page.dart';

class PunchDetailService {
  void showDetail(BuildContext context, dynamic item) {
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
                                  MapPage(data: item)),
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
}
