Este proyecto permite automatizar flujos móviles en Android usando Ruby, Appium y generar reportes visuales con Allure.

----------------🧰 Requisitos previos------------------------- 
Instalar Ruby:
https://www.ruby-lang.org/es/documentation/installation/

Instalar Appium y dependencias:
npm install -g appium
npm install -g appium-doctor   
npm install appium appium-uiautomator2-driver wd --save-dev

Descargar Android SDK Command Line Tools (agregar sdkmanager y avdmanager al PATH):
https://developer.android.com/studio#cmdline-tools

------------------📦 Configuración del emulador Android--------------------------
Ver lista de system-images disponibles:
sdkmanager --list | Select-String "system-images"

Ver lista de dispositivos disponibles:
avdmanager list devices

Instalar imagen:
sdkmanager "system-images;android-33;google_apis_playstore;x86_64"

Crear emulador:
Emulador prueba 1:
avdmanager create avd -n testML -k "system-images;android-33;google_apis_playstore;x86_64" --device "pixel_5"

Ver lista de emuladores:  
emulator -list-avds

------------------------📲 Configurar driver Android------------------------------------
Driver Android:
appium driver install uiautomator2

Verificar pantalla activa de emulador:
adb shell dumpsys window | Select-String "mCurrentFocus","mFocusedApp"
------------------------📲Instalacion App Mercado Libre-----------------------------------------
El emulador ya incluye la app de Play Store, lo que permite instalar Mercado Libre manualmente
sin necesidad de usar APK externos.

1.- Abrir emulador: emulator -avd testML
2.- Abre la Play Store en el emulador.
3.- Inicia sesión con una cuenta de Google válida (puedes usar una cuenta de pruebas).
4.- Busca "Mercado Libre" en la barra de búsqueda.
5.- Instala la app oficial desarrollada por Mercado Libre

Verificar si la Mercado Libre se instalo correctamente:
adb shell pm list packages | Select-String mercadolibre
------------------------🚀 Ejecución de prueba----------------------------------------

🖥️Teminal 1 - Iniciar emulador: 
emulator -avd testML

🧩Terminal 2 - Iniciar Appium server:
appium

🧪Temrinal 3 - Ejecutar test ruby spec: (la app se debe abrir manual mente antes de ejecutar la prueba)
rspec spec/test_mercado_spec.rb

📊Generar allure report:
allure generate allure-results --clean -o allure-report

🌐Abrir report:
allure open allure-report

