class HomePage
  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def search (producto)
    search_container = @driver.find_element(:id, "com.mercadolibre:id/ui_components_toolbar_search_field")
    search_container.click
    @wait.until {@driver.is_keyboard_shown}
    search_box = @driver.find_element(:id, "com.mercadolibre:id/autosuggest_input_search")
    search_box.send_keys(producto)
    @driver.press_keycode(66)
    @wait.until { @driver.find_element(:id, "com.mercadolibre:id/search_main_content").displayed? }
  end
end