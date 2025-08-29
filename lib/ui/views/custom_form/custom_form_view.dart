import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_playground_llm/ui/common/ui_helpers.dart';

import 'custom_form_viewmodel.dart';

class CustomFormView extends StackedView<CustomFormViewModel> {
  const CustomFormView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, CustomFormViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: viewModel.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Main content area - scrollable
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title Section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        viewModel.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    verticalSpaceLarge,

                    // Form Section
                    _buildFormSection(viewModel),

                    verticalSpaceLarge,

                    // Action Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSaveButton(viewModel),
                        _buildResetButton(viewModel),
                      ],
                    ),

                    verticalSpaceLarge,

                    // Result Display
                    if (viewModel.commandResult.isNotEmpty) ...[
                      _buildResultSection(viewModel),
                      verticalSpaceMedium,
                    ],
                  ],
                ),
              ),
            ),
            
            // Divider
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            
            // Command section - fixed at bottom
            Container(
              padding: const EdgeInsets.all(20.0),
              child: _buildCommandSection(viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection(CustomFormViewModel viewModel) {
    return Column(
      children: [
        // Name Text Field
        SizedBox(
          width: viewModel.textFieldWidth,
          height: viewModel.textFieldHeight,
          child: TextField(
            controller: viewModel.nameController,
            onChanged: viewModel.onNameChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: 'Enter your name',
              hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: Colors.grey.withValues(alpha: 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Color(0xFF9600FF), width: 2.0),
              ),
            ),
          ),
        ),

        verticalSpaceMedium,

        // Email Text Field
        SizedBox(
          width: viewModel.textFieldWidth,
          height: viewModel.textFieldHeight,
          child: TextField(
            controller: viewModel.emailController,
            onChanged: viewModel.onEmailChanged,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: Colors.grey.withValues(alpha: 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Color(0xFF9600FF), width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(CustomFormViewModel viewModel) {
    return SizedBox(
      width: viewModel.saveButtonWidth,
      height: viewModel.saveButtonHeight,
      child: ElevatedButton(
        onPressed: viewModel.saveForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: viewModel.saveButtonBackgroundColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2.0,
        ),
        child: Text(
          viewModel.saveButtonTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton(CustomFormViewModel viewModel) {
    return SizedBox(
      width: 120,
      height: viewModel.saveButtonHeight,
      child: ElevatedButton(
        onPressed: viewModel.resetToDefaults,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B7280),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2.0,
        ),
        child: const Text(
          'Reset',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCommandSection(CustomFormViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI Command Input',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 8),

        // Command Text Field and Submit Button Row
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: viewModel.commandController,
                  onChanged: viewModel.onCommandChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter command',
                    labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    hintText: 'e.g., "make background blue"',
                    hintStyle: TextStyle(
                        color: Colors.grey.withValues(alpha: 0.6), fontSize: 12),
                    filled: true,
                    fillColor: Colors.grey.withValues(alpha: 0.1),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Colors.grey.withValues(alpha: 0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFF9600FF), width: 2.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Submit Button
            SizedBox(
              width: 80,
              height: 45,
              child: ElevatedButton(
                onPressed: viewModel.isProcessingCommand
                    ? null
                    : viewModel.executeCommand,
                style: ElevatedButton.styleFrom(
                  backgroundColor: viewModel.isProcessingCommand
                      ? const Color(0xFF474A54).withValues(alpha: 0.6)
                      : const Color(0xFF474A54),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2.0,
                  padding: EdgeInsets.zero,
                ),
                child: viewModel.isProcessingCommand
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),

        // Compact examples
        const SizedBox(height: 8),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'Try: "change background to blue", "make buttons bigger", "red theme"',
            style: TextStyle(
              fontSize: 10,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildResultSection(CustomFormViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: viewModel.lastError != null 
            ? Colors.red.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: viewModel.lastError != null 
              ? Colors.red.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            viewModel.lastError != null ? 'Error:' : 'Result:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: viewModel.lastError != null ? Colors.red : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            viewModel.commandResult,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  CustomFormViewModel viewModelBuilder(BuildContext context) =>
      CustomFormViewModel();
}
