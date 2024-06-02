require 'rspec'
require 'fileutils'
require_relative '../lib/wav_file'
require_relative '../lib/wav_parser'
require_relative './utils/wav_file_creator'

RSpec.describe 'WAVParser' do
  let(:input_dir) { '../rspec/rspec_input' }
  let(:file_path) { File.join(input_dir, 'test.wav') }

  before do
    FileUtils.mkdir_p(input_dir)
    WavFileCreator.new.create_wav_file(file_path)
  end

  after do
    FileUtils.rm_rf(Dir['../rspec/rspec_input'])
    FileUtils.rm_rf('a')
  end

  describe 'Parse wav file' do
    let(:wav_file) { WavFile.new(file_path) }
    it 'returns the correct metadata' do
      expect(wav_file.is_valid?)
      wav_parser = WavParser.new
      audio_metadata = wav_parser.parse(wav_file)
      expect(audio_metadata[:format]).to eq('PCM')
      expect(audio_metadata[:channel_count]).to eq(4)
      expect(audio_metadata[:sampling_rate]).to eq(44100)
      expect(audio_metadata[:byte_rate]).to eq(176400)
      expect(audio_metadata[:bit_depth]).to eq(16)
      expect(audio_metadata[:bit_rate]).to eq(2822400)
    end
  end
end
