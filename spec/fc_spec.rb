# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FC do
  let(:dir_path) { ::File.join(Dir.pwd, 'example') }
  let(:filepath) { ::File.join(Dir.pwd, 'example/a.txt') }
  let(:filename) { 'a.txt' }
  let(:filename_in_sub_folder) { 'c.txt' }
  subject { FC.new(dir_path) }

  describe '::new' do
    it 'raises error if the first argv is not a directory path' do
      expect { FC.new(filepath) }.to raise_error(FC::Error::DirectoryDoesNotExist)
      expect { subject }.to_not raise_error
    end
  end

  describe '#filter' do
    it 'returns itself' do
      expect(subject.filter).to eq(subject)
    end

    it 'can filter by filepath' do
      fc = subject.filter { |file| file.path.match?(/#{filepath}$/) }
      expect(fc.size).to eq(1)
    end

    it 'can filter by filename' do
      fc = subject.filter { |file| file.name == filename }
      expect(fc.size).to eq(1)
    end
  end
end
