require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク管理機能', type: :system do
    describe '新規作成機能' do
      context 'タスクを新規作成した場合' do
        it '作成したタスクが表示される' do
          visit new_task_path
          fill_in 'task[title]', with: 'テストタイトル'
          fill_in 'task[content]', with: 'テストコンテンツ'

          click_on '登録する'

          expect(page).to have_content 'テストタイトル'
          expect(page).to have_content 'テストコンテンツ'
        end
      end
    end
  end

  describe '一覧表示機能' do
    before do
      task = FactoryBot.create(:task, title: 'task')
      task = FactoryBot.create(:task, title: 'newest')
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # expect(page).to have_content 'newest'
        # task_list = all('tbody tr') 
        expect(all('tbody tr')[0]).to have_content 'newest'
        # expect(page).to have_selector 'tbody tr', text: 'newest'
        # expect.first('tbody tr').to have_content 'newest'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        click_on '詳細'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
      end
    end
  end
end