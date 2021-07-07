import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/screens/products/widgets/gradient_icon.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';

class UploadProductPage extends StatefulWidget {
  UploadProductPage({Key? key}) : super(key: key);

  @override
  _UploadProductPageState createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productBrand = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String _categoryValue = '';
  String _brandValue = '';
  File? _pickedImage;
  bool isDark = ThemeService().isSavedDarkMode();

  showAlertDialog(BuildContext context, String title, String body) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(title), content: Text(body), actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            )
          ]);
        });
  }

  void _doSubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      print(_productTitle);
      print(_productPrice);
      print(_productCategory);
      print(_productBrand);
      print(_productDescription);
      print(_productQuantity);
    }
  }

  void _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickerImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 40);
    final pickerImageFile = File(pickerImage!.path);
    setState(() {
      _pickedImage = pickerImageFile;
    });
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickerImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    final pickerImageFile = pickerImage == null ? null : File(pickerImage.path);
    setState(() {
      _pickedImage = pickerImageFile;
    });
  }

  void removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight * 0.8,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _doSubmit,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    'Upload',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                GradientIcon(
                  icon: Feather.upload,
                  size: 20,
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellow.shade800
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Card(
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  key: ValueKey('Title'),
                                  validator: (value) {
                                    if ('$value'.isEmpty) {
                                      return 'Please enter a Title';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Product Title',
                                  ),
                                  onSaved: (value) {
                                    _productTitle = '$value';
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                key: ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if ('$value'.isEmpty) {
                                    return 'Price is missed';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Price \$',
                                ),
                                onSaved: (value) {
                                  _productPrice = '$value';
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        //*******Image picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: this._pickedImage == null
                                  ? Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(4),
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        child: Image.file(
                                          this._pickedImage!,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FittedBox(
                                  child: TextButton.icon(
                                    onPressed: _pickImageFromCamera,
                                    icon: Icon(Icons.camera,
                                        color: Colors.purpleAccent),
                                    label: Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.white
                                            : AppColor.subTitle,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton.icon(
                                    onPressed: _pickImageFromGallery,
                                    icon: Icon(Icons.image,
                                        color: Colors.purpleAccent),
                                    label: Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.white
                                            : AppColor.subTitle,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton.icon(
                                    onPressed: removeImage,
                                    icon: Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    label: Text(
                                      'Remove',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    key: ValueKey('Category'),
                                    controller: _categoryController,
                                    validator: (value) {
                                      if ('$value'.isEmpty) {
                                        return 'Please enter a Category';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Add a new Category',
                                    ),
                                    onSaved: (value) {
                                      _productCategory = '$value';
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                    child: Text('Phones'), value: 'Phones'),
                                DropdownMenuItem<String>(
                                    child: Text('Clothes'), value: 'Clothes'),
                                DropdownMenuItem<String>(
                                    child: Text('Beauty & Health'),
                                    value: 'Beauty & Health'),
                                DropdownMenuItem<String>(
                                    child: Text('Shoes'), value: 'Shoes'),
                                DropdownMenuItem<String>(
                                    child: Text('Funiture'), value: 'Funiture'),
                                DropdownMenuItem<String>(
                                    child: Text('Watches'), value: 'Watches'),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _categoryValue = '$value';
                                  _categoryController.text = '$value';
                                  print(_productCategory);
                                });
                              },
                              hint: Text('Select a Category'),
                              value: _categoryValue.isEmpty
                                  ? null
                                  : _categoryValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    key: ValueKey('Brand'),
                                    controller: _brandController,
                                    validator: (value) {
                                      if ('$value'.isEmpty) {
                                        return 'Please enter a Brand';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Add a new Brand',
                                    ),
                                    onSaved: (value) {
                                      _productBrand = '$value';
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Brandless'),
                                  value: 'Brandless',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Addidas'),
                                  value: 'Addidas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Apple'),
                                  value: 'Apple',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Dell'),
                                  value: 'Dell',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('H&M'),
                                  value: 'H&M',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Nike'),
                                  value: 'Nike',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Samsung'),
                                  value: 'Samsung',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Huawei'),
                                  value: 'Huawei',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _brandValue = '$value';
                                  _brandController.text = '$value';
                                  print(_productBrand);
                                });
                              },
                              hint: Text('Select a Brand'),
                              value: _brandValue.isEmpty ? null : _brandValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          key: ValueKey('Description'),
                          validator: (value) {
                            if ('$value'.isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Product Description',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _productDescription = '$value';
                          },
                          onChanged: (text) {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 9, bottom: 20),
                                child: TextFormField(
                                  key: ValueKey('Quantity'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if ('$value'.isEmpty) {
                                      return 'Quantity is missed';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                  onSaved: (value) {
                                    _productQuantity = '$value';
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
