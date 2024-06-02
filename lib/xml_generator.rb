require 'rexml/document'
require 'fileutils'

class XMLGenerator
  def initialize(audio_metadata, file_path, output_directory)
    @audio_metadata = audio_metadata
    @file_path = file_path
    @output_directory = output_directory
  end

  def generate_xml
    xml = to_xml
    save_xml(xml)
  end

  def to_xml
    xml = REXML::Document.new
    root_element = xml.add_element('track')

    @audio_metadata.each do |key, value|
      root_element.add_element(key.to_s).text = value
    end

    xml
  end


  def save_xml(xml)
    output_file_path = "#{@output_directory}/#{File.basename(@file_path, '.wav')}.xml"

    FileUtils.mkdir_p(@output_directory) unless Dir.exist?(@output_directory)

    # This formatter is used to show the XML elements inline
    formatter = REXML::Formatters::Pretty.new(2)
    formatter.compact = true

    File.open(output_file_path, 'w') do |file|
      formatter.write(xml, file)
    end
  end
end
