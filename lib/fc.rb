# frozen_string_literal: true

require 'forwardable'

class FC
  module Error
    class DirectoryDoesNotExist < StandardError; end
    class FileDoesNotExist < StandardError; end
  end

  class File
    attr_reader :path

    def initialize(filepath)
      raise Error::FileDoesNotExist unless ::File.file?(filepath)

      @path = filepath
    end

    def name
      @name ||= ::File.basename(path)
    end

    def ext
      @ext ||= ::File.extname(path).delete!('.')
    end
  end

  attr_reader :path, :files

  extend Forwardable

  def_delegators :@files, :size, :empty?, :first, :last, :clear

  def initialize(dir_path, files: [])
    raise Error::DirectoryDoesNotExist unless ::File.directory?(dir_path)

    @path = dir_path
    @files = files
  end

  def filter(recursive: false)
    clear
    return self unless block_given?

    index(recursive: recursive) { |file| @files << file if yield(file) }
    self
  end

  def index(recursive: false, &block)
    indexed_files = []
    Dir.each_child(path) do |filename|
      filepath = ::File.join(path, filename)
      if ::File.file?(filepath)
        tmp = FC::File.new(filepath)
        indexed_files << tmp
        block.call(tmp)
      elsif recursive
        tmp_array = FC
          .new(filepath)
          .index(recursive: recursive, &block)
        indexed_files.concat(tmp_array)
      end
    end
    indexed_files
  end
end
