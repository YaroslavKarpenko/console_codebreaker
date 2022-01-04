require_relative 'spec_helper'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  let(:game) { described_class.new }
  let(:invalid_command) { 'q' * 4 }

  describe '#run' do
    before do
      stub_const('Codebraker::FileStore::FILE_NAME', 'gamers.yml')
      stub_const('Codebraker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
    end

    after do
      game.run
    rescue SystemExit
      nil
    end

    context 'when user entered rules return rules' do
      before do
        allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('command.rules'), I18n.t('command.exit'))
      end

      it { expect(view_module).to receive(:rules) }
    end

    context 'when user enteres statistics return stats' do
      before do
        allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('command.statistics'),
                                                                    I18n.t('command.exit'))
      end

      it { expect(view_module).to receive(:statistics) }
    end

    context 'when user entered exit leave app' do
      before { allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('command.exit')) }

      it { expect { game.run }.to raise_error(SystemExit) }
    end

    context 'when user entered wrong command return error' do
      before do
        allow(view_module).to receive(:fetch_user_input).and_return(invalid_command, I18n.t('command.exit'))
        allow(view_module).to receive(:menu)
      end

      it { expect(view_module).to receive(:menu_message_error) }
    end
  end
end
