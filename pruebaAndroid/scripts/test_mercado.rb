require 'appium_lib'
require 'json'

caps = JSON.parse(File.read('config/capabilities.json'))

opts = {
  caps: caps,
  appium_lib: { server_url: 'http://127.0.0.1:4723' }
}

driver = Appium::Driver.new(opts, true)
driver.start_driver
driver.screenshot('screenshots/inicio.png')

puts "✅ App Mercado Libre abierta correctamente"

# Ejemplo: buscar un producto
search_container = driver.find_element(:id, "com.mercadolibre:id/ui_components_action_bar_search_field")
search_container.click
driver.screenshot('screenshots/busqueda.png');
sleep 1


search_box = driver.find_element(:id, "com.mercadolibre:id/search_input_edittext")
search_box.send_keys("playstation 5")
sleep 1
driver.press_keycode(66) # Enter
driver.screenshot('screenshots/busqueda_playstation5.png');
sleep 5
driver.quit