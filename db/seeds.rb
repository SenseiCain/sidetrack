10.times do |i|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email(name: first_name),
        password: 'test'
    )
end

['politics', 'funny', 'gaming', 'tech', 'programming', 'tesla'].each do |i|
    Category.create(name: i)
end

20.times do |i|
    rand_time = 

    post = Post.create(
        title: Faker::Marketing.buzzwords,
        description: Faker::Movies::Lebowski.quote,
        user: User.all.sample,
        created_at: Time.at(Time.now - rand * (Time.now.to_f - Time.local(2019, 12, 1).to_f))
    )

    # GENERATE CATEGORIES
    categories = []
    Random.new.rand(3).times do |i|
        categories << Category.all.sample
    end

    post.categories << categories

    # GENERATE UPVOTES & DOWNVOTES
    if i > 10
        Vote.create_upvote(User.all.sample, post)
        Vote.create_upvote(User.all.sample, post)
    else
        Vote.create_downvote(User.all.sample, post)
        Vote.create_downvote(User.all.sample, post)
    end

    # GENERATE COMMENTS
    Random.new.rand(3).times do |i|
        post.comments.build(description: 'test', user: User.all.sample)
        post.save
    end
end

def time_rand
    Time.at(from + rand * (Time.now.to_f - Time.local(2018, 1, 1).to_f))
end