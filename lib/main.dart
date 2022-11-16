import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubit/add_task_bloc.dart';
import 'package:to_do/logic/cubit/tomorrow_cubit.dart';
import 'package:to_do/logic/cubit/update_task_bloc.dart';
import 'package:to_do/moor_db/database_helpers.dart';
import 'package:to_do/view/add_task_screen.dart';
import 'package:to_do/view/constants.dart';
import 'package:to_do/view/search_screen.dart';
import 'package:to_do/view/update_task_screen.dart';
import 'package:to_do/view/widget/text_widgets.dart';

import 'logic/cubit/today_cubit.dart';
import 'logic/cubit/upcomming_cubit.dart';
import 'logic/states/todo_state.dart';
import 'repository/to_do_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TodayCubit>(
            create: (context) => TodayCubit(repository: repository)..load(),
          ),
          BlocProvider<TommorrowCubit>(
            create: (context) => TommorrowCubit(repository: repository)..load(),
          ),
          BlocProvider<UpcomingCubit>(
            create: (context) => UpcomingCubit(repository: repository)..load(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To Do Task"),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    getAllTask().then((value) => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SerachScreen(tasks: value)))
                        });
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                )),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Today"),
              Tab(text: "Tomorrow"),
              Tab(text: "Upcoming"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            /// Today TAB
            BlocBuilder<TodayCubit, ToDoState>(
              builder: (context, state) {
                if (state.isFailed) {
                  return const Center(child: Text("Failed to fetch task"));
                }
                if (state.isLoading) {
                  return const Center(child: Text("Loading..."));
                }
                return Scaffold(
                  body: Container(
                    color: color2,
                    child: ListWidget(state.task, Colors.green),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AddTaskBloc(),
                                child: const AddTaskScreen(
                                  type: "today",
                                  title: '',
                                  description: '',
                                ),
                              )));
                    },
                    child: const Icon(Icons.add),
                  ),
                );
              },
            ),

            /// Tomorrow TAB
            BlocBuilder<TommorrowCubit, ToDoState>(
              builder: (context, state) {
                if (state.isFailed) {
                  return const Center(child: Text("Failed to fetch task"));
                }
                if (state.isLoading) {
                  return const Center(child: Text("Loading..."));
                }
                return Scaffold(
                  body: Container(
                    color: color2,
                    child: ListWidget(state.task, Colors.red),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AddTaskBloc(),
                                child: const AddTaskScreen(
                                  type: "tomorrow",
                                  title: '',
                                  description: '',
                                ),
                              )));
                    },
                    child: const Icon(Icons.add),
                  ),
                );
              },
            ),

            ///Upcoming TAb
            BlocBuilder<UpcomingCubit, ToDoState>(
              builder: (context, state) {
                if (state.isFailed) {
                  return const Center(child: Text("Failed to fetch task"));
                }
                if (state.isLoading) {
                  return const Center(child: Text("Loading..."));
                }
                return Scaffold(
                  body: Container(
                    color: color2,
                    child: ListWidget(state.task, Colors.blue),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AddTaskBloc(),
                                child: const AddTaskScreen(
                                  type: "upcoming",
                                  title: '',
                                  description: '',
                                ),
                              )));
                    },
                    child: const Icon(Icons.add),
                  ),
                );
              },
            ),

            // RECENT TAB
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  ListWidget(List<DBTask> data, MaterialColor color) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => UpdateTaskBloc(),
                            child: UpdateTaskScreen(
                              type: data[index].type,
                              title: data[index].Title,
                              description: data[index].Description,
                              iid: data[index].id,
                            ),
                          )));
                },
                child: Container(
                  height: 110,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///radio section
                      Row(
                        children: [
                          Radio(
                              activeColor: color,
                              value: "",
                              groupValue: "",
                              onChanged: (index) {}),

                          ///product title with prize
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SimpleTextWidget(
                                    title: "Task : ${index + 1}",
                                    fontSize: 14,
                                    color: color,
                                    fontWeight: FontWeight.bold),
                                SimpleTextWidget(
                                    title: data[index]
                                        .Title
                                        .toString()
                                        .toUpperCase(),
                                    fontSize: 14,
                                    color: color,
                                    fontWeight: FontWeight.bold),
                                SimpleTextWidget(
                                    title: "${data[index].Description}",
                                    fontSize: 12,
                                    color: gray,
                                    fontWeight: FontWeight.normal),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )

                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(
                //           color: color, // Set border color
                //           width: 3.0), // Set border width
                //       borderRadius: const BorderRadius.all(
                //           Radius.circular(10.0)), // Set rounded corner radius
                //       boxShadow: const [
                //         BoxShadow(
                //             blurRadius: 10,
                //             color: Colors.black,
                //             offset: Offset(1, 3))
                //       ]),
                //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                //   child: Row(
                //     children: [
                //       Container(
                //         color: color,
                //         width: 10,
                //         height: 20,
                //         child: Center(
                //           child: Text(
                //             "${index + 1}",
                //             style: const TextStyle(
                //                 color: Colors.white, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             data[index].Title.toUpperCase(),
                //             style: TextStyle(
                //                 color: color,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 14),
                //           ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           Text(
                //             data[index].Description,
                //             style: const TextStyle(
                //                 fontWeight: FontWeight.normal, fontSize: 12),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                ),
          ],
        );
      },
    );
  }
}

Future<List<DBTask>> getAllTask() async {
  List<DBTask> tasks = [];
  final databaseInstance = AppDatabase.sharedInstance;
  try {
    final _tasks = await TasksDao(databaseInstance).getAllTask();
    tasks.addAll(_tasks);
  } catch (ex) {
    tasks = [];
  }
  return tasks;
}
