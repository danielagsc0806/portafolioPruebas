Link descarga Ruby:
https://www.ruby-lang.org/es/documentation/installation/

Appium:
npm install -g appium
npm install -g appium-doctor   
npm install appium appium-uiautomator2-driver wd --save-dev

Android SDK Command Line Tools:
https://developer.android.com/studio#cmdline-tools

Instalar imagen:
sdkmanager "system-images;android-33;google_apis;x86_64"

Crear emulador:
avdmanager create avd -n testEmu -k "system-images;android-33;google_apis;x86_64"
Emulador Samsung:
avdmanager create avd -n GalaxyS10 -k "system-images;android-33;google_apis;x86_64"
Emulador pixel:
avdmanager create avd -n testPixel -k "system-images;android-33;google_apis;x86_64" --device "pixel_4"

Ver lista de emuladores:  emulator -list-avds

Correr emulador:
emulator -avd testEmu
emulator -avd GalaxyS10

Driver Android:
appium driver install uiautomator2

Instalacion app mercado libre:
adb install apps\com.mercadolibre.apk

Verificar pantalla de emulador:
adb shell dumpsys window | Select-String "mCurrentFocus","mFocusedApp"
