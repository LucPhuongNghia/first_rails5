require "rails_helper"

RSpec.feature "Delete an article" do
  before do
    @john = User.create!(email: "john@gmail.com", password: "password")
    login_as(@john)
    @article = Article.create(title: 'New article', body: "Article body", user: @john)
  end
  
  scenario "An user delete an article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content("An article was deleted")
    expect(current_path).to eq(articles_path)
  end
end