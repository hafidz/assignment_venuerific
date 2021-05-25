require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods' do
    context 'usersatu?' do
      it 'should returning true' do
        user = build :user
        user.save
      
        expect(user.usersatu?).to eql(true)
      end
    end
  end
end
