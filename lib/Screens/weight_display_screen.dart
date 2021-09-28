import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:troovi_app/Components/EntryWidget.dart';
import '../constants.dart';


class DisplayScreen extends StatefulWidget {
  final String? currentUser;
  const DisplayScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final _firestore=FirebaseFirestore.instance;
  late  String userName;
  late  String name;
  late  String weight;
  final TextEditingController textController1=TextEditingController();
  final TextEditingController textController2=TextEditingController();
  final _auth=FirebaseAuth.instance;

  @override
  void initState() {
    userName=widget.currentUser!;
    super.initState();
  }

  post() async
  {
    try
    {
      await _firestore.collection("details").add(
          {
            'name':name,
            'weight':weight,
            'time':Timestamp.now()
          }
      );
    }
    catch(error)
    {
      alertBox(context,'Enter correct values');
    }
    FocusScope.of(context).unfocus();
    textController1.clear();
    textController2.clear();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('User: $userName',style: const TextStyle(fontSize: 12),),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFFA020F1),
          actions: [
            IconButton(icon: const Icon(Icons.logout), onPressed: () {
              _auth.signOut();
              Navigator.pop(context); },
            )
          ],
        ),
        backgroundColor: const Color(0xFFA020F1),
        body: ListView(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Add New Entries',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF21192E),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10,20),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                onChanged: (value)
                {
                  name=value;
                },
                controller: textController1,
                decoration: inputDecoration.copyWith(hintText: 'Your name'),
                style: kTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value)
                {
                  weight=value;
                },
                controller: textController2,
                decoration: inputDecoration.copyWith(hintText: 'Your weight in Kg '),
                style: kTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3,vertical: 20),
              child: Material(
                color: Colors.transparent,
                elevation: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async{
                      await post();
                    },
                    child: kSubmitButton,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
              color: Colors.white,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'All Previous Entries',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF21192E),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream:  _firestore.collection('details').orderBy('time', descending: true).snapshots(),
                builder: (context,snapshot) {
                  List<WeightEntries> entries=[];
                  if(!snapshot.hasData)
                  {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  List<QueryDocumentSnapshot<Object?>> files = snapshot.data!.docs;
                  for(var file in files)
                  {
                    final data=file.data() as Map;
                    final name=data['name'];
                    final weight=data['weight'];
                    final id=file.id;
                    final entry=WeightEntries(name: name,weight: weight,id: id);
                    entries.add(entry);
                  }
                  return Column(
                    children: entries,
                  );
                }),
          ],
        ),
      ),
    );
  }
}


