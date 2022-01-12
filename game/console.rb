# frozen_string_literal: true

require 'pry'

require_relative 'autoloader'

class Console
  include ConsoleGame
  def run
    loop do
      View.menu
      case View.fetch_user_input
      when I18n.t('command.start') then start_game
      when I18n.t('command.rules') then View.rules
      when I18n.t('command.statistics') then statistics
      when I18n.t('command.exit') then exit
      else View.menu_message_error end
    end
  end

  def start_game
    @codebreaker_game = Codebreaker::Game.new
    registration
    @codebreaker_game.available_difficulties

    game
  end

  def statistics
    View.statistics
    puts Terminal::Table.new(
      headings: ['Name', 'Difficulty', 'Attempts Total', 'Hints Total', 'Attempts Used', 'Hints Used'],
      rows: Codebreaker::Statistics.new.show_statistics.map(&:values)
    )
  end

  def registration
    input_name
    input_difficulty
    @codebreaker_game.assign_difficulty
  end

  def input_name
    loop do
      name = View.obtain_name

      break @codebreaker_game.user = Codebreaker::User.new(name: name)
    rescue LengthError
      View.name_length_error
    end
  end

  def input_difficulty
    loop do
      difficulty = View.obtain_difficulty

      if difficulty_accessible?(difficulty)
        @codebreaker_game.difficulty = difficulty.to_sym
        break
      else
        View.difficulty_input_error
      end
    end
  end

  def game
    loop { break if game_ended? || exit_conditions }
    new_game
  end

  def game_ended?
    return unless @codebreaker_game.lose?

    View.loss(@codebreaker_game.secret_code)
    true
  end

  def exit_conditions
    case guess = View.obtain_guess
    when I18n.t('command.exit') then exit
    when I18n.t('game.hint') then hint
    else guess_passed(guess) end
  end

  def new_game
    start if View.obtain_new_game == I18n.t('command.agree')
  end

  def hint
    @codebreaker_game.check_for_hints? ? View.hint(@codebreaker_game.use_hint) : View.no_hints
  end

  def guess_passed(guess)
    matrix = @codebreaker_game.display_matrix(guess.chars.map(&:to_i))
    @codebreaker_game.win?(guess.chars.map(&:to_i)) ? win_output : View.matrix(matrix)
  rescue InputError
    View.guess_input_error
  end

  def win_output
    View.win
    save
  end

  def save
    @codebreaker_game.save_game(@codebreaker_game) if View.obtain_save == I18n.t('command.agree')
  end

  def difficulty_accessible?(difficulty)
    @codebreaker_game.available_difficulties.keys.map(&:to_s).include?(difficulty)
  end
end
