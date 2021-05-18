import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Todo App",
    home: App(),
  ));
}

class ListItem{
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck);
}

class _strikeThrough extends StatelessWidget{

  final String todoText;
  final bool todoCheck;
  _strikeThrough(this.todoText, this.todoCheck) : super();

  Widget _widget(){
    if(todoCheck){
      return Text(
        todoText,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
          fontSize: 22.0,
          color: Colors.red[200],
        ),
      );
    }
    else{
      return Text(
        todoText,
        style: TextStyle(
            fontSize: 22.0
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return _widget();
  }
}

class App extends StatefulWidget{

  @override
  AppState createState(){
    return AppState();
  }
}

class AppState extends State<App>{

  var counter = 0;

  var textController = TextEditingController();
  var popUpTextController = TextEditingController();

  List<ListItem> WidgetList = [];

  @override
  void dispose(){
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Todo App"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Enter Todo Text Here"
              ),
              style: TextStyle(
                fontSize: 22.0,
              ),
              controller: textController,
              cursorWidth: 5.0,
              autocorrect: true,
              autofocus: true,
              //onSubmitted: ,
            ),
          ),
          RaisedButton(
            child: Text("Add Todo"),
            onPressed: (){
              if(textController.text.isNotEmpty){
                WidgetList.add(new ListItem(textController.text, false));
                setState(() {
                  textController.clear();
                });
              }
            },
          ),
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for(final widget in WidgetList)
                  ListTile(
                     key: Key(widget.todoText),
                     title: Text(widget.todoText),
                  )
              ],
              onReorder: (oldIndex, newIndex){
                setState(() {
                  if(oldIndex < newIndex){
                    newIndex -= 1;
                  }
                  var replaceWiget = WidgetList.removeAt(oldIndex);
                  WidgetList.insert(newIndex, replaceWiget);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}