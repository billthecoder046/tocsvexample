
import 'package:flutter/material.dart';
import 'package:to_csv/to_csv.dart';

void main() {
  runApp(const MyApp());
  //This is Bill Code
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> header = [];
  List<List<String>> listOfLists = [];
  List<String> data1 = [
    '1',
    'Bilal Saeed',
    '1374934',
    '912839812'
  ]; //Inner list which contains Data i.e Row
  List<String> data2 = ['2', 'Ahmar Ch.', '2134123', '192834821'];
  List<String> data3 = ['3', 'Ahmar Ch.', '22134123', '192834821'];
  List<String> data4 = ['4', 'Shayan S.', '2313413', '192834822'];
  List<String> data5 = ['5', 'Shayan S.', '2211414', '192234821'];
  String imageAssetsPath = 'assets/csvIcon.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    header.add('No.');
    header.add('User Name');
    header.add('Mobile');
    header.add('ID Number');
    listOfLists.add(data1);
    listOfLists.add(data2); //Inner list which contains Data i.e Row
    listOfLists.add(data3); //Inner list which contains Data i.e Row
    listOfLists.add(data4); //Inner list which contains Data i.e Row
    listOfLists.add(data5); //Inner list which contains Data i.e Row
  }
  myData(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
          width: 100,
          child: Image.asset(imageAssetsPath),
        ),
        const Text("My CSV Data",style: TextStyle(color: Colors.black87),),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:  Border.all(color: Colors.black, width: 1.0)
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 30,
          alignment: Alignment.center,
         margin: const EdgeInsets.only(top:12),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: header.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Text(header[i].toString()),
                );
              }),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:  Border.all(color: Colors.black, width: 1.0)
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top:12),
          height: 30,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data1.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Text(data1[i].toString()),
                );
              }),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:  Border.all(color: Colors.black, width: 1.0)
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top:12),
          height: 30,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data2.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Text(data2[i].toString()),
                );
              }),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:  Border.all(color: Colors.black, width: 1.0)
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top:12),
          height: 30,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data3.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Text(data3[i].toString()),
                );
              }),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:  Border.all(color: Colors.black, width: 1.0)
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top:12),
          height: 30,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data4.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Text(data4[i].toString()),
                );
              }),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:  Border.all(color: Colors.black, width: 1.0)
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top:12),
          height: 30,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data5.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Text(data5[i].toString()),
                );
              }),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              myData(context),
              const SizedBox(height: 12,),
              InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0
                      ),
                      color: Colors.yellow,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copy),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Generate CSV")
                      ],
                    ),
                  ),
                  onTap: () async{
                    // bool value = await requestStoragePermission();
                    // if(value == true){

                      await  myCSV(header, listOfLists,setHeadersInFirstRow:false,includeNoRow: true,sharing: false,emptyRowsConfig: {2:2}, removeDuplicates: true, showDuplicateValue:true,noDuplicatedCheckAfterSpecificRow: 3 );
                    // }else{
                    //   print("Permission not granted");
                    // }

                  })
            ],
          ),
        ),
      ),
    );
  }

}
