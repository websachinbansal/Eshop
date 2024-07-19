import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../consts/colors.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadProductForm({super.key});

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productBrand = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String? _categoryValue;
  String? _brandValue;
  File? _pickedImage;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // Use those values to send our auth request ...
      print(_productTitle);
      print(_productPrice);
      print(_productCategory);
      print(_productBrand);
      print(_productDescription);
      print(_productQuantity);
    }
  }

  Future<void> _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }
  }

  Future<void> _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  void showAlertDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsConsts.white,
          border: const Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Text('Upload',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
                GradientIcon(
                  Icons.upload,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellow.withOpacity(1)
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
          children: [
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
                          children: [
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  key: const ValueKey('Title'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Title';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Title',
                                  ),
                                  onSaved: (value) {
                                    _productTitle = value!;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                key: const ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Price is missed';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Price \$',
                                ),
                                onSaved: (value) {
                                  _productPrice = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: _pickedImage == null
                                  ? Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(4),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                      child: Image.file(
                                        _pickedImage!,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                    onPressed: _pickImageCamera,
                                    icon: const Icon(Icons.camera,
                                        color: Colors.purpleAccent),
                                    label: const Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                    onPressed: _pickImageGallery,
                                    icon: const Icon(Icons.image,
                                        color: Colors.purpleAccent),
                                    label: const Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.redAccent,
                                    ),
                                    onPressed: _removeImage,
                                    icon: const Icon(
                                      Icons.remove_circle_rounded,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      'Remove',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  controller: _categoryController,
                                  key: const ValueKey('Category'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Category';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Add a new Category',
                                  ),
                                  onSaved: (value) {
                                    _productCategory = value!;
                                  },
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Phones',
                                  child: Text('Phones'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Clothes',
                                  child: Text('Clothes'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Beauty',
                                  child: Text('Beauty & health'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Shoes',
                                  child: Text('Shoes'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Furniture',
                                  child: Text('Furniture'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Watches',
                                  child: Text('Watches'),
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _categoryValue = value;
                                  _categoryController.text = value!;
                                });
                              },
                              hint: const Text('Select a Category'),
                              value: _categoryValue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  controller: _brandController,
                                  key: const ValueKey('Brand'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Brand is missed';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Brand',
                                  ),
                                  onSaved: (value) {
                                    _productBrand = value!;
                                  },
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Brandless',
                                  child: Text('Brandless'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Addidas',
                                  child: Text('Addidas'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Apple',
                                  child: Text('Apple'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Dell',
                                  child: Text('Dell'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'H&M',
                                  child: Text('H&M'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Nike',
                                  child: Text('Nike'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Samsung',
                                  child: Text('Samsung'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Huawei',
                                  child: Text('Huawei'),
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _brandValue = value;
                                  _brandController.text = value!;
                                });
                              },
                              hint: const Text('Select a Brand'),
                              value: _brandValue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          key: const ValueKey('Description'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Product description is required';
                            }
                            return null;
                          },
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Product description',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _productDescription = value!;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          key: const ValueKey('Quantity'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Quantity is missed';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                          ),
                          onSaved: (value) {
                            _productQuantity = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon,
    this.size,
    this.gradient, {super.key}
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
