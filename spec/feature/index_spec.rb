require 'spec_helper'

describe "index", :type => :feature do
  include Capybara::DSL

  it "loads" do
    visit "/"
    expect(page).to have_selector('h1')
  end

end
