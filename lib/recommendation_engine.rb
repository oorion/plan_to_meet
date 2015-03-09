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
      event_description = event.description.gsub(/[^\w]+/," ")
      TfIdfSimilarity::Document.new(event_description)
    end
    model = TfIdfSimilarity::TfIdfModel.new(corpus)

    top_sorted_terms_by_event = corpus.map do |document|
      tfidf_by_term = {}
      document.terms.each do |term|
        tfidf_by_term[term] = model.tfidf(document, term)
      end
      tfidf_by_term.sort_by{|_,tfidf| -tfidf}[0..5]
    end

    top_sorted_terms_by_tfidf = []
    top_sorted_terms_by_event.each do |event_top_terms|
      event_top_terms.each do |term|
        if !(term.length < 4)
          top_sorted_terms_by_tfidf << term
        end
      end
    end
    top_sorted_terms_by_tfidf = top_sorted_terms_by_tfidf.sort_by do |e|
      -e[1]
    end

    binding.pry
  end
end
