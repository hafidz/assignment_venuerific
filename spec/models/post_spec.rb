require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "save Post" do
    it "should only accept present user_id" do
      post = Post.new(user_id: 1)
      expect{ post.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
