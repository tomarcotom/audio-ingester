require 'rspec'
require 'fileutils'
require_relative '../lib/wav_file'
require_relative '../lib/xml_generator'
require_relative '../lib/wav_parser'
require_relative './utils/wav_file_creator'

RSpec.describe 'XMLGenerator' do
  let(:input_dir) { '../rspec/rspec_input' }
  let(:file_path) { File.join(input_dir, 'test.wav') }

  before do
    FileUtils.mkdir_p(input_dir)
    WavFileCreator.new.create_wav_file(file_path)
  end

  after do
    FileUtils.rm_rf(Dir['../rspec/rspec_input'])
    FileUtils.rm_rf('a')
    FileUtils.rm_rf(Dir['../rspec/rspec_output'])
    FileUtils.rm_rf('a')
  end

  describe 'Generate XML output' do
    let(:wav_file) { WavFile.new(file_path) }
    it 'creates the XML ouput file with the correct metadata informations' do
      expect(wav_file.is_valid?)
      audio_metadata = WavParser.new.parse(wav_file)
      xml_generator = XMLGenerator.new(audio_metadata, file_path, '../rspec/rspec_output')
      xml_generator.generate_xml
      expect(File).to exist('../rspec/rspec_output/test.xml')
      output = File.read('../rspec/rspec_output/test.xml')
      expect(output).to include('<format>PCM</format>')
      expect(output).to include('<channel_count>4</channel_count>')
      expect(output).to include('<sampling_rate>44100</sampling_rate>')
      expect(output).to include('<byte_rate>176400</byte_rate>')
      expect(output).to include('<bit_depth>16</bit_depth>')
      expect(output).to include('<bit_rate>2822400</bit_rate>')
    end
  end
end
