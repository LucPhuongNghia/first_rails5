require "rails_helper"

RSpec.feature "Listing articles" do
  before do
    @john = User.create!(email: "john@gmail.com", password: "password")
    
    @article1 = Article.create(title: "first article", body: "This is the first article", user: @john)
    @article2 = Article.create(title: "Second article", body: "This is the second article", user: @john)
  end
  
  scenario "A none signed in user can see all articles" do
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    
    expect(page).not_to have_link("New Article")
  end
  
  scenario "A signed in user can create new article" do
    login_as @john
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    
    expect(page).to have_link("New Article")
  end
  
  
  
  scenario "A user has no article to list" do
    Article.delete_all
    visit "/"
    
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    
    within ("h1#no-articles") do
      expect(page).to have_content("No article created")
    end
  end
end