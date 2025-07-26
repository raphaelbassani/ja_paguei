import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../src/helpers/extensions.dart';
import '../../src/helpers/format.dart';
import '../../ui.dart';

class JPCalendar extends StatefulWidget {
  const JPCalendar({super.key});

  @override
  State<JPCalendar> createState() => _JPCalendarState();
}

class _JPCalendarState extends State<JPCalendar> {
  late PageController _pageController;
  CalendarFormat calendarFormat = CalendarFormat.month;
  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());

  @override
  void dispose() {
    focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
              focusedDay: value,
              onLeftArrowTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            );
          },
        ),
        TableCalendar(
          onCalendarCreated: (controller) => _pageController = controller,
          headerVisible: false,
          firstDay: context.now.subtract(Duration(days: 365)),
          lastDay: context.now.add(Duration(days: 365)),
          locale: 'pt_BR',
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontSize: 12.0),
            weekendStyle: TextStyle(
              fontSize: 12.0,
              color: context.textColor.withAlpha(100),
            ),
            dowTextFormatter: (date, day) {
              return DateFormat.E(day).format(date).capitalizeFirstLetter();
            },
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: context.textColor,
              fontSize: 16.0,
            ),
            outsideTextStyle: TextStyle(color: Colors.transparent),
            weekendTextStyle: TextStyle(
              color: context.textColor.withAlpha(100),
            ),
            todayTextStyle: TextStyle(color: Colors.green, fontSize: 16.0),
            todayDecoration: BoxDecoration(color: Colors.transparent),
          ),
          focusedDay: focusedDay.value,
          calendarFormat: calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(focusedDay.value, day);
          },
          onDaySelected: (_, newFocusedDay) {
            if (!isSameDay(focusedDay.value, newFocusedDay)) {
              setState(() {
                focusedDay.value = newFocusedDay;
              });
            }
          },
        ),
      ],
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const _CalendarHeader({
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          const Spacer(),
          JPText(Format.mmmmYYYY(focusedDay), type: JPTextTypeEnum.l),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
