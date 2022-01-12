require_relative 'spec_helper'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  let(:game) { described_class.new }
  let(:name) { FFaker::Name.first_name }
  let(:code) { Codebreaker::Constants::SECRET_CODE_RANGE.sample(Codebreaker::Constants::SECRET_CODE_LENGTH).join }
  let(:difficulty) { Codebreaker::Constants::DIFFICULTIES.keys.sample.to_s }

  describe '#run' do
    after do
      game.run
    rescue SystemExit
      nil
    end

    context 'when user finished game' do
      before do
        allow(view_module).to receive(:obtain_guess).and_return(code)
        allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('command.start'), I18n.t('command.exit'))
        allow(view_module).to receive(:obtain_name).and_return(name)
        allow(view_module).to receive(:obtain_difficulty).and_return(difficulty)
        allow(view_module).to receive(:guess_input_error)
        allow(view_module).to receive(:matrix)
        allow(view_module).to receive(:obtain_new_game).and_return(I18n.t('menu.disagree'))
      end

      context 'when user win output win message' do
        before do
          allow(view_module).to receive(:obtain_save).and_return(I18n.t('menu.disagree'))
          allow(view_module).to receive(:obtain_guess).and_return(code)
          allow_any_instance_of(Codebreaker::Game).to receive(:win?).and_return(true, false)
        end

        it { expect { view_module.win }.to output("Congratulations!\n").to_stdout }
      end

      context 'when user lose output lose message' do
        before { allow_any_instance_of(Codebreaker::Game).to receive(:lose?).and_return(true, false) }

        it do
          expect { view_module.loss(code) }.to output("You lose!\nSecret code was: #{code}\n").to_stdout
        end
      end
    end
  end
end
