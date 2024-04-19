
import 'package:flutter/material.dart';

import '../../../servieces/api_service.dart';
import '../../../widgets/custom_text_field.dart';

class EditStudentsProfile extends StatefulWidget {
  


  final String  name;
  final String email;
  final String mobile;
  final String address;
  final String id;
  final String stream;
  final String accadamicYear;
  final String courseName;
 






   const EditStudentsProfile({super.key,required this.id , required this.name, required this.email, required this.mobile, required this.address, required this.stream, required this.accadamicYear, required this.courseName});

  @override
  State<EditStudentsProfile> createState() => _EditStudentsProfileState();
}

class _EditStudentsProfileState extends State<EditStudentsProfile> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _mobileController = TextEditingController();

  final _addressController = TextEditingController();

  final _stramControlller = TextEditingController();

  final _courseNameController = TextEditingController();

  final _accadmicYeae = TextEditingController();


  bool loading = false;


  @override
  void initState() {
    _addressController.text = widget.address;
    _emailController.text = widget.email;
    _mobileController.text = widget.mobile;
    _nameController.text =  widget.name;
    _accadmicYeae.text = widget.accadamicYear;
    _courseNameController.text = widget.courseName;

  
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
        title: const Text('Edit Profile',
            style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold')),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                isDark ? Icons.notifications : Icons.notifications,
                color: Colors.white,
              ))
        ],
      ),
      body:loading? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('assets/images/slider1.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey),
                      child: const Icon(Icons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: CustomTextField(
                      controller: _nameController,
                      hintText: 'Enter name',
                      labelText: 'Name',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: 'Enter email',
                      labelText: 'Email',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: CustomTextField(
                      controller: _mobileController,
                      hintText: 'Enter mobile number',
                      labelText: 'Mobile number',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: CustomTextField(
                      controller: _addressController,
                      hintText: 'Enter your address',
                      labelText: 'Address',
                    ),
                  ),


                  Padding(
                    padding: const  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: CustomTextField(
                      controller: _courseNameController,
                      hintText: 'Enter your course name',
                      labelText: 'course Name',
                    ),
                  ),
                  
                    const SizedBox(height: 50),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading =  true;
                          });

                          await ApiService().updateProfile(
                            context: context, 
                            id: widget.id, 
                            name:  _nameController.text,
                            mobile: _mobileController.text,
                            academicYear: _accadmicYeae.text ,
                            courseName:  _courseNameController.text,
                            stream: _stramControlller.text,
                            address : _addressController.text
                            );

                             Navigator.pop(context,true);
                          
                          
                          
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Update Profile', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // -- Created Date and Delete Button
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                     
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.redAccent.withOpacity(0.1),
                    //           elevation: 0,
                    //           foregroundColor: Colors.red,
                    //           shape: const StadiumBorder(),
                    //           side: BorderSide.none),
                    //       child: const Text('Delete'),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}