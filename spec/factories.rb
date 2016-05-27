FactoryGirl.define do
  factory :user do
    username 'testuser'

    factory :user_with_hashed_strings do
      transient do
        string_count 3
      end

      after :create do |user, evaluator|
        build_list(:hashed_string, evaluator.string_count, user: user)
      end
    end
  end

  factory :hashed_string do
    original 'input_to_hash'
    user

    factory :hashed_string_without_user do
      association :user, strategy: :null
    end
  end
end
