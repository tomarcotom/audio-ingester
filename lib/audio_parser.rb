require_relative 'wav_file'
require_relative 'wav_parser'
require_relative 'xml_generator'
require 'date'

def run(input_directory)
  output_directory = input_directory + "/output/#{DateTime.now}"

  wav_parser = WavParser.new

  Dir.glob("#{input_directory}/*").each do |file_path|
    wav_file = WavFile.new(file_path)
    begin
      if wav_file.is_valid?
        audio_metadata = wav_parser.parse(wav_file)
        XMLGenerator.new(audio_metadata, file_path, output_directory).generate_xml
      end
    rescue Exception => error
      puts error
      next
    end
  end
end

run(ARGV[0])
