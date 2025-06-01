import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteFunction, required this.setReminderFunction, required this.editFunction, required this.setDueDateFunction, this.reminderTime, this.dueDate});

  final String taskName;
  final bool taskCompleted;
  final DateTime? reminderTime;
  final DateTime? dueDate;
  final Function(bool?)? onChanged;
  final Function(BuildContext) ? deleteFunction;
  final Function()? setReminderFunction;
  final Function()? editFunction;
  final Function()? setDueDateFunction;

  @override
  Widget build(BuildContext context) {
    String formatDateTime(DateTime? dt) {
      if (dt == null) return '';
      return DateFormat('MMM d, yyyy hh:mm a').format(dt.toLocal());
    }

    String formatDate(DateTime? dt) {
      if (dt == null) return '';
      return DateFormat('MMM d, yyyy').format(dt.toLocal());
    }

    bool isOverdue = dueDate != null && !taskCompleted && dueDate!.isBefore(DateTime.now().subtract(Duration(days: 1)));
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: 0,
      ),
      child: Slidable(
        key: Key(taskName + (reminderTime?.toIso8601String() ?? '') + (dueDate?.toIso8601String() ?? '')),
        endActionPane: ActionPane(motion: StretchMotion(), children: [SlidableAction(onPressed: deleteFunction, icon: Icons.delete, backgroundColor: Colors.redAccent, foregroundColor: Colors.white, borderRadius: BorderRadius.circular(12),),],),
        startActionPane: ActionPane( // Added start action pane for edit
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => editFunction?.call(),
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            border: isOverdue ? Border.all(color: Colors.orange.shade700, width: 1.5) : null,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskName,
                      style: TextStyle(
                        color: taskCompleted ? Colors.grey[500] : Colors.grey[850],
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        decorationColor: Colors.grey[500],
                        decorationThickness: 1.5,
                      ),
                    ),
                    if (dueDate != null || reminderTime != null)
                      const SizedBox(height: 6),
                    if (dueDate != null)
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 14, color: isOverdue ? Colors.orange.shade800 : Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Due: ${formatDate(dueDate)}',
                            style: TextStyle(
                              color: isOverdue ? Colors.orange.shade800 : Colors.grey[600],
                              fontSize: 13,
                              fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    if (reminderTime != null)
                      Padding(
                        padding: EdgeInsets.only(top: dueDate != null ? 4.0 : 0),
                        child: Row(
                          children: [
                            Icon(Icons.notifications_active_outlined, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              'Reminder: ${formatDateTime(reminderTime)}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: taskCompleted ? Colors.grey[400] : Colors.teal,
                      size: 22,
                    ),
                    tooltip: "Set/Change Due Date",
                    onPressed: taskCompleted ? null : setDueDateFunction,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_on_outlined,
                      color: taskCompleted ? Colors.grey[400] : Colors.purpleAccent[100],
                      size: 22,
                    ),
                    tooltip: "Set/Change Reminder",
                    onPressed: taskCompleted ? null : setReminderFunction,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
