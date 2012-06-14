FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  
    factory :admin do
      admin true
    end
  end
  
  factory :firm do
    sequence(:name)  { |n| "Firm #{n}" }
    sequence(:corporate_id) { |n| "Corporate Id #{n}"}   
    sequence(:location)  { |n| "Location #{n}" } 
  end
end
