import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../servieces/api_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class EditProduct extends StatefulWidget {
  EditProduct({super.key, required this.details});

  Map<String, dynamic> details;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _quantityController = TextEditingController();

  String? nameError;
  String? priceError;
  String? descriptionError;
  String? imageError;
  String? quantityError;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  bool loading = false;

  void _getFromCamera() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
        setState(() {
          
        });
  }

  void _getFromgallary() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
        setState(() {
          
        });
  }

  @override
  void initState() {
    _nameController.text = widget.details['product_name'];
    _descriptionController.text = widget.details['description'];
    _quantityController.text = widget.details['quantity'];
    _priceController.text = widget.details['price'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
        title: Text('Edit Product',
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
      body: SingleChildScrollView(
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5.0)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 70,
                          child: Text(
                            'Edit your product',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Container(
                          height: 200,
                          child: image != null
                              ? Image(image: FileImage(File(image!.path)))
                              : Image(
                                  image: NetworkImage(
                                    widget.details['image'][0],
                                  ),
                                ),
                        ),

                        CustomButton(
                          text: 'Change',
                          onPressed: () async {



                              showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                50)),
                                                    onPressed: () {
                                                      _getFromCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons
                                                            .camera_alt_outlined),
                                                        Text("Take a photo")
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                50)),
                                                    onPressed: () {
                                                      _getFromgallary();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(CupertinoIcons
                                                            .photo_on_rectangle),
                                                        Text(
                                                            "Upload from gallary")
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );






                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: CustomTextField(
                            controller: _nameController,
                            hintText: 'Enter product name',
                            labelText: 'Product name',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: CustomTextField(
                            controller: _priceController,
                            hintText: 'Enter price',
                            labelText: 'Price',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: CustomTextField(
                            controller: _descriptionController,
                            hintText: 'Enter product description',
                            labelText: 'Description',
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: CustomTextField(
                            controller: _quantityController,
                            hintText: 'Quantity',
                            labelText: 'Product quantity',
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          width: 360,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade700),
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    loading = false;
                                  });

                                  await ApiService().updateProduct(context,
                                      productId: widget.details['_id'],
                                      productName: _nameController.text,
                                      price:
                                          double.parse(_priceController.text),
                                      description: _descriptionController.text,
                                      quantity:
                                          int.parse(_quantityController.text));
                                  setState(() {
                                    loading = false;
                                  });

                                   Navigator.pop(context, true);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _editProductHandler(BuildContext context) {
    setState(() {
      if (_nameController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _imageController.text.isNotEmpty &&
          _quantityController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All fields are required')));
        setState(() {});
      }
    });
  }
}
