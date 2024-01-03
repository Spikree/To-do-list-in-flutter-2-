import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: Colors.green,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: Colors.white),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 57, 57, 55),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
