class AddResponseToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :response_to_review, :string
  end
end
