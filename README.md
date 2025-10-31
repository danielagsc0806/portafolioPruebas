Links de descargas:
Node installer:
https://nodejs.org/en/download

Extenciones recomendadas:
-Playright Test for VSCode

Comandos Playwright:
-INSTALACIÓN: npm init playwright@latest
-CONFIGURACIÓN NECESARIA PARA EJECUTAR EL TEST:
1:use TypeScript
2:dir tests: test
3:GitHub Actions: false
4:install browsers: true
-EJECUTAR TEST: npx platwright test

Comandos allure:
-INSTALACIÓN:
npm install --save-dev allure-playwright allure-commandline
-GENERAR REPORTE
allure generate allure-results --clean -o allure-report
allure open allure-report