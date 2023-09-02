import 'package:flutter/material.dart';

class FavScreen extends StatefulWidget {
  var userlist;

  FavScreen({Key? key, this.userlist}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List userInformation = [];

  refreshData() {
    final data = widget.userlist.keys.map((e) {
      final items = widget.userlist.get(e);
      return {"key": e, "name": items["name"], "birthdate": items["birthdate"]};
    }).toList();
    setState(() {
      userInformation = data.reversed.toList();
    });
  }

  @override
  void initState() {
    refreshData();
    print(userInformation);
    //print(widget.persons);
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Favourite"),
        centerTitle: true,
      ),
      body: userInformation == null || userInformation.isEmpty
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/data.png"),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : ListView.builder(
              itemCount: userInformation.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: Text(userInformation[index]["name"])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: Text(userInformation[index]["birthdate"])),
                      ),
                    ],
                  ),
                );
                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     color: Colors.white,
                //     child: ListTile(
                //       title: Text(
                //         userInformation[index]["name"],
                //       ),
                //       trailing: Text(userInformation[index]["birthdate"]),
                //     ),
                //   ),
                // );
              },
            ),
    );
  }
}

  //  leading: Text(
  //                     widget.persons![index]["name"],
  //                   ),
  //                   trailing: Text(widget.persons![index]["birthdate"]),
  //                 );
