import 'package:bingwa/contact.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

TextEditingController nameController = TextEditingController();
TextEditingController contactController = TextEditingController();
List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Context List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextField(
            controller: nameController,
              decoration: const InputDecoration(
                hintText: "contact name",
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),

           const SizedBox(height: 10,),

           TextField(
            controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                hintText: "contact number",
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
           const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  //
                  String name = nameController.text.trim();
                  String contact = contactController.text.trim();
                  if(name.isNotEmpty && contact.isNotEmpty){
                    setState(() {
                      nameController.text = "";
                      contactController.text = "";
                       contacts.add(Contact(name: name, contact: contact));
                    });
                  }
                },
                 child: const Text("save"),
                 ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    String name = nameController.text.trim();
                  String contact = contactController.text.trim();
                   if(name.isNotEmpty && contact.isNotEmpty){
                    contacts.add(Contact(name: name, contact: contact));
                    setState(() {
                      nameController.text = "";
                      contactController.text = "";
                      contacts[selectedIndex].name = name;
                      contacts[selectedIndex].contact = contact;
                      selectedIndex = -1;
                    });
                  }
                  });
                },
                 child: const Text("update"),
                 ),
              ],
            ),
            const SizedBox(height: 10,),
            contacts.isEmpty ? const Text("no content yet..",
            style: TextStyle(fontSize: 22),
            ):
            Expanded(
              child: ListView.builder(
                itemCount:contacts.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading:  CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.deepPurpleAccent: Colors.purple,
          foregroundColor: Colors.white,
          child: Text(contacts[index].name[0],
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].name,style: TextStyle(fontWeight: FontWeight.bold),),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  nameController.text = contacts[index].name;
                  contactController.text = contacts[index].contact;
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: const Icon(Icons.edit)),
              InkWell(
                onTap: ((){
                  setState(() {
                    contacts.removeAt(index);
                  });
                }),
                child: const Icon(Icons.delete),),
            ],
          ),
        ),
      ),
    );
  }
}