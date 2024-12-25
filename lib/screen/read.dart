import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_track/view_model/car_controller.dart';

class Read extends ConsumerWidget {
  int index;
  Read({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(carProvider).carList;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, color: CupertinoColors.activeBlue, size: 27,),
        ),
        title: Center(child: Text("${home[index].second.title}    ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),)),
        actions: [
          Text(" "),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),  // Adjust the radius for rounded corners
                  child: Image.network(
                    "${home[index].second.imgUrl}",
                    width: 124,    // Set the width of the square image
                    height: 124,   // Set the height of the square image
                    fit: BoxFit.cover,  // Ensure the image fills the square area
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(child: Text("Available:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Yes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      Checkbox(
                        value: home[index].second.isSelected,  // Value of the checkbox
                        onChanged: (bool? newValue) {

                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("No", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      Checkbox(
                        value: home[index].second.isSelected? false : true,  // Value of the checkbox
                        onChanged: (bool? newValue) {

                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Price:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(width: 7),
                  Text("\$${home[index].second.price}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 20),
              Center(child: Text("Description:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),)),
              SizedBox(width: 15),
              Text("\$${home[index].second.description}", maxLines: 25, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
            ],
          ),
        ),
      ),
    );
  }
}

