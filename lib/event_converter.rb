class EventConverter
  def self.convert_events(events_data)
    converted_events_data = convert_events_data(events_data)
    converted_events_data.map do |event_data|
      Event.create(event_data)
    end
  end

  private

  def self.convert_events_data(events_data)
    events_data.map do |event|
      event.select do |k, v|
        k == "name" || k == "description"
      end
    end
  end
end