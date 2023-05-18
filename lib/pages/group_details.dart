import 'dart:developer';

import 'package:chat_room_day2/constant_variable.dart';
import 'package:chat_room_day2/database_helper/message_model.dart';
import 'package:chat_room_day2/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../database_helper/database_helper.dart';
import '../service_provider/provider_class.dart';
class GroupDetails extends StatefulWidget {
  final String title;
  const GroupDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  TextEditingController messagecontroller=TextEditingController();
   List<String>? messages=[];
  late AppProvider appProvider;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    loadmessage();
    print(messages);
  //  scroll();


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    appProvider = context.watch<AppProvider>();
    return
      SizedBox(
      height: MediaQuery.of(context).size.height,
      width:MediaQuery.of(context).size.width,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade300,
          title: Text(widget.title),
        ),
        body:Padding(

          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
          Expanded(child: ListView.builder(reverse: false,shrinkWrap: true,itemCount: messages!.length,
          controller: _scrollController,

            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
             // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(messages?[index]??"",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                    fontSize:15,)),
                  ),
                ),
              ],
            ),)),

   Align(
       alignment: Alignment.bottomCenter,
       child: Row(
           children: [
             SizedBox(
              width: 330,
               child: TextFormField(
               controller: messagecontroller,
               decoration: InputDecoration(
                 suffixIcon: IconButton(icon: Icon(Icons.send),onPressed: ()async {

                    await DataBaseHelper.instance.insertrecord({
                     DataBaseHelper.columnName:messagecontroller.text,
                    },ConstantVarible.index);


                    var dbquery=await DataBaseHelper.instance.queryDatabase(ConstantVarible.index);
                   // messages.add(dbquery);
                    print(dbquery);
                    messages?.add(messagecontroller.text);

                   appProvider.refresh();
                    messagecontroller.clear();
                 }),
               ),
             ),
             // IconButton(onPressed: (){}, icon: Icon(Icons.send))
             ) ],
       ),
   )
            ],
          ),
        ),
      ),
    );
  }
  loadmessage()async{
    var dbquery=await DataBaseHelper.instance.queryDatabase(ConstantVarible.index);
    dbquery.forEach((element) {
      messages?.add(
          element["name"]);});
    appProvider.refresh();
    scroll();

  }
  scroll(){
    _scrollController.animateTo(
  _scrollController.position.maxScrollExtent,
  curve: Curves.easeOut,
  duration: const Duration(milliseconds: 300),
  );
    appProvider.refresh();
  }
}

