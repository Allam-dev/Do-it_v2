import 'package:do_it_flutter_v2/objects/task/ui/task_item/task_item_provider.dart';
import 'package:do_it_flutter_v2/objects/tasks/view/tasks_list/tasks_list_provider.dart';
import 'package:do_it_flutter_v2/utils/app_colors.dart';
import 'package:do_it_flutter_v2/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../task.dart';


class CheckedTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskItemProvider>(context, listen: false);
  final tasksProvider = Provider.of<TasksListProvider>(context, listen: false);
    return CustomItemWidget(
      text: "${taskProvider.title}",
      circleColor: AppColors.grey,
      textStyle: TextStyle(decoration: TextDecoration.lineThrough),
      tapOnCircle: () {
        taskProvider.check().then((value) => tasksProvider.refresh());
      },
      deleteItem: () async {
        await taskProvider.delete().then((value) => tasksProvider.refresh());
      },
    );
  }
}
