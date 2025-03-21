import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pulse_app_mobile/common/components/custom_bottom_sheet.dart';
import 'package:pulse_app_mobile/common/components/custom_button.dart';
import 'package:pulse_app_mobile/common/components/custom_input_field.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/common/database/secure_storage_service.dart';
import 'package:pulse_app_mobile/feed/cubit/create_article_cubit.dart';
import 'package:toastification/toastification.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: 250, // Fixed height for the bottom sheet
        child: CustomBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ajouter des photos',
                style: TextStyle(
                  fontSize: FontSizes.large,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageSourceOption(
                    icon: Icons.photo_library,
                    label: 'Galerie',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  _buildImageSourceOption(
                    icon: Icons.camera_alt,
                    label: 'Caméra',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: FontSizes.upperMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    if (_images.isEmpty) {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Aucune image sélectionnée',
            style: TextStyle(
              color: Colors.grey,
              fontSize: FontSizes.medium,
            ),
          ),
        ),
      );
    }

    if (_images.length == 1) {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(_images.first),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: _images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(78, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                "${_currentIndex + 1} / ${_images.length}",
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateArticleCubit, CreateArticleState>(
      listener: (context, state) {
        if (state is CreateArticleSuccess) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            title: const Text("Partage !"),
            description: const Text("Vous avez partagé un nouveau post 👏"),
            alignment: Alignment.topCenter,
            autoCloseDuration: const Duration(seconds: 1, milliseconds: 500),
            primaryColor: const Color(0xFFFF7F50),
            borderRadius: BorderRadius.circular(12.0),
            showProgressBar: true,
            closeButton:
                const ToastCloseButton(showType: CloseButtonShowType.none),
            dragToClose: true,
            applyBlurEffect: true,
          );
          Navigator.pop(context);
        } else if (state is CreateArticleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: const Text(
              "Créer un article",
              style: TextStyle(
                fontSize: FontSizes.extra,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white,
                    Color.fromARGB(169, 255, 255, 255),
                    Color.fromARGB(103, 255, 255, 255),
                    Color.fromARGB(0, 255, 255, 255),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageGallery(),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _showImageSourceBottomSheet,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Ajouter des photos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Intitulé',
                    style: TextStyle(
                      fontSize: FontSizes.medium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _titleController,
                    hintText: 'Entrez l\'intitulé de l\'article',
                    maxLength: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Partagez votre expérience',
                    style: TextStyle(
                      fontSize: FontSizes.medium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _descriptionController,
                    hintText: 'Entrez le contenu de votre post',
                    maxLines: 5,
                    maxLength: 500,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                text: 'Créer l\'article',
                suffixIcon: const Icon(
                  Icons.ads_click,
                  color: AppColors.white,
                ),
                isLoading: state is CreateArticleLoading,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                borderRadius: 10,
                height: 50,
                width: double.infinity,
                onPressed: state is CreateArticleLoading
                    ? null
                    : () async {
                        if (_titleController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Veuillez entrer un titre')),
                          );
                          return;
                        }
                        if (_descriptionController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Veuillez entrer une description')),
                          );
                          return;
                        }
                        if (_images.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Veuillez ajouter au moins une image')),
                          );
                          return;
                        }

                        final secureStorage = SecureStorageService();
                        final authorId = await secureStorage.getUserId();

                        context.read<CreateArticleCubit>().createArticle(
                            title: _titleController.text,
                            content: _descriptionController.text,
                            images: _images,
                            authorId: int.parse(authorId!));
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}
