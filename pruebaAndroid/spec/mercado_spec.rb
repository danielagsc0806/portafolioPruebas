require 'appium_lib'
require 'json'
require 'allure-rspec'
require_relative '../pages/home-page'
require_relative '../pages/results-page'
require_relative '../helpers/allure_helper'

describe 'Flujo Mercado Libre', feature: 'flujoML', allure: true do
  before(:all) do
    caps = JSON.parse(File.read('config/capabilities.json'))
    opts = { caps: caps, appium_lib: { server_url: 'http://127.0.0.1:4723' } }
    @driver = Appium::Driver.new(opts, true).start_driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)

    @home = HomePage.new(@driver, @wait)
    @results = ResultsPage.new(@driver, @wait)
  end

  after(:all) do
    @driver.quit
  end

    it 'Busca producto', story: 'Busqueda de productos' do
        @home.search("playstation 5")
    end

    it 'Aplicar filtros', story: 'Filtar resultados por condición' do
        @results.filters
        @results.condition_new
        @results.sort_price
    end

    it 'Mostrar lista productos', story: 'Mostrar lista de 5 productos' do
        resultados = @results.product_list
        resultados.first(5).each do |i|
        puts "Producto ##{i[:index]}: #{i[:nombre]} - #{i[:precio]}"
        Allure.add_attachment(
          name: "Producto #{i[:index]}",
          source: "#{i[:nombre]} - #{i[:precio]}",
          type: Allure::ContentType::TXT)
        end
    end
end
