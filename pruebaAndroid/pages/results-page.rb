class ResultsPage
  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def filters
    filter_button = @driver.find_element(:xpath, '(//android.widget.LinearLayout[@resource-id="com.mercadolibre:id/appbar_content_layout"])[1]/android.widget.LinearLayout')
    filter_button.click
    @wait.until {@driver.find_element(:xpath, '//android.widget.FrameLayout[@resource-id="com.mercadolibre:id/andes_bottom_sheet_frame_view"]/android.widget.FrameLayout').displayed?}
  end

  def condition_new
    @driver.find_element(:xpath, '//android.view.View[@content-desc="Condición"]').click
    @wait.until { @driver.find_element(:xpath, '//android.view.View[@resource-id="ITEM_CONDITION"]').displayed? }
    @driver.find_element(:xpath, '//android.widget.ToggleButton[@resource-id="ITEM_CONDITION-2230284"]').click
    @wait.until { @driver.find_element(:xpath, '//android.view.View[@resource-id="ITEM_CONDITION"]').displayed? }
  end

  def sort_price
    @driver.execute_script('mobile: swipeGesture', {
    direction: 'up', percent: 0.80,
    left: 300, top: 800,
    width: 800, height: 800
    })
    @wait.until { @driver.find_element(:xpath, '//android.view.View[@content-desc="Ordenar por "]').displayed}
    @driver.find_element(:xpath, '//android.view.View[@content-desc="Ordenar por "]').click
    @wait.until { @driver.find_element(:xpath, '//android.view.View[@resource-id="sort"]').displayed? }
    @driver.find_element(:xpath, '//android.widget.ToggleButton[@resource-id="sort-price_desc"]').click
    @driver.find_element(:xpath, '//android.widget.Button[@resource-id=":r3:"]').click
    @wait.until { @driver.find_element(:id, "com.mercadolibre:id/search_main_content").displayed? }
  end

  def product_list
    @driver.execute_script('mobile: swipeGesture', {
    direction: 'up', percent: 0.20,
    left: 100, top: 400,
    width: 800, height: 800
    })

    cards = @driver.find_elements(:xpath, '(//android.view.View[@resource-id="polycard_component"])')

    cards.map.with_index(1) do |card, index|
    nombre = card.find_element(:xpath, './/android.widget.TextView[contains(@text, "Playstation")]').text rescue "Nombre no encontrado"
    precio = card.find_element(:xpath, './/android.widget.TextView[contains(@resource-id, "current amount")]').attribute("content-desc") rescue "Precio no encontrado"
    { index: index, nombre: nombre, precio: precio }
    end 
  end 
end