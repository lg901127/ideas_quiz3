require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  # let(:idea) { create(:idea) }
  let(:idea) {Idea.create(title: "a", body: "b")}
  let(:user) {User.create(first_name: "a", last_name: "b", email: "1@1.com", password: "Pa$$w0rd") }
  let(:comment) {Comment.create(body: "abc") }
  describe "#create" do
    context "valid" do
      context "with user not signed in" do
        it "redirects to login page" do
          post :create, idea_id: idea.id, comment: comment
          expect(response).to redirect_to(new_session_path)
        end
      end
      context "with user signed in" do
        before { request.session[:user_id] = user.id }
        def valid_request
          post :create, idea_id: idea.id, user_id: user.id, comment: comment
        end
        it "creates a comment" do
          # byebug
          expect { valid_request }.to change { Comment.count }.by(1)
        end
        it "associates the comment to the idea" do
          valid_request
          expect(Comment.last.idea).to eq(idea)
        end
        it "associates the comment to the user" do
          valid_request
          expect(Comment.last.user).to eq(user)
        end
        it "redirects to the product page" do
          valid_request
          expect(response).to redirect_to(idea_path(idea))
        end
      end
    end
  end

  describe "#delete" do
    it "removes the record from the database" do
      comment
      count_before = Comment.count
      delete :destroy, id: comment.id, idea_id: comment.idea_id
      count_after = Comment.count
      expect(count_before).to eq(count_after + 1)
    end
    it "redirects to campaigns_path (listings page)" do
      delete :destroy, id: campaign.id
      expect(response).to redirect_to(campaigns_path)
    end
  end
end
