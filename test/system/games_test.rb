require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid" do
    visit new_url
    page.fill_in 'user_name', with: 'Bob'
    page.click_on "Ask"
    assert test: "Used letters that aren't part of the given sequence"
  end

  test "You can fill the form with a one-letter consonant word, click play, and get a message it’s not a valid English word" do
    visit new_url
    page.fill_in 'user_name', with: 'K'
    page.click_on "Ask"
    assert test: "Not an English word!"
  end

  test 'You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message' do
    visit new_url
    page.fill_in 'user_name', with: 'Hi'
    page.click_on "Ask"
    assert test: "yay!"
  end
end
