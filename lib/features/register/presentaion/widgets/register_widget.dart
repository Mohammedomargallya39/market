import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/choose_between_two_opttions.dart';
import '../../../../core/util/widgets/my_button.dart';
import '../../../../core/util/widgets/my_form.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({Key? key}) : super(key: key);


  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {
        if(state is UserRegisterSuccess){
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: 'Register Success');
        }
      },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveValue(
                context,
                12.0,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                          onPressed: ()
                          {
                            myBottomSheet(
                              context: context,
                              widget: ChooseYourOption(
                                titleFirstOption: Icons.abc_sharp,
                                fullTitleFirstOption: appTranslation(context).english,
                                secondTitleOption: Icons.language_outlined,
                                fullSecondTitleOption: appTranslation(context).arabic,
                                onTapFirstOption: ()
                                {
                                  if (AppCubit.get(context).isRtl == false) {
                                    Navigator.pop(context);
                                  }
                                  if (AppCubit.get(context).isRtl == true) {
                                    AppCubit.get(context).changeLanguage(value: false);
                                    Navigator.pop(context);
                                  }

                                },
                                onTapSecondOption: ()
                                {
                                  if (AppCubit.get(context).isRtl == true) {
                                    Navigator.pop(context);
                                  }
                                  if (AppCubit.get(context).isRtl == false) {
                                    AppCubit.get(context).changeLanguage(value: true);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.language_outlined,)
                      ),
                      Center(
                        child: Text(
                          appTranslation(context).createUserAccount,
                          style:
                          Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          space20Vertical(context),

                          InkWell(
                            child: Container(
                              child:  AppCubit.get(context).galleryImage != null ?
                              Center(
                                child: Container(
                                  width: responsiveValue(context, 300.0),
                                  height: responsiveValue(context, 250.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          AppCubit.get(context).galleryImage!,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        responsiveValue(context, 20),
                                      )
                                  ),
                                ),
                              ) :
                              Center(
                                child: Container(
                                  width: responsiveValue(context, 300.0),
                                  height: responsiveValue(context, 250.0),
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/upload.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      responsiveValue(context, 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: ()
                            {
                              AppCubit.get(context).selectImage();
                            },
                          ),



                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).fullName,
                              controller: nameController,
                              type: TextInputType.name,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).fullName}',
                              isPassword: false
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).emailAddress,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).emailAddress}',
                              isPassword: false
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).phone,
                              controller: phoneController,
                              type: TextInputType.phone,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).phone}',
                              isPassword: false
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).password,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).password}',
                              isPassword: true
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).confirmPassword,
                              controller: confirmPasswordController,
                              type: TextInputType.visiblePassword,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).confirmPassword}  ${appTranslation(context).right}',
                              isPassword: true
                          ),
                          space40Vertical(context),
                          MyButton(
                            onPressed: ()
                            {
                             if(AppCubit.get(context).galleryImage != null)
                             {
                               if (formKey.currentState!.validate() && passwordController.text == confirmPasswordController.text)
                               {
                                 debugPrint("Form is valid");
                                 AppCubit.get(context).userRegister(
                                   image: AppCubit.get(context).galleryImage!,
                                   name: nameController.text,
                                   email: emailController.text,
                                   password: passwordController.text,
                                   mobile: phoneController.text,
                                 );
                               }
                               else
                               {
                                 debugPrint("Form is invalid");
                                 //debugPrint("${AppCubit.get(context).selectGovernment}");
                               }
                             } else {
                               Fluttertoast.showToast(msg: 'Please select an image');
                             }
                            },
                            text: appTranslation(context).newAccount,
                          ),
                          space20Vertical(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        );
  }
}
