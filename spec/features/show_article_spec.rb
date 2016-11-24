require "rails_helper"

RSpec.feature "Show article details" do
  before do
    @john = User.create!(email: "john@gmail.com", password: "password")
    
    @article = Article.create(title: "The first article", body: "Article about TPP", user: @john)
  end
  
  scenario "A user show an article" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end