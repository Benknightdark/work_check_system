import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:work_check_app/services/punch_detail_service.dart";

class CalenderWidget extends StatefulWidget {
  CalenderWidget({this.data});
  final dynamic data;

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget>
    with TickerProviderStateMixin {
  Map<DateTime, List>? _events;
  List? _selectedEvents;
  AnimationController? _animationController;
  CalendarController? _calendarController;

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

    _events = {};
    print(widget.data);
    widget.data.forEach((element) {
      var punchDateTime = (element['punchDateTime'].toString())
          .replaceAll('/', '-')
          .split(" ")[0];
      var punchTypeName = element['punchType'] == "work" ? "😢上班打卡" : "😊下班打卡";
      if (_events?[DateTime.parse(punchDateTime)] == null) {
        _events?[DateTime.parse(punchDateTime)] = [
          {
            "title": punchTypeName + " (" + element['punchDateTime'] + ")",
            "details": element
          }
        ];
      } else {
        _events?[DateTime.parse(punchDateTime)]?.add({
          "title": punchTypeName + " (" + element['punchDateTime'] + ")",
          "details": element
        });
      }
    });
    print(_events);
    _selectedEvents = _events?[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _calendarController?.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    print(events);
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // Switch out 2 lines below to play with TableCalendar's settings
        //-----------------------
        _buildTableCalendar(),
        // _buildTableCalendarWithBuilders(),
        const SizedBox(height: 8.0),
        //_buildButtons(),
        const SizedBox(height: 8.0),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'zh_TW',
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          ?.map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event['title'].toString()),
                  onTap: () {
                    print(event);
                    PunchDetailService().showDetail(context, event['details']);
                  },
                ),
              ))
          .toList(),
    );
  }
}
