require 'matrix'
require 'tf-idf-similarity'

class RecommendationEngine
  KEYWORDS_PER_EVENT = 5
  MINIMUM_KEYWORD_LENGTH = 4
  attr_reader :user, :corpus, :model

  def initialize(user)
    @user = user
    @corpus = create_corpus
    @model = create_model
  end

  def create_corpus
    #maybe pull in all the events that are near me to add to corpus
    user.events.map do |event|
      event_description = event.description.gsub(/[^\w]+/," ")
      TfIdfSimilarity::Document.new(event_description)
    end
  end

  def create_model
    TfIdfSimilarity::TfIdfModel.new(corpus)
  end

  def recommend_events
    #account for people that haven't rsvped to many events.  possibly base it off their interests and/or categories of their groups
    top_event_keywords = top_x_terms_by_event(KEYWORDS_PER_EVENT)
    top_sorted_terms_by_tfidf = []
    top_event_keywords.each do |event_top_terms|
      event_top_terms.each do |term|
        if term[0].length > MINIMUM_KEYWORD_LENGTH
          top_sorted_terms_by_tfidf << term
        end
      end
    end
    top_sorted_terms_by_tfidf = top_sorted_terms_by_tfidf.sort_by do |e|
      -e[1]
    end

    binding.pry
  end

  def top_x_terms_by_event(num_of_terms_per_event)
    corpus.map do |document|
      tfidf_by_term = {}
      document.terms.each do |term|
        tfidf_by_term[term] = model.tfidf(document, term)
      end
      tfidf_by_term.sort_by{|_,tfidf| -tfidf}[0..num_of_terms_per_event]
    end
  end
end
