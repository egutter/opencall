class AddVideoLinkToSessionProposal < ActiveRecord::Migration
  def change
    add_column :session_proposals, :video_link, :string
  end
end
