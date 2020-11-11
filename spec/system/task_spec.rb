require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク管理機能', type: :system do
    describe '新規作成機能' do
      before do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'yokoi@gmail.com'
        fill_in 'session[password]', with: 'hogehoge'
        click_on 'commit'
        visit new_task_path
      end
      context 'タスクを新規作成した場合' do
        it '作成したタスクが表示される' do
          fill_in 'task[title]', with: 'テストタイトル'
          fill_in 'task[content]', with: 'テストコンテンツ'
          select '未着手', from: 'task[status]'
          click_on '登録する'

          expect(page).to have_content 'テストタイトル'
          expect(page).to have_content 'テストコンテンツ'
          expect(page).to have_content '未着手'
        end
      end
    end
  end

  describe '一覧表示機能' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'session[email]', with: 'yokoi@gmail.com'
      fill_in 'session[password]', with: 'hogehoge'
      click_on 'commit'
      FactoryBot.create(:task, title: 'task',limit: '2021-11-04 07:30:25', priority: '低', user_id: User.find_by(name:'Yokoi').id )
      FactoryBot.create(:task, title: 'newest',limit: '2021-10-04 07:30:25', priority: '高', user_id: User.find_by(name:'Yokoi').id )
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        expect(all('tbody tr')[0]).to have_content 'newest'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      # ↓ テスト結果不安定 failure 時、スクショを確認しても失敗の要因確認できず
      it '終了期限で降順で表示される' do
        click_on '終了期限▽'
        expect(all('tbody tr')[0]).to have_content 'task'
      end
    end

    context 'タスクが優先順位の降順に並んでいる場合' do
      # ↓ テスト結果不安定 failure 時、スクショを確認しても失敗の要因確認できず
      it '優先順位で降順で表示される' do
        click_on '優先度▽'
        expect(all('tbody tr')[0]).to have_content 'newest'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'session[email]', with: 'yokoi@gmail.com'
      fill_in 'session[password]', with: 'hogehoge'
      click_on 'commit'
      FactoryBot.create(:task, user_id: User.find_by(name:'Yokoi').id )
      visit tasks_path
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        click_on '詳細'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'session[email]', with: 'yokoi@gmail.com'
      fill_in 'session[password]', with: 'hogehoge'
      click_on 'commit'

      FactoryBot.create(:task, title: "task", user_id: User.find_by(name:'Yokoi').id)
      FactoryBot.create(:second_task, title: "sample", status: '着手中', user_id: User.find_by(name:'Yokoi').id)
      FactoryBot.create(:task, title: "GoToTravel", status: '未着手', user_id: User.find_by(name:'Yokoi').id)
      FactoryBot.create(:task, title: "GoToTravel", status: '着手中', user_id: User.find_by(name:'Yokoi').id)
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'task[sarch_title]', with: 'tas'
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '未着手', from: 'task[sarch_status]'
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'task[sarch_title]', with: 'GoTo'
        select '未着手', from: 'task[sarch_status]'
        click_on '検索'
        expect(page).to have_content 'GoToTravel'
        expect(page).to have_content '未着手'
      end
    end
  end
end