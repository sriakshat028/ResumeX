import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumex/database/database.dart';

import '../../models/models.dart';
import '/providers/providers.dart';
import '/widgets/widgets.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);
  static const routeName = '/forms/contact-form';

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final db = Database();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();
  final countryController = TextEditingController();

  String? name;
  String? email;
  String? phoneNumber;
  String? city;
  String? province;
  String? country;

  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();

    nameController.text =
        name ?? (resume.contact != null ? resume.contact!.name : '');
    emailController.text =
        email ?? (resume.contact != null ? resume.contact!.email : '');
    phoneNumberController.text = phoneNumber ??
        (resume.contact != null ? resume.contact!.phoneNumber : '');
    cityController.text =
        city ?? (resume.contact != null ? resume.contact!.city! : '');
    provinceController.text =
        province ?? (resume.contact != null ? resume.contact!.province! : '');
    countryController.text =
        country ?? (resume.contact != null ? resume.contact!.country! : '');

    return Scaffold(
      appBar: AppBar(
        elevation: 05,
        backgroundColor: Colors.white,
        title: const HeadingText(
          color: Colors.black,
          text: 'Add your contact information',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 12,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(58, 189, 181, 181),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    InputBox(
                      controller: nameController,
                      hintText: 'John Doe',
                      infoText: 'Name',
                      inputType: TextInputType.name,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    InputBox(
                      controller: emailController,
                      hintText: 'johndoe@email.com',
                      infoText: 'E-mail',
                      inputType: TextInputType.emailAddress,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    InputBox(
                      controller: phoneNumberController,
                      hintText: '+91 9876543210',
                      infoText: 'Phone Number',
                      inputType: TextInputType.number,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                    InputBox(
                      controller: cityController,
                      hintText: 'Bengaluru',
                      infoText: 'City (Optional)',
                      inputType: TextInputType.name,
                      onChanged: (value) {
                        city = value;
                      },
                    ),
                    InputBox(
                      controller: provinceController,
                      hintText: 'Karnataka',
                      infoText: 'Province / State (Optional)',
                      inputType: TextInputType.name,
                      onChanged: (value) {
                        province = value;
                      },
                    ),
                    InputBox(
                      controller: countryController,
                      hintText: 'India',
                      infoText: 'Country (Optional)',
                      inputType: TextInputType.name,
                      onChanged: (value) {
                        country = value;
                      },
                    ),
                  ],
                ),
              ),
              SaveButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    snackbar(context, 'Saving...');
                    resumeModel.addContact(
                      '0',
                      Contact(
                        name: nameController.text,
                        email: emailController.text,
                        phoneNumber: phoneNumberController.text,
                        city: cityController.text,
                        province: provinceController.text,
                        country: countryController.text,
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 250)).then(
                      (_) {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
