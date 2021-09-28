import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../constants.dart';

class EditingScreen extends StatefulWidget {
  final String name;
  final String weight;
  final String id;
  const EditingScreen({Key? key, required this.name,required this.weight,required this.id}) : super(key: key);

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {

  final firestore=FirebaseFirestore.instance;
  late String name;
  late String weight;
  @override
  void initState() {
    name=widget.name;
    weight=widget.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10,0),
          child: TextFormField(
            autofocus: true,
            initialValue: widget.name,
            textCapitalization: TextCapitalization.words,
            onChanged: (value)
            {
              name=value;
            },
            decoration: inputDecoration.copyWith(hintText: 'Your name'),
            style: kTextStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 30),
          child: TextFormField(
            initialValue: widget.weight,
            autofocus: false,
            keyboardType: TextInputType.number,
            onChanged: (value)
            {
              weight=value;
            },
            decoration: inputDecoration.copyWith(hintText: 'Your weight in Kg '),
            style: kTextStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.35),
          child: MaterialButton(
            color: Colors.white,
            onPressed: () async{
              if(name!='' && weight!='')
                  {
                    await firestore.collection('details').doc(widget.id).update({
                      'name':name,
                      'weight':weight,
                    });
                    FocusScope.of(context).unfocus();
                    snackBar(context, 'Details updated !');
                    Navigator.pop(context);
                  }
                  else{
                alertBox(context, 'Enter correct values');
                  }
            },
            child: const Text('Update'),
          ),
        )
      ],
    );
  }
}
