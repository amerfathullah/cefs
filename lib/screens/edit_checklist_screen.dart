import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/checklists.dart';
import '../providers/checklist.dart';
import 'user_checklists_screen.dart';

class EditChecklistScreen extends StatefulWidget {
  static const routeName = '/edit-checklist';
  @override
  _EditChecklistScreenState createState() => _EditChecklistScreenState();
}

class _EditChecklistScreenState extends State<EditChecklistScreen> {
  // final _priceFocusNode = FocusNode();
  // final _descriptionFocusNode = FocusNode();
  // final _imageUrlController = TextEditingController();
  // final _imageUrlFocusedNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedChecklist = Checklist(
    id: null,
    foamTender: '',
    regNo: '',
    dateTime: null,
    shiftDay: null,
    shiftNight: null,
    foamCapacity: 0.0,
    waterCapacity: 0.0,
    c1e1day: 0,
    c1e1night: 0,
    c1e2day: 0,
    c1e2night: 0,
    c1e3day: 0,
    c1e3night: 0,
    c1e4day: 0,
    c1e4night: 0,
    c2e1day: 0,
    c2e1night: 0,
    c2e2day: 0,
    c2e2night: 0,
    inspectNameDay: '',
    // inspectSignDay: '',
    inspectNameNight: '',
    // inspectSignNight: '',
    watchNameDay: '',
    // watchSignDay: '',
    watchNameNight: '',
    // watchSignNight: '',
  );
  var _initValues = {
    'foamTender': '',
    'regNo': '',
    'shiftDay': null,
    'shiftNight': null,
    'foamCapacity': '',
    'waterCapacity': '',
    'c1e1day': '',
    'c1e1night': '',
    'c1e2day': '',
    'c1e2night': '',
    'c1e3day': '',
    'c1e3night': '',
    'c1e4day': '',
    'c1e4night': '',
    'c2e1day': '',
    'c2e1night': '',
    'c2e2day': '',
    'c2e2night': '',
    'inspectNameDay': '',
    // inspectSignDay: '',
    'inspectNameNight': '',
    // inspectSignNight: '',
    'watchNameDay': '',
    // watchSignDay: '',
    'watchNameNight': '',
    // watchSignNight: '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // _imageUrlFocusedNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final checklistId = ModalRoute.of(context).settings.arguments as String;
      // print(checklistId);
      if (checklistId != null) {
        _editedChecklist = Provider.of<Checklists>(context, listen: false)
            .findById(checklistId);
        _initValues = {
          'foamTender': _editedChecklist.foamTender,
          'regNo': _editedChecklist.regNo,
          'shiftDay': _editedChecklist.shiftDay.toString(),
          'shiftNight': _editedChecklist.shiftNight.toString(),
          'foamCapacity': _editedChecklist.foamCapacity.toString(),
          'waterCapacity': _editedChecklist.waterCapacity.toString(),
          'c1e1day': _editedChecklist.c1e1day.toString(),
          'c1e1night': _editedChecklist.c1e1night.toString(),
          'c1e2day': _editedChecklist.c1e2day.toString(),
          'c1e2night': _editedChecklist.c1e2night.toString(),
          'c1e3day': _editedChecklist.c1e3day.toString(),
          'c1e3night': _editedChecklist.c1e3night.toString(),
          'c1e4day': _editedChecklist.c1e4day.toString(),
          'c1e4night': _editedChecklist.c1e4night.toString(),
          'c2e1day': _editedChecklist.c2e1day.toString(),
          'c2e1night': _editedChecklist.c2e1night.toString(),
          'c2e2day': _editedChecklist.c2e2day.toString(),
          'c2e2night': _editedChecklist.c2e2night.toString(),
          'inspectNameDay': _editedChecklist.inspectNameDay,
          // inspectSignDay: '',
          'inspectNameNight': _editedChecklist.inspectNameNight,
          // inspectSignNight: '',
          'watchNameDay': _editedChecklist.watchNameDay,
          // watchSignDay: '',
          'watchNameNight': _editedChecklist.watchNameNight,
          // watchSignNight: '',
        };
        // _imageUrlController.text = _editedChecklist.imageUrl;
        print(_editedChecklist.id);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _imageUrlFocusedNode.removeListener(_updateImageUrl);
    // _priceFocusNode.dispose();
    // _descriptionFocusNode.dispose();
    // _imageUrlController.dispose();
    // _imageUrlFocusedNode.dispose();
    super.dispose();
  }

  // void _updateImageUrl() {
  //   if (!_imageUrlFocusedNode.hasFocus) {
  //     if ((!_imageUrlController.text.startsWith('http') &&
  //             !_imageUrlController.text.startsWith('https')) ||
  //         (!_imageUrlController.text.endsWith('.png') &&
  //             !_imageUrlController.text.endsWith('.jpg') &&
  //             !_imageUrlController.text.endsWith('.jpeg'))) {
  //       return;
  //     }
  //     setState(() {});
  //   }
  // }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_editedChecklist.id);
    // print('_idFromRoute ' + _idFromRoute);
    if (_editedChecklist.id != null) {
      await Provider.of<Checklists>(context, listen: false)
          .updateChecklist(_editedChecklist.id, _editedChecklist);
    } else {
      try {
        await Provider.of<Checklists>(context, listen: false)
            .addChecklist(_editedChecklist);
      } catch (e) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured!'),
            content: Text('Something went wrong.'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(UserChecklistsScreen.routeName);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Checklist'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues['foamTender'],
                        decoration:
                            InputDecoration(labelText: 'Foam Tender (FT)'),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: value,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['regNo'],
                        decoration:
                            InputDecoration(labelText: 'Registration No.'),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: value,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3, color: Colors.black),
                      Row(
                        children: [
                          Text(
                            'TIME: 0800-2000 SHIFT:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<ShiftDay>(
                            // title: const Text('A'),
                            value: ShiftDay.A,
                            groupValue: _editedChecklist.shiftDay,
                            onChanged: (ShiftDay value) {
                              setState(() {
                                _editedChecklist.shiftDay = value;
                              });
                            },
                          ),
                          Text('A'),
                          Radio<ShiftDay>(
                            // title: const Text('B'),
                            value: ShiftDay.B,
                            groupValue: _editedChecklist.shiftDay,
                            onChanged: (ShiftDay value) {
                              setState(() {
                                _editedChecklist.shiftDay = value;
                              });
                            },
                          ),
                          Text('B'),
                          Radio<ShiftDay>(
                            // title: const Text('C'),
                            value: ShiftDay.C,
                            groupValue: _editedChecklist.shiftDay,
                            onChanged: (ShiftDay value) {
                              setState(() {
                                _editedChecklist.shiftDay = value;
                              });
                            },
                          ),
                          Text('C'),
                          Radio<ShiftDay>(
                            // title: const Text('D'),
                            value: ShiftDay.D,
                            groupValue: _editedChecklist.shiftDay,
                            onChanged: (ShiftDay value) {
                              setState(() {
                                _editedChecklist.shiftDay = value;
                              });
                            },
                          ),
                          Text('D'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'TIME: 2000-0800 SHIFT:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<ShiftNight>(
                            // title: const Text('A'),
                            value: ShiftNight.A,
                            groupValue: _editedChecklist.shiftNight,
                            onChanged: (ShiftNight value) {
                              setState(() {
                                _editedChecklist.shiftNight = value;
                              });
                            },
                          ),
                          Text('A'),
                          Radio<ShiftNight>(
                            // title: const Text('B'),
                            value: ShiftNight.B,
                            groupValue: _editedChecklist.shiftNight,
                            onChanged: (ShiftNight value) {
                              setState(() {
                                _editedChecklist.shiftNight = value;
                              });
                            },
                          ),
                          Text('B'),
                          Radio<ShiftNight>(
                            // title: const Text('C'),
                            value: ShiftNight.C,
                            groupValue: _editedChecklist.shiftNight,
                            onChanged: (ShiftNight value) {
                              setState(() {
                                _editedChecklist.shiftNight = value;
                              });
                            },
                          ),
                          Text('C'),
                          Radio<ShiftNight>(
                            // title: const Text('D'),
                            value: ShiftNight.D,
                            groupValue: _editedChecklist.shiftNight,
                            onChanged: (ShiftNight value) {
                              setState(() {
                                _editedChecklist.shiftNight = value;
                              });
                            },
                          ),
                          Text('D'),
                        ],
                      ),
                      Divider(thickness: 3, color: Colors.black),
                      TextFormField(
                        initialValue: _initValues['foamCapacity'],
                        decoration: InputDecoration(labelText: 'Foam Capacity'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: double.parse(value),
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['waterCapacity'],
                        decoration:
                            InputDecoration(labelText: 'Water Capacity'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: double.parse(value),
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3, color: Colors.black),
                      Row(
                        children: [
                          Text(
                            'LIST OF EQUIPMENT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'CABINET 1',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('CO2 FIRE EXTINGUISHER'),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e1day'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: int.parse(value),
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e1night'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: int.parse(value),
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3),
                      Row(
                        children: [
                          Text('D/P EXTINGUISHER (PORTABLE)'),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e2day'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: int.parse(value),
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e2night'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: int.parse(value),
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3),
                      Row(
                        children: [
                          Text('WATER CURTAIN'),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e3day'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: int.parse(value),
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e3night'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: int.parse(value),
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3),
                      Row(
                        children: [
                          Text('BLITZ FIRE MONITOR'),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e4day'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: int.parse(value),
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['c1e4night'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: int.parse(value),
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'CABINET 2',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('ADAPTOR 5” SURE LOCK TO 4” SCREW'),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['c2e1day'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: int.parse(value),
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['c2e1night'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: int.parse(value),
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3),
                      Row(
                        children: [
                          Text('ADAPTOR FEMALE SCREW MALE SCREW'),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['c2e2day'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: int.parse(value),
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['c2e2night'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context)
                        //       .requestFocus(_descriptionFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a price.';
                        //   }
                        //   if (double.tryParse(value) == null) {
                        //     return 'Please enter a valid number.';
                        //   }
                        //   if (double.parse(value) <= 0) {
                        //     return 'Please enter a number greater than 0.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: int.parse(value),
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3, color: Colors.black),
                      Row(
                        children: [
                          Text(
                            'INSPECT BY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['inspectNameDay'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: value,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['inspectNameNight'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: value,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 3, color: Colors.black),
                      Row(
                        children: [
                          Text(
                            'WATCH COMMANDER',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['watchNameDay'],
                        decoration: InputDecoration(labelText: '0800-2000'),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: value,
                            // watchSignDay: '',
                            watchNameNight: _editedChecklist.watchNameNight,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['watchNameNight'],
                        decoration: InputDecoration(labelText: '2000-0800'),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          _editedChecklist = Checklist(
                            id: _editedChecklist.id,
                            foamTender: _editedChecklist.foamTender,
                            regNo: _editedChecklist.regNo,
                            shiftDay: _editedChecklist.shiftDay,
                            shiftNight: _editedChecklist.shiftNight,
                            foamCapacity: _editedChecklist.foamCapacity,
                            waterCapacity: _editedChecklist.waterCapacity,
                            c1e1day: _editedChecklist.c1e1day,
                            c1e1night: _editedChecklist.c1e1night,
                            c1e2day: _editedChecklist.c1e2day,
                            c1e2night: _editedChecklist.c1e2night,
                            c1e3day: _editedChecklist.c1e3day,
                            c1e3night: _editedChecklist.c1e3night,
                            c1e4day: _editedChecklist.c1e4day,
                            c1e4night: _editedChecklist.c1e4night,
                            c2e1day: _editedChecklist.c2e1day,
                            c2e1night: _editedChecklist.c2e1night,
                            c2e2day: _editedChecklist.c2e2day,
                            c2e2night: _editedChecklist.c2e2night,
                            inspectNameDay: _editedChecklist.inspectNameDay,
                            // inspectSignDay: '',
                            inspectNameNight: _editedChecklist.inspectNameNight,
                            // inspectSignNight: '',
                            watchNameDay: _editedChecklist.watchNameDay,
                            // watchSignDay: '',
                            watchNameNight: value,
                            // watchSignNight: '',
                          );
                        },
                      ),
                      // TextFormField(
                      //   initialValue: _initValues['description'],
                      //   decoration: InputDecoration(labelText: 'Description'),
                      //   maxLines: 3,
                      //   keyboardType: TextInputType.multiline,
                      //   focusNode: _descriptionFocusNode,
                      //   validator: (value) {
                      //     if (value.isEmpty) {
                      //       return 'Please enter a description.';
                      //     }
                      //     if (value.length < 10) {
                      //       return 'Should be at least 10 characters long.';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (value) {
                      //     _editedChecklist = Checklist(
                      //       foamTender: _editedChecklist.foamTender,
                      //       price: _editedChecklist.price,
                      //       description: value,
                      //       imageUrl: _editedChecklist.imageUrl,
                      //       id: _editedChecklist.id,
                      //       isFavorite: _editedChecklist.isFavorite,
                      //     );
                      //   },
                      // ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       width: 100,
                      //       height: 100,
                      //       margin: EdgeInsets.only(
                      //         top: 8,
                      //         right: 10,
                      //       ),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           width: 1,
                      //           color: Colors.grey,
                      //         ),
                      //       ),
                      //       child: _imageUrlController.text.isEmpty
                      //           ? Text('Enter a URL')
                      //           : FittedBox(
                      //               child: Image.network(
                      //                 _imageUrlController.text,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //             ),
                      //     ),
                      //     Expanded(
                      //       child: TextFormField(
                      //         decoration:
                      //             InputDecoration(labelText: 'Image URL'),
                      //         keyboardType: TextInputType.url,
                      //         textInputAction: TextInputAction.done,
                      //         controller: _imageUrlController,
                      //         focusNode: _imageUrlFocusedNode,
                      //         onFieldSubmitted: (_) {
                      //           _saveForm();
                      //         },
                      //         validator: (value) {
                      //           if (value.isEmpty) {
                      //             return 'Please enter an image URL.';
                      //           }
                      //           if (!value.startsWith('http') &&
                      //               !value.startsWith('https')) {
                      //             return 'Please enter a valid URL.';
                      //           }
                      //           if (!value.endsWith('.png') &&
                      //               !value.endsWith('.jpg') &&
                      //               !value.endsWith('.jpeg')) {
                      //             return 'Please enter a valid image URL.';
                      //           }
                      //           return null;
                      //         },
                      //         onEditingComplete: () {
                      //           setState(() {});
                      //         },
                      //         onSaved: (value) {
                      //           _editedChecklist = Checklist(
                      //             foamTender: _editedChecklist.foamTender,
                      //             price: _editedChecklist.price,
                      //             description: _editedChecklist.description,
                      //             imageUrl: value,
                      //             id: _editedChecklist.id,
                      //             isFavorite: _editedChecklist.isFavorite,
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
