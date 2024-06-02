require 'rspec'
require 'fileutils'
require_relative '../lib/wav_file'
require_relative './utils/wav_file_creator'

RSpec.describe 'WAVFile' do
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

  describe 'Check wav file format' do
    it 'is a valid wav' do
      expect(File).to exist(file_path)
      wav_file = WavFile.new(file_path)
      expect(wav_file.is_valid?)
    end
  end
end
