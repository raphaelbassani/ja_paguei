import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../extensions/extensions.dart';
import 'jp_text.dart';

class JPCalendar extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime?) onChanged;

  const JPCalendar({
    required this.initialDate,
    required this.onChanged,
    super.key,
  });

  @override
  State<JPCalendar> createState() => _JPCalendarState();
}

class _JPCalendarState extends State<JPCalendar> {
  late PageController _pageController;
  CalendarFormat calendarFormat = CalendarFormat.month;
  late final ValueNotifier<DateTime> focusedDay;

  @override
  void initState() {
    super.initState();

    focusedDay = ValueNotifier(widget.initialDate);
  }

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
                setState(() {});
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
                setState(() {});
              },
            );
          },
        ),
        TableCalendar(
          onCalendarCreated: (controller) => _pageController = controller,
          headerVisible: false,
          firstDay: DateTime(
            context.now.year,
            context.now.month - 1,
            context.now.day - 15,
          ),
          lastDay: DateTime(
            context.now.year,
            context.now.month,
            context.now.day,
          ),
          locale: context.jpLocale,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: const TextStyle(fontSize: 12.0),
            weekendStyle: TextStyle(
              fontSize: 12.0,
              color: context.textColor.withAlpha(100),
            ),
            dowTextFormatter: (date, day) {
              return DateFormat.E(day).format(date).capitalizeFirstLetter();
            },
          ),
          calendarStyle: CalendarStyle(
            disabledTextStyle: const TextStyle(color: Colors.transparent),
            selectedDecoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: context.textColor,
              fontSize: 16.0,
            ),
            outsideTextStyle: const TextStyle(color: Colors.transparent),
            weekendTextStyle: TextStyle(
              color: context.textColor.withAlpha(100),
            ),
            todayTextStyle: const TextStyle(
              color: Colors.green,
              fontSize: 16.0,
            ),
            todayDecoration: const BoxDecoration(color: Colors.transparent),
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
                widget.onChanged(newFocusedDay);
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
          JPText(context.mmmmYYYY(focusedDay), type: JPTextTypeEnum.l),
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
