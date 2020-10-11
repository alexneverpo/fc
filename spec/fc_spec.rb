# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FC do
  subject(:fc) { described_class.new(dir_path) }

  let(:dir_path) { ::File.join(Dir.pwd, 'example') }
  let(:filepath) { ::File.join(Dir.pwd, 'example/a.txt') }
  let(:filename) { 'a.txt' }
  let(:filename_in_sub_folder) { 'c.txt' }
  let(:ext) { ::File.extname(filename).delete!('.') }

  describe '::new' do
    it 'raises error if the first argv is not a directory path' do
      expect { described_class.new(filepath) }.to raise_error(FC::Error::DirectoryDoesNotExist)
      expect { fc }.not_to raise_error
    end
  end

  describe '#filter' do
    it 'returns itself' do
      expect(fc.filter).to eq(fc)
    end

    it 'can filter by filepath' do
      fc.filter { |file| file.path.match?(/#{filepath}$/) }
      expect(fc.size).to eq(1)
      expect(fc.first.path).to eq(filepath)
    end

    it 'can filter by filename' do
      fc.filter { |file| file.name == filename }
      expect(fc.size).to eq(1)
      expect(fc.first.name).to eq(filename)
    end

    it 'can filter by ext name' do
      fc.filter { |file| file.ext == ext }
      expect(fc.size).to eq(2)
      expect(fc.first.ext).to eq(ext)
    end

    it 'can filter recursively' do
      target_ext = 'json'
      fc.filter(recursive: true) { |file| file.ext == target_ext }
      expect(fc.size).to eq(1)
      expect(fc.first.ext).to eq(target_ext)
    end
  end
end
