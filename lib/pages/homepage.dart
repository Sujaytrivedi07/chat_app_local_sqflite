
import 'package:chat_room_day2/constant_variable.dart';
import 'package:flutter/material.dart';

import 'group_details.dart';
class ChatHomepage extends StatefulWidget {
  const ChatHomepage({Key? key}) : super(key: key);

  @override
  State<ChatHomepage> createState() => _ChatHomepageState();
}

class _ChatHomepageState extends State<ChatHomepage> {
  var chatGroup=["GROUP FIRST","GROUP SECOND","GROUP THIRD"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
         actions: [
         Padding(
           padding: const EdgeInsets.only(right: 160),
           child: Text("Groups",style: TextStyle(
             color: Colors.lime,
             fontSize: 20,
             fontWeight: FontWeight.bold
           )),
         )
         ],
        title: Icon(Icons.group),
      ),
      body: ListView.builder(itemCount:chatGroup.length,itemBuilder: (context, index) => InkWell(
        // onTap: (){
        //
        //   },
        child: Card(
          color: Colors.yellow,
          child: ListTile(
            leading: Icon(Icons.group,color: Colors.green),
            title: Text("${chatGroup[index]}"),
            trailing: IconButton(
              onPressed: (){
                ConstantVarible.index=index;
                Navigator.push(context,MaterialPageRoute(builder: (context) => GroupDetails(title:chatGroup[index]),));
                print(">>>>>>>>>>>>>>>${ConstantVarible.index}");
              },icon: Icon(Icons.navigate_next_outlined),
            ),
          ),
        ),
      ),),
    );
  }
}
