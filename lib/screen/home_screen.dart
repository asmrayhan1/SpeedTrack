import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_track/screen/create.dart';
import 'package:speed_track/screen/read.dart';
import 'package:speed_track/view_model/car_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t){
      ref.read(carProvider.notifier).getAllData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(carProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: CupertinoColors.systemBlue, size: 27),
        title: Center(child: Text("SpeedTrack", style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w600),),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.search, color: CupertinoColors.systemBlue, size: 27),
          ),
        ],
      ),
      body: Column(
        children: [
          home.carList.isEmpty? Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text("No Task Found!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),)),
            ),
          ) : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: home.carList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Card(
                        color: Color(0xff00BFFF),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Read(index: index)));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),  // Adjust the radius for rounded corners
                                child: Image.network(
                                  "${home.carList[index].second.imgUrl}",
                                  width: 124,    // Set the width of the square image
                                  height: 124,   // Set the height of the square image
                                  fit: BoxFit.cover,  // Ensure the image fills the square area
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Read(index: index)));
                                },
                                //tileColor: Colors.lightBlueAccent,
                                title: Text("${home.carList[index].second.title}", style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w600)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${home.carList[index].second.description}", maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 15, overflow: TextOverflow.ellipsis)),
                                    SizedBox(height: 7),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(child: Text("\$${home.carList[index].second.price}", style: TextStyle(fontWeight: FontWeight.w500),)),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(child: Text(home.carList[index].second.isSelected? "Available" : "Stock Out", style: TextStyle(fontWeight: FontWeight.w500),)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Update()));
                                      },
                                      child: Icon(Icons.edit, color: Colors.white,),
                                    ),
                                    SizedBox(height: 8),
                                    GestureDetector(
                                        onTap: () async {
                                          await ref.read(carProvider.notifier).deleteRecordByKey(home.carList[index].first);
                                          print("Delete Icon is Working");
                                        },
                                        child: Icon(Icons.delete, color: Colors.white,),//(!home.carList[index].second.isSelected? CircularProgressIndicator() : )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Create()));
          print('FAB Pressed');
        },
        child: Icon(Icons.add, color: Colors.white), // Icon inside the FAB
        //shape: CircleBorder(),
        backgroundColor: Colors.blue, // Background color of FAB
      ),
    );
  }
}
