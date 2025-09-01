import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_platform/core/common/widgets/default_button_widget.dart';
import 'package:social_network_platform/features/auth/presentation/bloc/user_event.dart';
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
  File? _avatarFile;
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserBloc>().state.user;
    _nameCtrl.text = user?.name.trim() ?? '';
    _bioCtrl.text = user?.bio?.trim() ?? '';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _avatarFile = File(pickedImage.path);
      });
    }
  }

  void _onSave() {
    context.read<UserBloc>().add(
      EditUserEvent(
        name: _nameCtrl.text.trim(),
        bio: _bioCtrl.text.trim(),
        avatar: _avatarFile,
      ),
    );
  }

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
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
          }

          if (state.status == UserStatus.success) {
            context.pop();
          }
        },

        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: _pickImage,
                      child: _avatarFile != null
                          ? ClipOval(
                              child: Image.file(
                                _avatarFile!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CircleUserAvatarWidget(
                              width: 100,
                              height: 100,
                              url: state.user?.avatar ?? '',
                            ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextFieldWidget(
                    hintText: 'Enter your name',
                    controller: _nameCtrl,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextFieldWidget(
                    hintText: 'Bio',
                    controller: _bioCtrl,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 6,
                    maxLenght: 255, // assuming this is your custom prop
                  ),
                  const SizedBox(height: 50),
                  DefaultButtonWidget(text: 'Save', onPressed: _onSave),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
