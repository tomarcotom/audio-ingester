# Audio Ingester

This is a Ruby software to parse wav files and generate XML files with their relevant metadata stored as an output.


## Usage

```ruby
# go to the /lib folder

ruby audio_parser.rb <input_folder_with_wav_files>
```

## Result
The result is stored in a ```<input_folder_with_wav_files>/output``` folder, and for each execution a new subfolder is created with the current timestamp name.

## Run tests
Tests can be ran running ````rspec```` while in the main directory
