class RecommendationEngine
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def recommend_events
    event_descriptions = user.events.map {|event| event.description}

    all_words = event_descriptions.map do |description|
      description.split(" ")
    end.flatten.map do |word|
      word.downcase
    end

    sorted_words = all_words.group_by do |word|
      word
    end.map do |k, v|
      [k, v.count]
    end.sort_by do |element|
      element[1]
    end.reverse

    binding.pry
    ""
  end
end
