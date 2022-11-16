import 'package:flutter/material.dart';
import 'package:to_do/moor_db/database_helpers.dart';
import 'package:to_do/repository/to_do_repository.dart';

class SerachScreen extends StatefulWidget {
  final List<DBTask> tasks;
  const SerachScreen({
    super.key,
    required this.tasks,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SerachScreen> {
  List<DBTask> _foundedUsers = [];
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    setState(() {
      _foundedUsers = widget.tasks;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedUsers = widget.tasks
          .where((user) => user.Title.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Search task"),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: _foundedUsers.isNotEmpty
            ? ListView.builder(
                itemCount: _foundedUsers.length,
                itemBuilder: (context, index) {
                  return userComponent(user: _foundedUsers[index]);
                })
            : const Center(
                child: Text(
                "No users found",
                style: TextStyle(color: Colors.white),
              )),
      ),
    );
  }

  userComponent({required DBTask user}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.Title,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(user.Description, style: TextStyle(color: Colors.grey[500])),
            ])
          ]),
        ],
      ),
    );
  }
}
