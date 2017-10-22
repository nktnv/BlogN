module CommentTestHelper

  def comment_xpath(message)
    "//div[contains(@id,'comment')]//p[text()='#{message}']"
  end

  def send_comment_button
    'input[value="Send comment"]'
  end

  def add_posts_comment(post_titile, message)
    open_posts_details(post_titile)
    fill_in 'comment[body]', with: message
    click_button 'Send comment'
  end

  def interact_wih_comment(action, parent_comments_text, message = nil)
    find(:xpath, "//p[text()='#{parent_comments_text}']/ancestor::*[@class='comment-message']/following-sibling::*//*[text()='#{action}']").click
    case action
    when 'Edit'
      fill_in 'comment[body]', with: ''
      fill_in 'comment[body]', with: message
      click_button 'Update Comment'
    when 'Delete'
    when 'Reply'
      fill_in 'comment[body]', with: message
      click_button 'Send comment'
    else
      raise ArgumentError, "message: #{action} is not supported"
    end
  end

end
