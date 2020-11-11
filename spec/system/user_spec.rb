require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe '一般User登録機能' do
    context 'Userの新規登録ができる' do
      before do
        visit new_user_path
      end
      it 'ヘッダーにマイページへ、ログアウトが表示される' do
        fill_in 'user[name]', with: 'Yokoi'
        fill_in 'user[email]', with: 'yokoi@gmail.com'
        fill_in 'user[password]', with: 'hogehoge'
        fill_in 'user[password_confirmation]', with: 'hogehoge'
        click_on 'commit'

        expect(page).to have_content 'マイページへ'
        expect(page).to have_content 'ログアウト'
      end
    end

    context '未ログインでindexを表示すると、ログイン画面に戻される' do
      it 'ログインしてくださいが表示される' do
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end


  describe 'セッション機能' do
    context 'ログインができる' do
      before do
        FactoryBot.create(:user)
        visit new_session_path
      end
      it 'ヘッダーにマイページへ、ログアウトが表示される' do
        fill_in 'session[email]', with: 'yokoi@gmail.com'
        fill_in 'session[password]', with: 'hogehoge'
        click_on 'commit'

        expect(page).to have_content 'マイページへ'
        expect(page).to have_content 'ログアウト'
      end
    end

    context 'ログイン時' do
      before do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'yokoi@gmail.com'
        fill_in 'session[password]', with: 'hogehoge'
        click_on 'commit'
      end
      it 'マイページに飛べる' do
        click_on 'マイページへ'
        expect(page).to have_content '全タスク数 '
        expect(page).to have_content '登録メールアドレス '
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        FactoryBot.create(:user, name: 'Tanaka', email: 'Tanaka@gmail.com')
        visit user_path(User.find_by(name:'Tanaka').id)
        expect(page).to have_content 'このページにはアクセスできません'
      end
      it 'ログアウトができる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end

      it '一般Userは管理画面にアクセスできない' do
        click_on '管理者画面'
        expect(page).to have_content '管理権限がありません'
      end
    end
  end

  
  describe '管理者機能' do
    context '管理者User' do
      before do
        FactoryBot.create(:user, admin:'true')
        visit new_session_path
        fill_in 'session[email]', with: 'yokoi@gmail.com'
        fill_in 'session[password]', with: 'hogehoge'
        click_on 'commit'
      end

      it '管理Userは管理画面にアクセスできる' do
        click_on '管理者画面'
        expect(page).to have_content '管理者画面 User一覧'
      end

      it '管理UserはUserの新規登録ができる' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'Yokoi'
        fill_in 'user[email]', with: 'tanaka@gmail.com'
        fill_in 'user[password]', with: 'hogehoge'
        fill_in 'user[password_confirmation]', with: 'hogehoge'
        click_on 'commit'
      end
      
      it '管理UserはUserの編集画面からUserを編集できる' do
        visit admin_users_path
        click_on '投稿を編集'
        fill_in 'user[name]', with: 'Mr.Yokoi'
        fill_in 'user[password]', with: 'hogehoge'
        fill_in 'user[password_confirmation]', with: 'hogehoge'
        click_on 'commit'
        expect(page).to have_content 'Mr.Yokoi'
      end

      it '管理UserはUserの削除' do
        FactoryBot.create(:user, name: 'Tanaka', email: 'Tanaka@gmail.com')
        visit admin_users_path
        expect(page).to have_content 'Tanaka'
        all('tbody tr')[1].click_on '投稿を削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'Tanaka'
      end
    end
  end
end