# frozen_string_literal: true

require "json"
require_relative "save_file_manager_text"

module SaveFileManager
  include SaveFileManagerText

  SAVES_DIR = "./saved_games/"

  def initialize_save_directory
    Dir.mkdir(SAVES_DIR) unless Dir.exist?(SAVES_DIR)
  end

  def save_game(data = @board.encode_game_state)
    return too_many_saves if file_list.length >= total_unique_filenames

    filename = generate_filename
    File.open("#{SAVES_DIR}#{filename}", "w") do |file|
      file.puts(JSON.dump(data))
    end
    puts game_saved_msg(filename)
    sleep(1)
    exit
  end

  def load_game
    return no_saves if file_list.empty?

    filename = "#{SAVES_DIR}#{file_list[select_file]}"
    data = JSON.load(File.read(filename))
    File.delete(filename)
    @board.restore_position(data)
  end

  def total_unique_filenames
    filename_adjectives.length * filename_nouns.length
  end

  def filename_adjectives
    %w[sleepy jumpy feisty humble proud]
  end

  def filename_nouns
    %w[panda octopus lizard kangeroo lemur]
  end

  def generate_filename
    filename = "#{filename_adjectives.sample}_#{filename_nouns.sample}.fen"
    return filename unless file_list.include?(filename)

    generate_filename
  end

  def no_saves
    puts no_save_files_msg
    nil
  end

  def select_file
    puts file_list_msg
    selection = gets.chomp
    return selection.to_i if selection.match(/^[0-9]+$/) &&
                             selection.to_i < file_list.length

    puts error_unrecognized_selection
    select_file
  end

  def file_list
    Dir.children(SAVES_DIR)
  end

  def too_many_saves
    puts error_too_many_files
  end
end
