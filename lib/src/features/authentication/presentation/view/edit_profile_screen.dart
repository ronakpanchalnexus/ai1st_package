import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/fonts.dart';
import 'package:ai1st_package/core/constants/media_res.dart';
import 'package:ai1st_package/src/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_button.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_text_field.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _kFirstNameController = TextEditingController();
  final TextEditingController _kLastNameController = TextEditingController();
  String? _kFirstNameError;
  String? _kLastNameError;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<CoursesBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.getColor(context).bgColor,
          title: AI1stTextView(
            text: 'Edit Profile',
            fontFamily: Fonts.futuraNowHeadlineBold,
          ),
          centerTitle: false,
        ),
        backgroundColor: AppColors.getColor(context).bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(MediaRes.icUserPlaceHolder),
                    radius: 50,
                  ),
                ),
                SizedBox(height: 40.0),
                AI1stTextView(
                  text: 'First name',
                  fontFamily: Fonts.futuraNowHeadlineMedium,
                ),
                SizedBox(
                  height: 5.0,
                ),
                AI1stTextField(
                  controller: _kFirstNameController,
                  errorText: _kFirstNameError,
                  textInputAction: TextInputAction.next,
                  hint: 'Enter your first name',
                  inputType: TextInputType.name,
                  isOutlined: true,
                ),
                SizedBox(height: 30.0),
                AI1stTextView(
                  text: 'Last name',
                  fontFamily: Fonts.futuraNowHeadlineMedium,
                ),
                SizedBox(
                  height: 5.0,
                ),
                AI1stTextField(
                  controller: _kLastNameController,
                  errorText: _kLastNameError,
                  textInputAction: TextInputAction.done,
                  hint: 'Please enter last name',
                  inputType: TextInputType.name,
                  isOutlined: true,
                ),
                SizedBox(height: 40.0),
                AI1stButton(
                  text: 'Change password',
                  onTap: () {},
                ),
                SizedBox(height: 40.0),
                AI1stButton(
                  text: 'Change password',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
