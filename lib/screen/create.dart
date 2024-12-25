import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_track/model/car_model.dart';
import 'package:speed_track/view_model/car_controller.dart';

class Create extends ConsumerStatefulWidget {
  const Create({super.key});

  @override
  ConsumerState<Create> createState() => _CreateState();
}

class _CreateState extends ConsumerState<Create> {

  TextEditingController _imgController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool yes = false;
  bool no = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, color: CupertinoColors.activeBlue, size: 27,),
        ),
        title: Center(child: Text("Create ", style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w600),),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () async {
                  String title = _titleController.text.trim();
                  String price = _priceController.text.trim();
                  String url = _imgController.text.trim();
                  print(url);
                  String description = _descriptionController.text.trim();
                  CarModel model = CarModel(isSelected: yes, title: title, price: price, imgUrl: url, description: description);
                  await ref.read(carProvider.notifier).saveData(model.toJson());
                },
                child: Icon(Icons.save, color: CupertinoColors.systemBlue, size: 27)
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Title:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(width: 7),
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      maxLength: 80,
                      maxLines: 1,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(child: Text("Available:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Yes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      Checkbox(
                        value: yes,  // Value of the checkbox
                        onChanged: (bool? newValue) {
                          setState(() {
                            yes = newValue ?? false; // Update the state
                            if (yes) no = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("No", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      Checkbox(
                        value: no,  // Value of the checkbox
                        onChanged: (bool? newValue) {
                          setState(() {
                            no = newValue ?? false; // Update the state
                            if (no) yes = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Price:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(width: 7),
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      maxLength: 80,
                      maxLines: 1,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        border: InputBorder.none,
                        hintText: "Enter Price",
                        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Url:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(width: 7),
                  Expanded(
                    child: TextField(
                      controller: _imgController,
                      maxLength: 300,
                      maxLines: 1,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        border: InputBorder.none,
                        hintText: "Enter Product Image Url",
                        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(child: Text("Description:", style: TextStyle(color: Colors.purpleAccent, fontSize: 20, fontWeight: FontWeight.w500),)),
              SizedBox(width: 7),
              TextField(
                controller: _descriptionController,
                maxLength: 1500,
                maxLines: 25,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: InputBorder.none,
                  hintText: "Write here",
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
