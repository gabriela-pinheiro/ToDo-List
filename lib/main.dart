import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _toDoList = ['Marcos', 'Daniel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ToDo List'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Nova Tarefa',
                        labelStyle: TextStyle(color: Colors.teal)
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.teal,
                  child: Text('ADD'),
                  textColor: Colors.white,
                  onPressed: (){},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: (context, index){
                return CheckboxListTile(
                  title: Text(_toDoList[index]['title']),
                  value: _toDoList[index]['ok'],
                  secondary: CircleAvatar(
                    child: Icon(_toDoList[index]['ok'] ? Icons.check : Icons.error),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //obter arquivo
  Future<File> _getfile() async{
    final directory = await getApplicationDocumentsDirectory(); //retorna o diretório de armazenamento do app
    return File('${directory.path}/data.json'); //especificar o caminho do diretório
  }

  //salvar arquivo
  Future<File> _saveData() async{
    String data = json.encode(_toDoList); //transformar a lista em json
    final file = await _getfile(); //"pegar" o arquivo
    return file.writeAsString(data); // retorna o arquivo como texto
  }

  //ler arquivo
  Future<String> _readData() async{
    try {
      final file = await _getfile();
      return file.readAsString();
    } catch (e){
      return null;
    }
  }

}

