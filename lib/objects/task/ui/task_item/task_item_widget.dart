import 'package:do_it_flutter_v2/objects/task/ui/task_item/task_item_provider.dart';
import 'package:do_it_flutter_v2/objects/tasks/ui/tasks_list/tasks_list_provider.dart';
import 'package:do_it_flutter_v2/utils/app_colors.dart';
import 'package:do_it_flutter_v2/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../task.dart';
import 'widgets/checked_task.dart';
import 'widgets/unchecked_task.dart';

class TaskItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskItemProvider>(context, listen: false);
    if(provider.done){
      return CheckedTask();
    }else{
      return UncheckedTask();
    }
  }

}
