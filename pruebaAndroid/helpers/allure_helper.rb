require 'allure-rspec'
require 'fileutils'

module AllureHelper
  # Se ejecuta después de cada test (it)
  def self.attach_screenshot(driver, example)
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    FileUtils.mkdir_p('screenshots') unless Dir.exist?('screenshots')
    file_name = "screenshots/#{example.description.gsub(/\s+/, '_')}_#{timestamp}.png"
    driver.save_screenshot(file_name)

    Allure.add_attachment(
      name: "Captura - #{example.description}",
      source: File.open(file_name),
      type: Allure::ContentType::PNG
    )
  end

  # Hook global para RSpec
  RSpec.configure do |config|
    # Configuración base de Allure
    Allure.configure do |c|
      c.results_directory = 'allure-results'
      c.clean_results_directory = true
      c.logging_level = Logger::INFO
    end

    config.formatter = AllureRspecFormatter

    # Toma captura automáticamente si la prueba falla
    config.after(:each) do |example|
      if example.exception
        AllureHelper.attach_screenshot(@driver, example)
      end
    end

    # Si quieres también capturas al finalizar cada test (no solo en fallos):
     config.after(:each) do |example|
       AllureHelper.attach_screenshot(@driver, example)
     end
  end
end
