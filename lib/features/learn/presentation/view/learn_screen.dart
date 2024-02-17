import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/core/Cubit/app_states.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/chat_custom_app_bar.dart';
import 'package:unheard_voices/features/learn/presentation/view/widgets/category_data_screen.dart';


class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state)
          {
            return Scaffold(
              body: Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: AppCubit.get(context).categories.length,
                  itemBuilder: (context, index)
                  {
                    return Column(
                      children:
                      [
                        if(index == 0)
                          const ChatCustomAppBar(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1,
                                color: purpleBlueColor,
                              ),
                            ),
                            child: Row(
                              children:
                              [
                                Container(
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border:const BorderDirectional(
                                      end: BorderSide(
                                        width: 1,
                                        color: purpleBlueColor,
                                      ),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image(
                                      height: 80,
                                      width: 120,
                                      fit: BoxFit.fill,
                                      image: AssetImage(AppCubit.get(context).categories[index].imageUrl),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    AppCubit.get(context).categories[index].categoriesName,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: ()
                                  {
                                    // Navigate to the new screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  CategoryDataScreen(categoryIndex: index),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    size: 40,
                                    color: purpleBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
      ),
    );
  }
}
