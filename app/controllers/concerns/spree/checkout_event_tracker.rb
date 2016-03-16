module Spree
  module CheckoutEventTracker
    extend ActiveSupport::Concern

    def track_activity(attributes)
      default_attributes = {
                             referrer: request.referrer,
                             actor: spree_current_user,
                             object: @order,
                             session_id: session.id
                            }
      Spree::Checkout::Event::Tracker.new(default_attributes.merge(attributes)).track
    end

    def get_next_state
      @next_state ||= request.url.split('/').last
    end

    def get_previous_state
      @previous_state ||= (request.referrer ? request.referrer.split('/').last : nil)
    end

  end
end
