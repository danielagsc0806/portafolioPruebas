require 'appium_lib'
require 'json'
require 'allure-rspec'

Allure.configure do |c|
  c.results_directory = 'allure-results'
  c.clean_results_directory = true
  c.logging_level = Logger::INFO
end

RSpec.configure do |config|
  config.formatter = AllureRspecFormatter
end

describe 'Flujo Mercado Libre', allure: true do
  before(:all) do
    caps = JSON.parse(File.read('config/capabilities.json'))
    opts = { caps: caps, appium_lib: { server_url: 'http://127.0.0.1:4723' } }
    @driver = Appium::Driver.new(opts, true)
    @driver.start_driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  end

  after(:all) do
    @driver.driver_quit
  end

  it 'Busca producto y aplica filtros', severity: :critical do
    @driver.screenshot('screenshots/1_inicio.png')
    Allure.add_attachment(name: 'Inicio', source: File.open('screenshots/1_inicio.png'), type: Allure::ContentType::PNG)

    search_container = @driver.find_element(:id, "com.mercadolibre:id/ui_components_toolbar_search_field")
    search_container.click
    sleep 1

    search_box = @driver.find_element(:id, "com.mercadolibre:id/autosuggest_input_search")
    search_box.send_keys("playstation 5")
    @driver.press_keycode(66)
    @wait.until { @driver.find_element(:id, "com.mercadolibre:id/search_main_content").displayed? }
    @driver.screenshot('screenshots/2_busqueda_playstation.png')
    Allure.add_attachment(name: 'Búsqueda', source: File.open('screenshots/2_busqueda_playstation.png'), type: Allure::ContentType::PNG)

    # Abrir filtros
    filter_button = @driver.find_element(:xpath, '(//android.widget.LinearLayout[@resource-id="com.mercadolibre:id/appbar_content_layout"])[1]/android.widget.LinearLayout')
    filter_button.click
    @wait.until {@driver.find_element(:xpath, '//android.widget.FrameLayout[@resource-id="com.mercadolibre:id/andes_bottom_sheet_frame_view"]/android.widget.FrameLayout').displayed?}

    # Aplica filtros
    @driver.find_element(:xpath, '//android.view.View[@content-desc="Condición"]').click
    @wait.until { @driver.find_element(:xpath, '//android.view.View[@resource-id="ITEM_CONDITION"]').displayed? }
    @driver.find_element(:xpath, '//android.widget.ToggleButton[@resource-id="ITEM_CONDITION-2230284"]').click
    sleep 1
    @driver.screenshot('screenshots/3_condicion_nuevo.png')
    Allure.add_attachment(name: 'Condición: Nuevo', source: File.open('screenshots/3_condicion_nuevo.png'), type: Allure::ContentType::PNG)
    sleep 1

    # Simular scroll hacia abajo
    @driver.execute_script('mobile: swipeGesture', {
    direction: 'up', percent: 0.75,
    left: 300, top: 800,
    width: 800, height: 800
    })
    sleep 1

    # Ordenar por precio mayor
    @driver.find_element(:xpath, '//android.view.View[@content-desc="Ordenar por "]').click
    @wait.until { @driver.find_element(:xpath, '//android.view.View[@resource-id="sort"]').displayed? }
    @driver.find_element(:xpath, '//android.widget.ToggleButton[@resource-id="sort-price_desc"]').click
    @driver.screenshot('screenshots/4_ordenar.png')
    Allure.add_attachment(name: 'Ordenar por:', source: File.open('screenshots/4_ordenar.png'), type: Allure::ContentType::PNG)
    @driver.find_element(:xpath, '//android.widget.Button[@resource-id=":r3:"]').click
    @wait.until { @driver.find_element(:id, "com.mercadolibre:id/search_main_content").displayed? }
    sleep 1

    @driver.execute_script('mobile: swipeGesture', {
    direction: 'up', percent: 0.25,
    left: 100, top: 400,
    width: 800, height: 800
    })

    # Extraer resultados
    cards = @driver.find_elements(:xpath, '(//android.view.View[@resource-id="polycard_component"])')
    puts "✅ Se encontraron #{cards.length} resultados"

    cards.each_with_index do |card, index|
      begin
        nombre = card.find_element(:xpath, './/android.widget.TextView[contains(@text, "Playstation")]').text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        nombre = "Nombre no encontrado"
      end

      begin
        precio = card.find_element(:xpath, './/android.widget.TextView[contains(@content-desc, "Pesos")]').attribute("contentDescription")
      rescue Selenium::WebDriver::Error::NoSuchElementError
        precio = "Precio no encontrado"
      end

      puts "🛍️ Producto ##{index + 1}:"
      puts "   Nombre: #{nombre}"
      puts "   Precio: #{precio}"

      Allure.add_attachment(name: "Producto #{index + 1}", source: "#{nombre} - #{precio}", type: Allure::ContentType::TXT)
    end
  end
end