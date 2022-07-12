import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/view_models/note_view_model.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  String _startDateController = "";
  String _endDateController = "";
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Provider.of<NotesProvider>(context, listen: false).add(Note(
                    title: _titleController.text,
                    details: _detailsController.text,
                    start: _startDateController,
                    end: _endDateController));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Text(Provider.of<NotesProvider>(context).noteList.toString()),
          Container(
              child: TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.title),
              hintText: 'Enter the title',
              labelText: 'Title',
            ),
            controller: _titleController,
          )),
          TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2022, 7, 12),
                    maxTime: DateTime(2022, 31, 12), onChanged: (date) {
                  _startDateController = DateFormat("yyyy-MM-dd").format(date);
                  
                }, onConfirm: (date) {
                      _startDateController = DateFormat("yyyy-MM-dd").format(date);
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Chose when your work start',
                style: TextStyle(color: Colors.blue),
              )),
              TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2022, 7, 12),
                    maxTime: DateTime(2022, 31, 12), onChanged: (date) {
                  _endDateController = DateFormat("yyyy-MM-dd").format(date);
                  
                }, onConfirm: (date) {
                      _endDateController = DateFormat("yyyy-MM-dd").format(date);
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Chose when your work end',
                style: TextStyle(color: Colors.blue),
              )),
          Container(
              child: TextFormField(
            maxLines: 10,
            decoration: const InputDecoration(
              icon: Icon(Icons.details),
              hintText: 'Enter details of your work',
              labelText: 'Details',
            ),
            controller: _detailsController,
          )),
        ],
      ),
    ));
  }
}
