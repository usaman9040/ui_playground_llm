# 🚀 AI UI Playground

**Flutter UI playground with Gemini AI integration - modify app interface in real-time using natural language commands. Built with Stacked MVVM architecture for seamless AI-driven UI customization.**

## 📱 Demo

https://github.com/user-attachments/assets/066b1b6f-4cf8-49c3-8560-e8437249018e


## ✨ Features

- 🎨 **AI-Powered UI Customization**: Modify colors, sizes, and text using natural language
- 🧠 **Gemini 1.5 Flash Integration**: Advanced AI understanding of UI modification requests
- 🔄 **Real-time Updates**: See changes applied instantly as you type commands
- 🎯 **Stacked MVVM Architecture**: Clean, scalable code structure
- 📱 **Responsive Design**: Works across different screen sizes
- 🔧 **Reset Functionality**: Return to default values with one click

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0+ installed
- Gemini API key from [Google AI Studio](https://makersuite.google.com/app/apikey)

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/ui-playground-llm.git
cd ui-playground-llm
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Environment Variables
Create a `.env` file in the root directory and add your Gemini API key:

```env
GEMMNI_KEY=your_gemini_api_key_here
```

**To get your Gemini API key:**
1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key"
3. Copy the generated key
4. Paste it in your `.env` file

### 4. Generate Code
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 5. Run the App
```bash
flutter run
```

## 🎥 Demo Video

<!-- Add your demo video here -->
_Demo video will be added here showing the AI playground in action_

**What the demo shows:**
- Natural language commands changing UI properties
- Real-time color and size modifications
- Error handling and validation
- Reset functionality

## 🏗️ Architecture

### State Management: Stacked (MVVM)

```
📦 UI Layer (Views)
├── CustomFormView (UI)
└── HomeView (Navigation)

🧠 Business Logic (ViewModels)
├── CustomFormViewModel
└── HomeViewModel

🔧 Services Layer
├── GeminiService (AI Integration)
└── Navigation/Dialog Services

📊 Models
└── UIProperty (Data Transfer Object)
```

### Key Components

#### **GeminiService**
- Handles communication with Gemini 1.5 Flash
- Maintains conversation context
- Parses JSON responses safely
- Manages API key and error handling

#### **CustomFormViewModel**
- Manages UI state and properties
- Integrates with GeminiService
- Handles form validation
- Provides loading states and error management

#### **UIProperty Model**
- Serializes/deserializes UI configuration
- Converts between Color objects and hex strings
- Provides validation and default values

### Data Flow
1. User enters natural language command
2. ViewModel sends command + current state to GeminiService
3. GeminiService calls Gemini AI with structured prompt
4. AI returns JSON with updated properties
5. ViewModel applies changes and rebuilds UI

## 💡 Usage Examples

### Color Commands
```
"Change background color to blue"
"Make save button red"
"Set background to dark purple"
```

### Size Commands
```
"Make text fields bigger"
"Increase save button size by 50%"
"Set text field width to 400 pixels"
```

### Text Commands
```
"Change title to 'User Registration'"
"Change save button text to 'Submit Now'"
```

### Combined Commands
```
"Make save button green and bigger"
"Change to red theme with larger elements"
"Set title to 'Contact Form' and make background blue"
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Stacked (MVVM pattern)
- **AI Integration**: Google Generative AI (Gemini 1.5 Flash)
- **Environment Management**: flutter_dotenv
- **Code Generation**: build_runner, stacked_generator
- **Dependency Injection**: Stacked Services (get_it)

## 📁 Project Structure

```
lib/
├── app/                     # App configuration
│   ├── app.dart            # Main app setup with routes
│   ├── app.locator.dart    # Dependency injection
│   └── app.router.dart     # Route generation
├── models/                 # Data models
│   └── ui_property.dart    # UI configuration model
├── services/              # Business logic services
│   └── gemini_service.dart # AI integration
├── ui/
│   ├── common/            # Shared UI components
│   └── views/             # Screen implementations
│       ├── home/          # Home screen
│       └── custom_form/   # AI playground screen
└── main.dart              # App entry point
```

## 🎛️ Customizable Properties

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `backgroundColor` | Color (Hex) | Screen background color | `#FF1A1B1E` |
| `title` | String | Screen title text | "AI UI Playground" |
| `textFieldWidth` | Double | Text field width (px) | `300.0` |
| `textFieldHeight` | Double | Text field height (px) | `56.0` |
| `saveButtonTitle` | String | Save button text | "Save" |
| `saveButtonWidth` | Double | Save button width (px) | `150.0` |
| `saveButtonHeight` | Double | Save button height (px) | `45.0` |
| `saveButtonBackgroundColor` | Color (Hex) | Save button color | `#FF9600FF` |

## 🔧 Troubleshooting

### Common Issues

**"GEMMNI_KEY not found" Error:**
- Ensure `.env` file exists in root directory
- Check API key is correctly formatted
- Verify no extra spaces or quotes around the key

**Build Errors:**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**AI Not Responding:**
- Check internet connection
- Verify Gemini API key is valid
- Check Flutter logs for detailed error messages

### Development

**Adding New UI Properties:**
1. Update `UIProperty` model
2. Add getters/setters in `CustomFormViewModel`
3. Update AI prompt in `GeminiService`
4. Modify UI in `CustomFormView`

**Testing AI Commands:**
- Use Flutter DevTools for debugging
- Check logs for AI request/response details
- Test with simple commands first

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- **Stacked Package**: For excellent MVVM architecture
- **Google Generative AI**: For powerful language understanding
- **Flutter Team**: For the amazing cross-platform framework
