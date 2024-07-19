import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/consts/colors.dart';
import 'package:flutter_shop_app/services/global_methods.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';

  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phonenumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  final String _fullName = '';
  late int _phoneNumber;
  File? _pickedImage;
  late String url;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods globalMethods = GlobalMethods();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phonenumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = '${dateparse.day}-${dateparse.month}-${dateparse.year}';
    if (isValid) {
      // setState(() {
      //   _isLoading = true;
      // });
      _formKey.currentState!.save();
      // Add your login logic here
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim());
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        if (_pickedImage == null) {
          globalMethods.authErrorhandle('Please pick an image', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('userimages')
              .child(_fullName + '.jpg');
          await ref.putFile(_pickedImage!);
          url = ref.getDownloadURL().toString();
        }
        user.updateProfile(displayName: _fullName, photoURL: url);
        user.reload();
        await FirebaseFirestore.instance.collection('users').doc('id').set({
          'id': _uid,
          'name': _fullName,
          'email': _emailAddress,
          'PhoneNumber': _phoneNumber,
          'imageUrl': url,
          'joinedAt': formattedDate,
          'created': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        globalMethods.authErrorhandle('$error', context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
      Navigator.pop(context);
    }
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
      Navigator.pop(context);
    }
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            // child: RotatedBox(
            //   quarterTurns: 2,
            //   child: WaveWidget(
            //     config: CustomConfig(
            //       gradients: [
            //         [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
            //         [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
            //       ],
            //       durations: [19440, 10800],
            //       heightPercentages: [0.20, 0.25],
            //       blur: const MaskFilter.blur(BlurStyle.solid, 10),
            //       gradientBegin: Alignment.bottomLeft,
            //       gradientEnd: Alignment.topRight,
            //     ),
            //     size: const Size(double.infinity, double.infinity),
            //   ),
            // ),
          ),
          Stack(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: CircleAvatar(
                  radius: 71,
                  backgroundColor: ColorsConsts.gradiendLEnd,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage:
                        _pickedImage == null ? null : FileImage(_pickedImage!),
                  ),
                ),
              ),
              Positioned(
                  top: 120,
                  left: 120,
                  child: RawMaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Choose Options',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorsConsts.gradiendLStart),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    InkWell(
                                      onTap: _pickImageCamera,
                                      splashColor: Colors.purpleAccent,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.camera,
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                          Text(
                                            'Camera',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsConsts.title),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _remove,
                                      splashColor: Colors.purpleAccent,
                                      child: const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                          Text(
                                            'Remove',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _pickImageGallery,
                                      splashColor: Colors.purpleAccent,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.browse_gallery,
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                          Text(
                                            'Gallery',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsConsts.title),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    elevation: 10,
                    fillColor: ColorsConsts.gradiendLStart,
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add_a_photo),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          key: const ValueKey('name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name cannot be null';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: const Icon(Icons.person),
                            labelText: 'fullName',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          key: const ValueKey('email'),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: const Icon(Icons.email),
                            labelText: 'Email Address',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          key: const ValueKey('PhoneNumber'),
                          focusNode: _phonenumberFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid PhoneNumber';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phonenumberFocusNode),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: const Icon(Icons.phone),
                            labelText: 'PhoneNumber',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          key: const ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            labelText: 'Password',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: _obscureText,
                          onEditingComplete: _submitForm,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('SignUp'),
                            ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Icon(Icons.help_outline),
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
    );
  }
}
