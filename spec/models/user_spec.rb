require 'rails_helper'

RSpec.describe User, :type => :model do
	it "Works" do
		u = User.new
		expect(u).not_to eq(nil)

		assert(not u.nil?)
	end

end
