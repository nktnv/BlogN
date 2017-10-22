module VoteTestHelper

  def votes(attitude)
    find(:xpath, "//*[contains(@class,'post-body')]/following-sibling::div//span[@class='#{attitude}']")
  end

  def posts_votes(attitude)
    votes(attitude).text.to_i
  end

  def vote_the_post(attitude)
    votes(attitude).find(:xpath, "./following-sibling::*[contains(@class,'#{attitude}')]").click
  end

  def votes_counter(attitude)
    "span.#{attitude}"
  end

end
