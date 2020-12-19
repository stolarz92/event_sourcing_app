class Events::BaseEvent < ActiveRecord::Base
  self.abstract_class = true

  after_initialize do
    self.event_type = event_type
    self.payload ||= {}
  end

  before_create :apply_and_persist

  def apply(aggregate)
    raise NotImplementedError
  end

  def event_type
    self.attributes["event_type"] || self.class.to_s.split("::").last
  end

  private def apply_and_persist
    # Lock the database row! (OK because we're in an ActiveRecord callback chain transaction)
    aggregate.lock! if aggregate.persisted?

    # Apply!
    self.aggregate = apply(aggregate)

    #Persist!
    aggregate.save!

    # Update aggregate_id with id from newly created User
    self.aggregate_id = aggregate.id if aggregate_id.nil?
  end
end
