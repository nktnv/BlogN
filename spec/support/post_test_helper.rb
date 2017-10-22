module PostTestHelper

  def create_post(title, summary, body)
    click_link 'Create new post'
    fill_in 'post[title]', with: title
    fill_in 'post[summary]', with: summary
    fill_in 'post[body]', with: body
    click_button 'Create Post'
  end

  def edit_post(title, new_title = nil)
    open_posts_details(title)
    click_link 'Edit'
    fill_in 'post[title]', with: ''
    fill_in 'post[title]', with: (new_title.nil? ? Faker::Lorem.word : new_title)
    click_button 'Update Post'
    visit root_path
  end

  def open_posts_details(title)
    visit root_path
    click_link title
  end

  def delete_post_link
    'a[data-method="delete"][href*="/posts/"]'
  end

  def post_id_by_body(body)
    Post.where(body: body).first.id
  end

  def get_to_post(id)
    get "/posts/#{id}"
  end

end
