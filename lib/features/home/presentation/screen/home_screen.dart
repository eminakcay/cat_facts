import 'dart:async';

import 'package:cat_facts/core/constants/constants.dart';
import 'package:cat_facts/features/home/domain/entities/fact_entity.dart';
import 'package:cat_facts/features/home/domain/usecases/get_fact_use_case.dart';
import 'package:cat_facts/features/home/domain/usecases/get_image_use_case.dart';
import 'package:cat_facts/features/home/presentation/provider/home_provider.dart';
import 'package:cat_facts/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isButtonEnabled = true;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _generateFactAndImage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, minWidth: 200),
          margin: const EdgeInsets.all(32),
          child: _buildConsumer(),
        ),
      ),
    );
  }

  Widget _buildConsumer() {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        if (provider.apiError != null) {
          return _buildErrorText(provider);
        }

        return _buildImageAndText(provider);
      },
    );
  }

  Widget _buildImageAndText(HomeProvider provider) {
    return (provider.isInitialized)
        ? _buildLoadingIndicator()
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(provider),
              const SizedBox(height: 16),
              _buildText(provider),
              const SizedBox(height: 40),
            ],
          );
  }

  Widget _buildText(HomeProvider provider) {
    final factEntity = provider.factEntity ?? FactEntity();

    return SelectableText(
      factEntity.fact ?? '',
      style: GoogleFonts.lato(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildImage(HomeProvider provider) {
    final image = provider.image;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: image != null ? Image.memory(image) : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return isButtonEnabled
        ? FloatingActionButton(
            onPressed: _onFloatingActionButtonPressed,
            backgroundColor: Colors.deepPurple[200],
            child: const Icon(Icons.refresh_rounded, color: Colors.white),
          )
        : Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset('./assets/images/cat.png', height: 40),
          );
  }

  Widget _buildErrorText(HomeProvider provider) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ERROR_TITLE,
            style: GoogleFonts.lato(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Text(
            provider.apiError!.name,
            style: GoogleFonts.lato(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _onFloatingActionButtonPressed() {
    setState(() => isButtonEnabled = false);
    // disable button for 1 second
    Timer(
      const Duration(seconds: 1),
      () => setState(() => isButtonEnabled = true),
    );
    _generateFactAndImage();
  }

  void _generateFactAndImage() {
    locator<GetImageUseCase>().call();
    Future.delayed(const Duration(milliseconds: 180)).then(
      (value) => locator<GetFactUseCase>().call(),
    );
  }
}
