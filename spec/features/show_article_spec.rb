require "rails_helper"

RSpec.feature "Show article details" do
  before do
    @john = User.create!(email: "john@gmail.com", password: "password")
    @bob = User.create!(email: "bob@gmail.com", password: "password")
    @article = Article.create(title: "The first article", body: "Article about TPP", user: @john)
  end
  
  scenario "None signed in user cannot see edit delete button" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "None article owner cannot see edit delete button" do
    login_as @bob
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "Article owner can see edit delete button" do
    login_as @john
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
  
end