class WavParser
  def read_chunk(file)
    id = file.read(4)
    size = file.read(4).unpack1('L')
    data = file.read(size)
    return id, size, data
  end

  def get_fmt_metadata(chunk_data, audio_metadata)
    format, channel_count, sampling_rate, byte_rate, _, bit_depth = chunk_data.unpack('S<S<L<L<S<S<')
    audio_metadata[:format] = format == 1 ? 'PCM' : 'Compressed'
    audio_metadata[:channel_count] = channel_count
    audio_metadata[:sampling_rate] = sampling_rate
    audio_metadata[:byte_rate] = byte_rate
    audio_metadata[:bit_depth] = bit_depth
    audio_metadata[:bit_rate] = sampling_rate * channel_count * bit_depth
  end

  def parse(wav_file)
    audio_metadata = {}

      until wav_file.file.eof?
        chunk_id, _, chunk_data = read_chunk(wav_file.file)

        if chunk_id == 'fmt ' then
          get_fmt_metadata(chunk_data, audio_metadata)
        end
      end

    audio_metadata
  end
end
