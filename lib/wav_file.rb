class WavFile
  def initialize(file_path)
    @file_path = file_path
    @file = File.open(file_path, 'rb')
  end

  def is_valid?
    standard_error_msg = "File #{@file_path} is not a valid WAV file: "
    return false unless File.file?(@file_path)

    riff_id = @file.read(4)
    raise standard_error_msg + 'Missing RIFF' unless riff_id == 'RIFF'

    @file.read(4).unpack1('L') # skip file_size
    wave_id = @file.read(4)
    raise standard_error_msg + 'Missing WAVE' unless wave_id == 'WAVE'

    true
  end

  def file
    @file
  end
end
