require "rails_helper"

RSpec.feature "Show article details" do
  before do
    @article = Article.create(title: "The first article", body: "Article about TPP")
  end
  
  scenario "A user show an article" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end