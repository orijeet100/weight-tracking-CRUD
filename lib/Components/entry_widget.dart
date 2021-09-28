import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:troovi_app/Screens/editing_details_screen.dart';
import '../constants.dart';
import 'package:intl/intl.dart';

class WeightEntries extends StatelessWidget {

  WeightEntries({Key? key, required this.name, required this.weight, required this.id,required this.time}) : super(key: key);
  final String name;
  final String weight;
  final String id;
  final Timestamp time;
  final firestore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {//DateTime
    var date = time.toDate();
    var dateValue=DateFormat('hh:mm a  dd-MM-yyy').format(date);
    return Padding(
      padding:const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        decoration: BoxDecoration(
          color: const Color(0xFF21192E),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
              child: Text(
                'Name: $name',
                textAlign: TextAlign.start,
                style: kWeightEntriesStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 15),
              child: Text(
                'Weight: $weight KG',
                textAlign: TextAlign.start,
                style: kWeightEntriesStyle.copyWith(color: Colors.amber),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.white,
                  onPressed: () async{
                    showModalBottomSheet(
                        context: context, builder: (context) =>Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF021422),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30)),
                        ),
                        child:EditingScreen(name: name, weight: weight, id: id)
                    ),backgroundColor: Colors.transparent);
                  },
                  child: const Text('Edit'),
                ),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () async{
                    await firestore.collection('details').doc(id).delete();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Text(
                  'Time: $dateValue',
                  textAlign: TextAlign.start,
                  style: kWeightEntriesStyle.copyWith(fontSize: 15,color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}