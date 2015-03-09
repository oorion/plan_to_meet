require 'matrix'
require 'tf-idf-similarity'

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

    corpus = user.events.map do |event|
      TfIdfSimilarity::Document.new(event.description)
    end
    model = TfIdfSimilarity::TfIdfModel.new(corpus)

    top_sorted_terms = corpus.map do |document|
      tfidf_by_term = {}
      document.terms.each do |term|
        tfidf_by_term[term] = model.tfidf(document, term)
      end
      tfidf_by_term.sort_by{|_,tfidf| -tfidf}.first[0]
    end

    binding.pry
  end
end
