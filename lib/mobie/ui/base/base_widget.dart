import 'package:flutter_review_movie/core/core.dart';
import 'package:flutter/material.dart';

abstract class BaseWidget extends StatefulWidget {
  final BaseBloc baseBloc;

  const BaseWidget(this.baseBloc, {Key key}) : super(key: key);

  Widget body(BuildContext context);

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  void _showErrorDialog(BuildContext context, String textError) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error Title'),
            content: Text(textError),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    widget.baseBloc.errorStream.listen((error) {
      if (error.isNotEmpty) _showErrorDialog(context, error);
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.baseBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.body(context);
  }
}
