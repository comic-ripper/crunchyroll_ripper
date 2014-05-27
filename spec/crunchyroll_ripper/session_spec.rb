require 'spec_helper'

describe CrunchyrollRipper::Session, vcr: true do
  subject(:session) {CrunchyrollRipper::Session.new username: username, password: password}
  let(:username) { ENV["CRUNCHYROLL_USERNAME"] }
  let(:password) { ENV["CRUNCHYROLL_PASSWORD"] }

  it "gets an authentication token" do
    expect(session.token).to be_a String
  end


end
