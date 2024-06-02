class WavFileCreator
  def create_wav_file(file_path)
    File.open(file_path, 'wb') do |file|
      # RIFF header
      file.write('RIFF')
      file.write([36 + 16].pack('V')) # Chunk size: 36 + Subchunk1Size + Subchunk2Size
      file.write('WAVE')

      # fmt subchunk
      file.write('fmt ')
      file.write([16].pack('V')) # Subchunk1Size (16 for PCM)
      file.write([1].pack('v')) # AudioFormat (1 for PCM)
      file.write([4].pack('v')) # NumChannels
      file.write([44100].pack('V')) # SampleRate
      file.write([44100 * 2 * 16 / 8].pack('V')) # ByteRate (SampleRate * NumChannels * BitsPerSample/8)
      file.write([2 * 16 / 8].pack('v')) # BlockAlign (NumChannels * BitsPerSample/8)
      file.write([16].pack('v')) # BitsPerSample

      # data subchunk
      file.write('data')
      file.write([0].pack('V')) # Subchunk2Size (NumSamples * NumChannels * BitsPerSample/8)
    end
  end
end
