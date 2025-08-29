import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_platform/core/common/widgets/default_button_widget.dart';
import '../../../../core/common/widgets/default_text_field_widget.dart';
import '../../../auth/presentation/bloc/user_bloc.dart';
import '../../../auth/presentation/bloc/user_state.dart';
import '../widgets/circle_user_avatar_widget.dart';

class EditProfilePage extends StatefulWidget {
  static const String route = '/edit_profile';

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _avaterFile;
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        final pickedImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );

                        if (pickedImage != null) {
                          setState(() {
                            _avaterFile = File(pickedImage.path);
                          });
                        }
                      },

                      child: _avaterFile != null
                          ? ClipOval(
                              child: Image.file(
                                _avaterFile!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CircleUserAvatarWidget(
                              width: 100,
                              height: 100,
                              url: '${state.user?.avatar}',
                            ),
                    ),
                  ),

                  SizedBox(height: 28),

                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 10),

                  DefaultTextFieldWidget(
                    hintText: 'Enter your name',
                    controller: _nameCtrl,
                    keyboardType: TextInputType.name,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 10),

                  DefaultTextFieldWidget(
                    hintText: 'Bio',
                    controller: _bioCtrl,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 6,
                    maxLenght: 255,
                  ),

                  Spacer(),

                  DefaultButtonWidget(text: 'Save', onPressed: () {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
