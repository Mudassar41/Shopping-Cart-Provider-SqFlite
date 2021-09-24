import 'package:flutter/material.dart';
import 'package:sqlite/dbmanager.dart';
import 'package:sqlite/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );

  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dbmanaget db=new Dbmanaget();
  Student st;
  final _namecontroll=TextEditingController();
  final _coursecontroll=TextEditingController();
  final _fromKey=new GlobalKey<FormState>();
  List<Student> list;
@override
  void initState() {


  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLITE DEMO"),),body:
      ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(key: _fromKey,child: Column(children: <Widget>[

            TextFormField(decoration: InputDecoration(labelText: "NAME"),controller: _namecontroll,validator: (val)=>val.isNotEmpty?null:"NAME SHOULD NOT BE EMPTY",),
            TextFormField(decoration: InputDecoration(labelText: "course"),controller: _coursecontroll,validator: (val)=>val.isNotEmpty?null:"Course SHOULD NOT BE EMPTY"
              ,)
            ,RaisedButton(onPressed: (){
              _submit(context);
            },color: Colors.blue,child: Text("SAVE"),textColor: Colors.white,),
            FutureBuilder(future: db.dogs(provider),builder: (context,snapshot){

              if(snapshot.hasData){
list=snapshot.data;
return ListView.builder(itemBuilder: (BuildContext,int position){

  Student st=list[position];
  return Card(
    child: Column(
      children: <Widget>[

        Text(st.name),
        Text(st.course),


      ],
    ),
    color: Colors.white,
    elevation: 2.0,);
},shrinkWrap: true,itemCount: list==null?0:list.length,);}

              return new CircularProgressIndicator();
            },)


          ],),),
        )

      ],),
    );
  }

  void _submit(BuildContext context) {

    if(_fromKey.currentState.validate()){

   if(st==null){
     print('error');
 Student std=new Student(name:_namecontroll.text,course: _coursecontroll.text );
db.insert(std,).then((id)=>{

_coursecontroll.clear(),
_namecontroll.clear(),
  //print('id is {$id}')

});

   }


    }

  }
}


