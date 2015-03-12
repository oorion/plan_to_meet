require 'matrix'
require 'tf-idf-similarity'

class RecommendationEngine
  KEYWORDS_PER_EVENT = 5
  MINIMUM_KEYWORD_LENGTH = 4
  attr_reader :user, :corpus, :model, :top_keywords_by_tfidf

  def initialize(user)
    @user = user
    @corpus = create_corpus
    @model = create_model
  end

  def create_corpus
    user.events.map do |event|
      event_description = event.description.gsub(/[^\w]+/," ")
      TfIdfSimilarity::Document.new(event_description)
    end
  end

  def create_model
    TfIdfSimilarity::TfIdfModel.new(corpus)
  end

  def recommend_events(upcoming_events)
    top_keywords_by_event = top_x_terms_by_event(KEYWORDS_PER_EVENT)
    @top_keywords_by_tfidf = top_terms_by_tfidf(top_keywords_by_event)
    events_occurring_within_one_week = filter_by_datetime(upcoming_events, 7)
    top_events = filter_by_keyword(events_occurring_within_one_week)
    top_events.each {|e| puts "
                     #{e[0].name} =>
                     #{e[2]} keyword matches\n
                     #{e[1]}\n
                     #{DateTime.strptime((e[0].utc_offset + e[0].time).to_s, '%Q')}"
                     }
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

  def top_terms_by_tfidf(top_keywords_by_event)
    top_sorted_terms_by_tfidf = []
    top_keywords_by_event.each do |event_top_terms|
      event_top_terms.each do |term|
        if term[0].length > MINIMUM_KEYWORD_LENGTH
          top_sorted_terms_by_tfidf << term
        end
      end
    end
    top_sorted_terms_by_tfidf = top_sorted_terms_by_tfidf.sort_by do |e|
      -e[1]
    end.map do |e|
      e[0]
    end.uniq
  end

  def filter_by_keyword(events)
    events.reject do |event|
      event.description.nil?
    end.map do |event|
      split_description = event.description.split(" ")
      matching_keywords = top_keywords_by_tfidf.select do |keyword|
        split_description.include?(keyword)
      end
      keyword_count = matching_keywords.count
      [event, matching_keywords, keyword_count]
    end.sort_by do |data|
      -data.last
    end
  end

  def filter_by_datetime(events, number_of_days)
    date_filter = DateTime.now.to_i + (60 * 60 * 24 * number_of_days)
    events.select do |event|
      datetime = DateTime.strptime((event.utc_offset + event.time).to_s, "%Q").to_i
      datetime < date_filter
    end
  end
end
