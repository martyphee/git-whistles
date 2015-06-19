require 'blanket'

class PivotalTrackerService

  module ClassMethods

    def token
      @token ||= `git config pivotal-tracker.token`.strip || ENV['PT_TOKEN']
      if @token.empty?
        puts Term::ANSIColor.yellow %Q{
        Your branch appears to have a story ID,
        but I don't know your Pivotal Tracker token!
        Please set it with:
        $ git config [--global] pivotal-tracker.token <token>
      }
        die "Aborting."
      end
      @token
    end

    def api
      @api ||= Blanket::wrap('https://www.pivotaltracker.com/services/v5/', headers: { 'X-TrackerToken' => token}, extension: :json)
    end
  end

  extend ClassMethods
end