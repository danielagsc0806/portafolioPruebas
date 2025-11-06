require 'appium_lib'
require 'json'

caps = JSON.parse(File.read('config/capabilities.json'))

opts = {
  caps: caps,
  appium_lib: { server_url: 'http://127.0.0.1:4723' }
}

driver = Appium::Driver.new(opts, true)
wait = Selenium::WebDriver::Wait.new(timeout: 10)
driver.start_driver
driver.screenshot('screenshots/inicio.png')
puts "✅ App Mercado Libre abierta correctamente"

# Ejemplo: buscar un producto
search_container = driver.find_element(:id, "com.mercadolibre:id/ui_components_toolbar_search_field")
search_container.click
driver.screenshot('screenshots/busqueda.png');
puts "✅ hacer busqueda correctamente"


search_box = driver.find_element(:id, "com.mercadolibre:id/autosuggest_input_search")
search_box.send_keys("playstation 5")
driver.press_keycode(66) # Enter
wait.until {driver.find_element(:id, "com.mercadolibre:id/search_main_content").displayed?}
driver.screenshot('screenshots/busqueda_playstation5.png');
puts "✅ se muestran resultados de busqueda correctamente"

filter_button = driver.find_element(:xpath, '(//android.widget.LinearLayout[@resource-id="com.mercadolibre:id/appbar_content_layout"])[1]/android.widget.LinearLayout')
filter_button.click
driver.screenshot('screenshots/filtros.png');
puts "✅ se abre seccion de filtros correctamente"

frame_filter = driver.find_element(:xpath, '//android.widget.FrameLayout[@resource-id="com.mercadolibre:id/andes_bottom_sheet_frame_view"]/android.widget.FrameLayout')
wait.until {frame_filter.displayed?}
puts "✅ el frame de los filtros esta visible"
#####################################################condition new#############################################
category_condition = driver.find_element(:xpath, '//android.view.View[@content-desc="Condición"]')
category_condition.click
puts "✅ boton condicion clickeado"

wait.until {driver.find_element(:xpath, '//android.view.View[@resource-id="ITEM_CONDITION"]').displayed?}
puts "✅ se muestra la seccion de condicion de los productos"

condition_new = driver.find_element(:xpath, '//android.widget.ToggleButton[@resource-id="ITEM_CONDITION-2230284"]')
condition_new.click
driver.screenshot('screenshots/filtro_condicion_nuevo.png');
puts "✅ filtro condicion nuevo seleccionado"
#######################################################order by high price##########################################

driver.driver_quit