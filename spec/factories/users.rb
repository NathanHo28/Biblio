FactoryGirl.define do
  factory :user do
    first_name "Greg"
    last_name "Johnson"
    username "gjohnson"
    email "gi.joe@armyfan.com"
    password "justguess"
    password_confirmation "justguess"
  end
end