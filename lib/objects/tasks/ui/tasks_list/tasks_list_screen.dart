import 'package:do_it_flutter_v2/objects/task/task.dart';
import 'package:do_it_flutter_v2/objects/task/ui/add_task/add_task_screen.dart';
import 'package:do_it_flutter_v2/objects/tasks/ui/tasks_list/tasks_list_provider.dart';
import 'package:do_it_flutter_v2/utils/app_navigator.dart';
import 'package:do_it_flutter_v2/utils/app_router.dart';
import 'package:do_it_flutter_v2/utils/log.dart';
import 'package:do_it_flutter_v2/widgets/adding_floating_action_button.dart';
import 'package:do_it_flutter_v2/widgets/custom_app_bar.dart';
import 'package:do_it_flutter_v2/widgets/custom_item_widget.dart';
import 'package:do_it_flutter_v2/widgets/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/tasks_list_widget.dart';

class TasksListScreen extends StatefulWidget {
  static String get route => AppRouter.addRoute(screen: TasksListScreen());

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends CustomState<TasksListScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TasksListProvider>(context, listen: false);
    return Scaffold(
      appBar:customAppBar(title: "Your Tasks", actions: [IconButton(onPressed: (){provider.logout();}, icon: Icon(Icons.logout),)]),
      body: Consumer<TasksListProvider>(
        builder: (context, provider, child) {
          // TODO: make custom future builder
          return FutureBuilder<int?>(
            future: provider.getTasks(context: context),
            builder: (context, AsyncSnapshot<int?> snapshot) {
              if(snapshot.hasData && snapshot.data != null){
                return TasksListWidget();
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              else if(snapshot.hasError){
                Log.error("${snapshot.error}");
                return Center(child: Text("Error !"));
              }
              return GestureDetector(
                  onTap: () => provider.refresh(),
                  child: Center(child: Text("you don't have tasks"),));
            },
          );
        },
      ),
      floatingActionButton: AddingFloatingActionButton(
        onPressed: (){
          AppNavigator.push(routeName: AddTaskScreen.route);
        },
      ),
    );
  }

  @override
  String get routeName => widget.toString();
}



