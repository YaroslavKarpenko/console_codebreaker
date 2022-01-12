# frozen_string_literal: true

module ConsoleGame
  module View
    extend self
    def fetch_user_input(question = nil)
      puts question if question
      gets.chomp
    end

    def rules
      display('game.rules')
    end

    def statistics
      display('game.stats')
    end

    def menu
      display('command.menu')
    end

    def obtain_name
      fetch_user_input(I18n.t('registration.name'))
    end

    def obtain_difficulty
      fetch_user_input(I18n.t('game.difficulty', easy: difficulty_output(Codebreaker::Constants::DIFFICULTIES[:easy]),
                                                 medium: difficulty_output(Codebreaker::Constants::DIFFICULTIES[:medium]),
                                                 hell: difficulty_output(Codebreaker::Constants::DIFFICULTIES[:hell])))
    end

    def obtain_guess
      fetch_user_input(I18n.t('game.guess'))
    end

    def obtain_new_game
      fetch_user_input(I18n.t('game.new_game'))
    end

    def obtain_save
      fetch_user_input(I18n.t('game.save_result'))
    end

    def menu_message_error
      display('error.command_error')
    end

    def name_length_error
      display('error.name_length_error')
    end

    def difficulty_input_error
      display('error.difficulty_input_error')
    end

    def guess_input_error
      display('error.guess_input_error')
    end

    def loss(secret_code)
      display('game.loss', secret_code: secret_code)
    end

    def win
      display('game.win')
    end

    def hint(hint)
      puts hint.to_s
    end

    def no_hints
      display('game.no_hints')
    end

    def matrix(matrix)
      display('game.matrix', matrix: matrix)
    end

    private

    def difficulty_output(difficulty)
      difficulty.map { |key, value| "#{key}: #{value}" }.join(', ')
    end

    def display(key, **args)
      puts I18n.t(key, **args)
    end
  end
end
