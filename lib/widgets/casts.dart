import 'package:flutter/material.dart';

class Casts extends StatefulWidget {
  @override
  _CastsState createState() => _CastsState();
}

class _CastsState extends State<Casts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    castsBloc..getCasts(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
