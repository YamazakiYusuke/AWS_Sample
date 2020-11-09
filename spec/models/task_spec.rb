require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    before do
      @task = FactoryBot.create(:task, title: 'task', status: '未着手')
      @second_task = FactoryBot.create(:second_task, title: "sample", status: '着手中')
    end
    context 'タイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_scope('task')).to include(@task)
        expect(Task.title_scope('task')).not_to include(@second_task)
        expect(Task.title_scope('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_scope('未着手')).to include(@task)
        expect(Task.status_scope('未着手')).not_to include(@second_task)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_scope('task').status_scope('未着手')).to include(@task)
        expect(Task.title_scope('task').status_scope('未着手')).not_to include(@second_task)
      end
    end
  end
end
