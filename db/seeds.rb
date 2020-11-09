
20.times do |n|
  fake_name = Faker::Name.name 

  title = ['テスト勉強する','カニ食べる','旅行に行く','買い物に行く'].sample
  content = "#{fake_name}は#{title}"
  updated_at = Faker::Time.between(from: DateTime.now - 100, to: DateTime.now)
  limit = Faker::Time.between(from: DateTime.now - 100, to: DateTime.now)
  status = ['未着手','着手中','完了'].sample
  priority = ['低','中','高'].sample

  Task.create!(
    title: title,
    content: content,
    updated_at: updated_at,
    limit: limit,
    status: status,
    priority: priority,
  )
end